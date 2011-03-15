//
//  Configuration.m
//  BrissyBom
//
//  Created by Michael Dawson on 3/02/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

@synthesize ErrorIcon;
@synthesize ErrorIconAlt;

@synthesize Icon_L0;
@synthesize Icon_L0Alt;
@synthesize Icon_L1;
@synthesize Icon_L1Alt;
@synthesize Icon_L2;
@synthesize Icon_L2Alt;
@synthesize Icon_L3;
@synthesize Icon_L3Alt;

@synthesize Threshold_L1;
@synthesize Threshold_L2;
@synthesize Threshold_L3;

@synthesize RadarImageTemplate;

@synthesize IntervalAfterSuccess;
@synthesize IntervalAfterFirstFailure;
@synthesize IntervalAfterSubsequentFailures;

@synthesize Layers;

@synthesize Locations;

//@synthesize TransparencyTemplates;

#pragma mark -
#pragma mark singleton management

static Configuration* instance = nil;

+(Configuration*)sharedManager
{
    if (instance == nil)
    {
		instance = [[super allocWithZone:NULL] init];
        
        [instance configureManagedObjectContext];
    }
    
    return instance;
}

+(id)allocWithZone:(NSZone*)zone
{
    return [[self sharedManager] retain];
}

-(id)copyWithZone:(NSZone*)zone
{
    return self;
}

#pragma mark -
#pragma mark configuration

-(void)configureManagedObjectContext
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	// BrissyBom bundle path
	NSBundle* bundle = [NSBundle mainBundle];
	
	NSString *path = [bundle pathForResource:@"Config" ofType:@"plist"]; // auto
	NSMutableDictionary *config = [[NSMutableDictionary alloc] initWithContentsOfFile:path]; // 1
	
	NSLog(@"config from plist: %@", config);
	
	NSString* ErrorIcon_Path = [bundle pathForResource:[config objectForKey:@"ErrorIcon"] ofType:@"png"]; // auto
	NSString* ErrorIconAlt_Path = [bundle pathForResource:[config objectForKey:@"ErrorIconAlt"] ofType:@"png"]; // auto
	NSString* Icon_L0_Path = [bundle pathForResource:[config objectForKey:@"Icon_L0"] ofType:@"png"]; // auto
	NSString* Icon_L0Alt_Path = [bundle pathForResource:[config objectForKey:@"IconAlt_L0"] ofType:@"png"]; // auto
	NSString* Icon_L1_Path = [bundle pathForResource:[config objectForKey:@"Icon_L1"] ofType:@"png"]; // auto
	NSString* Icon_L1Alt_Path = [bundle pathForResource:[config objectForKey:@"IconAlt_L1"] ofType:@"png"]; // auto
	NSString* Icon_L2_Path = [bundle pathForResource:[config objectForKey:@"Icon_L2"] ofType:@"png"]; // auto
	NSString* Icon_L2Alt_Path = [bundle pathForResource:[config objectForKey:@"IconAlt_L2"] ofType:@"png"]; // auto
	NSString* Icon_L3_Path = [bundle pathForResource:[config objectForKey:@"Icon_L3"] ofType:@"png"]; // auto
	NSString* Icon_L3Alt_Path = [bundle pathForResource:[config objectForKey:@"IconAlt_L3"] ofType:@"png"]; // auto
	
	ErrorIcon = [[NSImage alloc] initWithContentsOfFile:ErrorIcon_Path]; // 1
	ErrorIconAlt = [[NSImage alloc] initWithContentsOfFile:ErrorIconAlt_Path]; // 1
	Icon_L0 = [[NSImage alloc] initWithContentsOfFile:Icon_L0_Path]; // 1
	Icon_L0Alt = [[NSImage alloc] initWithContentsOfFile:Icon_L0Alt_Path]; // 1
	Icon_L1 = [[NSImage alloc] initWithContentsOfFile:Icon_L1_Path]; // 1
	Icon_L1Alt = [[NSImage alloc] initWithContentsOfFile:Icon_L1Alt_Path]; // 1
	Icon_L2 = [[NSImage alloc] initWithContentsOfFile:Icon_L2_Path]; // 1
	Icon_L2Alt = [[NSImage alloc] initWithContentsOfFile:Icon_L2Alt_Path]; // 1
	Icon_L3 = [[NSImage alloc] initWithContentsOfFile:Icon_L3_Path]; // 1
	Icon_L3Alt = [[NSImage alloc] initWithContentsOfFile:Icon_L3Alt_Path]; // 1
	
	Threshold_L1 = [config objectForKey:@"Threshold_L1"];
	[Threshold_L1 retain];
	Threshold_L2 = [config objectForKey:@"Threshold_L2"];
	[Threshold_L2 retain];
	Threshold_L3 = [config objectForKey:@"Threshold_L3"];
	[Threshold_L3 retain];
	
	RadarImageTemplate = [config objectForKey:@"RadarImageTemplate"];
	[RadarImageTemplate retain];
	
	IntervalAfterSuccess = [config objectForKey:@"IntervalAfterSuccess"];
	[IntervalAfterSuccess retain];
	IntervalAfterFirstFailure = [config objectForKey:@"IntervalAfterFirstFailure"];
	[IntervalAfterFirstFailure retain];
	IntervalAfterSubsequentFailures = [config objectForKey:@"IntervalAfterSubsequentFailures"];
	[IntervalAfterSubsequentFailures retain];

	Layers = [config objectForKey:@"Layers"];
	[Layers retain];
	
	Locations = [config objectForKey:@"Locations"];
	[Locations retain];
	
	NSLog(@"config in memory: %@", [self description]);
	
	[config release];
	
	[pool drain];
}

-(NSString*)description
{
	NSMutableDictionary* temp = [[NSMutableDictionary alloc] init];
	
	[temp setObject:ErrorIcon forKey:@"ErrorIcon"];
	[temp setObject:ErrorIconAlt forKey:@"ErrorIconAlt"];
	[temp setObject:Icon_L0 forKey:@"Icon_L0"];
	[temp setObject:Icon_L0Alt forKey:@"Icon_L0Alt"];
	[temp setObject:Icon_L1 forKey:@"Icon_L1"];
	[temp setObject:Icon_L1Alt forKey:@"Icon_L1Alt"];
	[temp setObject:Icon_L2 forKey:@"Icon_L2"];
	[temp setObject:Icon_L2Alt forKey:@"Icon_L2Alt"];
	[temp setObject:Icon_L3 forKey:@"Icon_L3"];
	[temp setObject:Icon_L3Alt forKey:@"Icon_L3Alt"];
	[temp setObject:Threshold_L1 forKey:@"Threshold_L1"];
	[temp setObject:Threshold_L2 forKey:@"Threshold_L2"];
	[temp setObject:Threshold_L3 forKey:@"Threshold_L3"];
	[temp setObject:RadarImageTemplate forKey:@"RadarImageTemplate"];
	[temp setObject:IntervalAfterSuccess forKey:@"IntervalAfterSuccess"];
	[temp setObject:IntervalAfterFirstFailure forKey:@"IntervalAfterFirstFailure"];
	[temp setObject:IntervalAfterSubsequentFailures forKey:@"IntervalAfterSubsequentFailures"];
	[temp setObject:Locations forKey:@"Locations"];
//	[temp setObject:TransparencyTemplates forKey:@"TransparencyTemplates"];
	
	[temp autorelease];
	
	return [temp description];
}

@end