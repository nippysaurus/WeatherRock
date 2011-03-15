//
//  RadarView.m
//  BrissyBom
//
//  Created by Michael Dawson on 15/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RadarView.h"

@implementation RadarView

@synthesize radarImage;

//-(id)init
//{
//	self = [super init];
//	
//	if (self != nil)
//	{
//		self.radarImage = nil;
//		
//		[self setHidden:NO];
//		[self setAlphaValue:1.0f];
//		
//		[self setAutoresizesSubviews:YES];
//	}
//	
//	return self;
//}

//-(void)awakeFromNib
//{
//	NSLog(@"%@", self);
//	//
//}

-(id)initWithImage:(NSImage*)image
{
	self = [super init];
	
	if (self != nil)
	{
		self.radarImage = image;
		
		NSRect imageBounds = NSMakeRect(0.0f, 0.0f, image.size.width, image.size.height);		
        [self setFrame:imageBounds];
		[self setBounds:imageBounds];
		
		
//		[self setHidden:NO];
//		[self setAlphaValue:1.0f];
//		
//		[self setAutoresizesSubviews:YES];
	}
	
	return self;
}

-(void)drawRect:(NSRect)dirtyRect
{
	if (radarImage == nil)
		return;

	NSRect imageBounds = NSMakeRect(0.0f, 0.0f, radarImage.size.width, radarImage.size.height);
	
//	[self setBounds:imageBounds];
//	[self setFrame:imageBounds];
	
	[radarImage drawInRect:[self bounds]
					   fromRect:imageBounds
					  operation:NSCompositeSourceAtop
					   fraction:1.0f];
}

-(void)dealloc
{
	[radarImage dealloc];
	
	[super dealloc];
}

@end