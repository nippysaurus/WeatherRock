//
//  BrissyBomAppDelegate.h
//  BrissyBom
//
//  Created by Michael Dawson on 13/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RadarView.h"
#import "Location.h"
#import "RadarMenuItem.h"

//#import <CoreLocation/CoreLocation.h>

@interface BrissyBomAppDelegate : NSObject <NSApplicationDelegate>
{
	// the menu which will be attached to the system status bar
	IBOutlet NSMenu *menu;
	
	// menu where user can select current location
	IBOutlet NSMenu *locationsMenu;

	// feedback button
	IBOutlet NSMenuItem *feedbackMenuItem;
	
	// the view (containing the radar image) which will be attached to the menu
	//IBOutlet RadarView *radarView;
	
	// the menu item which the radar view is attached to
	IBOutlet RadarMenuItem* radarMenuItem;
	
	// the system status bar which the system provies to us
	NSStatusItem *statusItem;
	
	// used to routinely download radar image
	NSTimer *downloadTimer;
	
	// the number of consecutive failures
	NSInteger failures;
	
	// thread to update everything
	NSThread* updateEverything;
	
	// location finder
	Location* location;
	
}

-(void)exitApplication:(id)sender;

-(void)sendFeedback:(id)sender;

-(void)setLocation:(id)sender;

@end