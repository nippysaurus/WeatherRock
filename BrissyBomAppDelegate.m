//
//  BrissyBomAppDelegate.m
//  BrissyBom
//
//  Created by Michael Dawson on 13/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "BrissyBomAppDelegate.h"

// --- private interface ---------------------------------------------------------------------------

@interface BrissyBomAppDelegate ()

-(void)scheduleNextDownload;

-(void)updateEverythingStarter;

-(void)updateEverything;

-(void)populateLocationsMenu;

-(void)updateLocationMenuCheckboxThing;

-(NSImage*)layerImage:(NSImage*)bottomImage underImage:(NSImage*)topImage;

-(NSImage*)getResourceImageWithName:(NSString*)name;

-(NSImage*)getImageWithLayers:(NSArray*)layers;

-(void)setRadarImageWithLayers:(NSArray*)layers;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation BrissyBomAppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	//RadarView* fkbrkb = [[RadarView alloc] init];
	//[radarMenuItem setView:fkbrkb];
	
	//[radarMenuItem setView:radarView];
	
	[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Welcome", nil]];
	
	// populate locations menu
	[self populateLocationsMenu];
	
	// register to be notified when location becomes available
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(locationAvailable:)
												 name:@"LocationAvaiable"
											   object:nil];
	
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setAlternateImage:[Configuration sharedManager].Icon_L0Alt];
	[statusItem setImage:[Configuration sharedManager].Icon_L0];
	[statusItem setHighlightMode:YES];

	failures = 0;
	
	location = [[Location alloc] init];

	//radarView.radarImage = [Configuration sharedManager].DownloadingRadarImage;
	[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Welcome", nil]];

	[downloadTimer retain];
	
	NSString* directory = [Helpers pathFromUserLibraryPath:@"BrissyBom"];
	[[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
	
	// only enable feedback menu item if Mail.app is the default mail app
	NSString* defaultMailApplication = [Helpers defaultMailApplication];
	NSString* mailAppPath = @"file://localhost/Applications/Mail.app/";
	[feedbackMenuItem setHidden:[defaultMailApplication isEqual:mailAppPath] == NO];
	
	[pool drain];
}

-(void)setIconsForScore:(int)score
{
	if (score < [[Configuration sharedManager].Threshold_L1 intValue])
	{
		NSLog(@"applying level 0 icons");
		[statusItem setAlternateImage:[Configuration sharedManager].Icon_L0Alt];
		[statusItem setImage:[Configuration sharedManager].Icon_L0];
	}
	else if (score < [[Configuration sharedManager].Threshold_L2 intValue])
	{
		NSLog(@"applying level 1 icons");
		[statusItem setAlternateImage:[Configuration sharedManager].Icon_L1Alt];
		[statusItem setImage:[Configuration sharedManager].Icon_L1];
	}
	else if (score < [[Configuration sharedManager].Threshold_L3 intValue])
	{
		NSLog(@"applying level 2 icons");
		[statusItem setAlternateImage:[Configuration sharedManager].Icon_L2Alt];
		[statusItem setImage:[Configuration sharedManager].Icon_L2];
	}
	else
	{
		NSLog(@"applying level 3 icons");
		[statusItem setAlternateImage:[Configuration sharedManager].Icon_L3Alt];
		[statusItem setImage:[Configuration sharedManager].Icon_L3];
	}
}

-(void)scheduleNextDownload
{
	NSNumber* minutesUntilNextDownload = nil;
	
	if (failures == 0)
		minutesUntilNextDownload = [Configuration sharedManager].IntervalAfterSuccess;
	else if (failures == 1)
		minutesUntilNextDownload = [Configuration sharedManager].IntervalAfterFirstFailure;
	else
		minutesUntilNextDownload = [Configuration sharedManager].IntervalAfterSubsequentFailures;
	
	int secondsUntilNextDownload = [minutesUntilNextDownload intValue] * 60;

	NSLog(@"minutesUntilNextDownload = %@", minutesUntilNextDownload);
	NSLog(@"secondsUntilNextDownload = %i", secondsUntilNextDownload);
	
	if (downloadTimer != nil)
		[downloadTimer release];

	NSDate* fireDownloadTimerAt = [NSDate dateWithTimeIntervalSinceNow:secondsUntilNextDownload]; // aut
	
	downloadTimer = [[NSTimer alloc] initWithFireDate:fireDownloadTimerAt
											 interval:0
											   target:self
											 selector:@selector(updateEverythingStarter)
											 userInfo:nil
											  repeats:NO]; // 1
}

#pragma mark -
#pragma mark Location

-(void)locationAvailable:(NSNotification*)notification
{
	NSDictionary* userInfo = [notification userInfo];
	
	NSString* newLocation = [userInfo objectForKey:@"location"];
	
	NSLog(@"location available: %@", newLocation);
	
	[[NSUserDefaults standardUserDefaults] setValue:newLocation forKey:@"CurrentLocation"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self updateLocationMenuCheckboxThing];
	
	[self updateEverythingStarter];
	
	// TODO do some more checking and whatnot to allow the location to change
	// while the application is running.
}

-(void)populateLocationsMenu
{
	Configuration* configuration = [Configuration sharedManager];
	
	for (id key in configuration.Locations)
	{
		NSMenuItem* menuItem = [[NSMenuItem alloc] initWithTitle:key 
														  action:@selector(setLocation:)
												   keyEquivalent:@""]; // 1
		
		[locationsMenu addItem:menuItem];
		
		[menuItem release];
	}
	
	[self updateLocationMenuCheckboxThing];
}

// upate which location is checked in the locations menu
-(void)updateLocationMenuCheckboxThing
{
	NSString* currentLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"]; // auto
	
	for (id menuItem in locationsMenu.itemArray)
	{
		NSInteger state = [[menuItem title] isEqualToString:currentLocation] == YES ? 1 : 0; // stack
		[menuItem setState:state];
	}
}

#pragma mark -
#pragma mark Image Modification

-(NSImage*)layerImage:(NSImage*)bottomImage underImage:(NSImage*)topImage
{
	NSImage* base = [bottomImage copy];

	[base lockFocus];
	
	NSPoint rge; // point [0,0]
	rge.x = 0; // might not need this?
	rge.y = 0; // might not need this?
	
	[topImage drawAtPoint:rge
			  fromRect:NSZeroRect
			 operation:NSCompositeSourceOver
			  fraction:1.0];
	
	[base unlockFocus];
	
	return [base autorelease];
}

//-(NSImage*)cropImage:(NSImage*)image toRect:(NSRect)rect
//{
//    NSAffineTransform * xform = [NSAffineTransform transform];
//	
//    // translate reference frame to map rectangle 'rect' into first quadrant
//    [xform translateXBy: -rect.origin.x
//                    yBy: -rect.origin.y];
//    
//    NSSize canvas_size = [xform transformSize: rect.size];
//	
//    NSImage* canvas = [[NSImage alloc] initWithSize: canvas_size];
//    [canvas lockFocus];
//	
//    [xform concat];
//    
//    // Get NSImageRep of image
//    NSImageRep * rep = [image bestRepresentationForDevice: nil];
//	
//    [rep drawAtPoint: NSZeroPoint];
//    
//    [canvas unlockFocus];
//    return [canvas autorelease];
//}

//-(NSImage*)createDisplayWithImage:(NSImage*)image
//			   withDistrictsLayer:(BOOL)districts
//			   withWaterwaysLater:(BOOL)waterways
//			  withTopographyLayer:(BOOL)topography
//				   withRoadsLayer:(BOOL)roads
//					withRageLayer:(BOOL)range
//					withRailLayer:(BOOL)rail
//			   withLocationsLayer:(BOOL)locations
//			  withCatchmentsLayer:(BOOL)catchments
//			  withBackgroundLayer:(BOOL)background
//{
//	NSImage* result = [self transparencyWithName:@"BackgroundTransparencyTemplate"];
//
//	if (districts == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"DistrictsTransparencyTemplate"]];
//
//	if (waterways == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"WaterwaysTransparencyTemplate"]];
//	
//	if (topography == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"TopographyTransparencyTemplate"]];
//	
//	if (roads == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"RoadsTransparencyTemplate"]];
//
//	if (range == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"RangeTransparencyTemplate"]];
//	
//	if (rail == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"RailTransparencyTemplate"]];
//	
//	if (locations == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"LocationsTransparencyTemplate"]];
//	
//	if (catchments == YES)
//		result = [self layerImage:result underImage:[self transparencyWithName:@"CatchmentsTransparencyTemplate"]];
//	
//	// layer actual radar image
//	if (image != nil)
//		result = [self layerImage:result underImage:image];
//
//	if (YES)
//	{
//		NSRect jnreibjre;
//		jnreibjre.origin.x = 18;
//		jnreibjre.origin.y = 18;
//		jnreibjre.size.height = [result size].height - 36;
//		jnreibjre.size.width = [result size].width - 36;
//		
//		result = [self cropImage:result toRect:jnreibjre];
//	}
//	
//	return result;
//}

//-(NSImage*)transparencyWithName:(NSString*)transparencyName
//{
//	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//	
//	Configuration* configuration = [Configuration sharedManager];
//	
//	NSString* currentLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"]; // auto
//	
//	// radar name like this: IDR663
//	NSString* radar = [configuration.Locations valueForKey:currentLocation]; // auto
//	
//	// url like this: ftp://ftp2.bom.gov.au/anon/gen/radar_transparencies/%@.topography.png
//	NSString* backgroundTransparencyTemplate = [configuration.TransparencyTemplates valueForKey:transparencyName]; // auto
//	
//	// url like this: ftp://ftp2.bom.gov.au/anon/gen/radar_transparencies/IDR663.topography.png
//	NSString* backgroundTransparencyTemplateUrlString = [NSString stringWithFormat:backgroundTransparencyTemplate, radar]; // auto
//	
//	NSURL* backgroundTransparencyTemplateUrl = nil;
//	
//	if ([transparencyName isEqualToString:@"BackgroundTransparencyTemplate"] == YES)
//	{
//		NSBundle* mainBundle = [NSBundle mainBundle];
//		NSString* BackgroundImagePath = [mainBundle pathForImageResource:backgroundTransparencyTemplateUrlString]; // TEMP
//		NSString* kbergkbger = [NSString stringWithFormat:@"file://%@", BackgroundImagePath];
//		backgroundTransparencyTemplateUrl = [NSURL URLWithString:kbergkbger]; // auto
//	}
//	else
//	{
//		backgroundTransparencyTemplateUrl = [NSURL URLWithString:backgroundTransparencyTemplateUrlString]; // auto
//	}
//
//	NSData* backgroundTransparencyTemplateData = [NSData dataWithContentsOfURL: backgroundTransparencyTemplateUrl]; // auto
//
//	NSImage* result = [[NSImage alloc] initWithData:backgroundTransparencyTemplateData];
//	
//	[pool release];
//	
//	return [result autorelease];
//}

-(NSImage*)getResourceImageWithName:(NSString*)name
{
	//
	NSDictionary* layers = [[Configuration sharedManager] Layers];
	
	id value = [layers valueForKey:name];
	
	if (value == nil)
		return nil;
	
	NSString* actualFileNameToLookFor = nil;
	
	if ([name isEqualToString:@"Welcome"] == YES)
	{
		actualFileNameToLookFor = value;
	}
	else
	{
		Configuration* configuration = [Configuration sharedManager];
		// location like: Perth
		NSString* currentLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"]; // auto
		// radar like: IDR663
		NSString* currentLocationRadar = [configuration.Locations valueForKey:currentLocation]; // auto
		actualFileNameToLookFor = [NSString stringWithFormat:value, currentLocationRadar]; // auto
	}

	NSBundle* mainBundle = [NSBundle mainBundle];
	
	NSString* BackgroundImagePath = [mainBundle pathForImageResource:actualFileNameToLookFor]; // auto
	
//	if (BackgroundImagePath == nil)
//		@throw [NSException exceptionWithName:@"ResourceNotFoundException"
//									   reason:@"could not find image resource"
//									 userInfo:nil];
	
	NSString* kbergkbger = [NSString stringWithFormat:@"file://%@", BackgroundImagePath]; // auto
	NSURL* url = [NSURL URLWithString:kbergkbger]; // auto
	
	NSData* data = [NSData dataWithContentsOfURL: url]; // auto

	NSImage* result = [[NSImage alloc] initWithData:data];
	
	return [result autorelease];
}

// create image from layers (first will be at the bottom)
-(NSImage*)getImageWithLayers:(NSArray*)layers
{
	NSImage* result = nil;

	for (id layer in layers)
	{
		NSImage* layerImage = nil;
		
		if ([layer isKindOfClass:[NSImage class]] == YES)
			layerImage = (NSImage*)layer;
		else if ([layer isKindOfClass:[NSString class]] == YES)
			layerImage = [self getResourceImageWithName:(NSString*)layer];
		
		if (layerImage == nil)
			continue; // maybe even throw an exception? O.o
		
		if (result == nil)
			// set base image
			result = layerImage;
		else
			// layer images
			result = [self layerImage:result underImage:layerImage];
	}
	
	return result;
}

-(void)setRadarImageWithLayers:(NSArray*)layers
{
	NSImage* image = [self getImageWithLayers:layers];
	
	//RadarView* view = [[RadarView alloc] initWithImage:image];
	
	//[radarMenuItem setView:view];
	
	[radarMenuItem setNewImage:image];
	
	//[radarView setRadarImage:image];
	
	//[view setNeedsDisplay:YES];
	
	//[radarView setNeedsDisplay:YES];
	
	//[[radarView animator] replaceSubview:<#(NSView *)oldView#> with:<#(NSView *)newView#>];
}

#pragma mark -
#pragma mark Update Everything

-(void)updateEverythingStarter
{
	if (updateEverything != nil)
		[updateEverything release];
	
	updateEverything = [[NSThread alloc] initWithTarget:self
											   selector:@selector(updateEverything)
												 object:nil];
	
	[updateEverything setThreadPriority:0.3];
	[updateEverything setName:@"UpdateEverything"];
	
	[updateEverything start];
}

-(void)updateEverything
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	NSLog(@"attempting to get the most recent radar image");
	
	NSDate* date = nil;
	NSString* url = nil;
	NSData* data = nil;

	[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Downloading", nil]];
	
	RadarDownloader* radarDownloader = [[RadarDownloader alloc] init]; // 1
	BOOL success = [radarDownloader latestRadarAfter:[NSDate date] outDate:&date outUrl:&url outData:&data];
	[radarDownloader release]; // 0
	
	failures = success ? 0 : (failures + 1);
	
	[self performSelectorOnMainThread:@selector(scheduleNextDownload)
						   withObject:nil
						waitUntilDone:NO];
	
	if (success == YES)
	{
		NSLog(@"found a radar image");
		
		NSImage* radarRawImage = [[[NSImage alloc] initWithData:data] autorelease];
		
		// UPDATE SYSTEM ICON
		
		ImageAnalysis* imageAnalysis = [[ImageAnalysis alloc] initWithImage:radarRawImage];
		float score = [imageAnalysis score];
		[imageAnalysis release];
		
		// set value for rainfall training module
		//[RainfallValueTraining setCurrentRainfallValue:score];

		NSLog(@"score = %f", score);
		
		
		[self setIconsForScore:score];
		
		// UPDATE RADAR IMAGE
		
		[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Background", @"Topography", radarRawImage, @"Locations", nil]];
		//[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Background", radarRawImage, nil]];
		
//		radarView.radarImage = [self createDisplayWithImage:(NSImage*)radarRawImage
//										 withDistrictsLayer:NO
//										 withWaterwaysLater:NO
//										withTopographyLayer:YES
//											 withRoadsLayer:NO
//											  withRageLayer:NO
//											  withRailLayer:NO
//										 withLocationsLayer:YES
//										withCatchmentsLayer:NO
//										withBackgroundLayer:NO]; // auto
//		
//		[radarView setNeedsDisplay:YES];
	}
	else
	{
		// UPDATE SYSTEM ICON
		
		NSLog(@"applying error icons");
		[statusItem setAlternateImage:[Configuration sharedManager].ErrorIconAlt];
		[statusItem setImage:[Configuration sharedManager].ErrorIcon];
		
		// UPDATE RADAR IMAGE
		
//		radarView.radarImage = [Configuration sharedManager].ErrorRadarImage;
//		[radarView setNeedsDisplay:YES];
		[self setRadarImageWithLayers:[NSArray arrayWithObjects:@"Error", nil]];
	}
	
	[pool drain];
	
	[NSThread exit];
}

#pragma mark -
#pragma mark Selector Handlers

-(void)exitApplication:(id)sender
{
	NSLog(@"exiting application");
	
	[[NSApplication sharedApplication] terminate:nil];
}

//-(void)showPreferences:(id)sender
//{
//	if([preferencesWindow isVisible] == NO)
//	{
//		[preferencesWindow makeKeyAndOrderFront:sender];
//		[preferencesWindow setLevel:NSFloatingWindowLevel];
//		[preferencesWindow makeFirstResponder:textField];
//		[preferencesWindow makeMainWindow];
//		[preferencesWindow makeKeyWindow];
//	}
//}

-(void)setLocation:(id)sender
{
	if ([updateEverything isExecuting] == YES)
	{
		NSLog(@"thread is already running ... try again later");
		return;
	}
	
	NSMenuItem* ergerg = (NSMenuItem*)sender;
	
	NSString* newLocation = [ergerg title];
	
	NSLog(@"setting new location as \"%@\"", newLocation);
	
	[[NSUserDefaults standardUserDefaults] setValue:newLocation forKey:@"CurrentLocation"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self updateLocationMenuCheckboxThing];
	
	[self updateEverythingStarter];
	
	// TODO     
	//if location is different
	failures = 0;
	
	[self scheduleNextDownload];
}

-(void)sendFeedback:(id)sender
{
	[Helpers sendFeedback];
}

@end