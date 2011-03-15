//
//  RadarView.h
//  BrissyBom
//
//  Created by Michael Dawson on 15/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RadarView : NSView {

	NSImage* radarImage;
	
}

@property(retain, nonatomic) NSImage *radarImage;

@end