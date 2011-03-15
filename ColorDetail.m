//
//  ColorDetail.m
//  BrissyBom
//
//  Created by Michael Dawson on 23/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "ColorDetail.h"

// --- private interface ---------------------------------------------------------------------------

//@interface ColorDetail ()

//-(BOOL)thisColor:(NSColor*)ca MatchesThisColor:(NSColor*)cb;

//@end

// --- class implementation ------------------------------------------------------------------------

@implementation ColorDetail

-(id)initWithColor:(NSColor*)c Value:(float)v Image:(NSImage*)i
{
    if (self = [super init])
    {
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		
		NSBitmapImageRep* raw_img = [NSBitmapImageRep imageRepWithData:[i TIFFRepresentation]]; // auto
		
		NSSize size = [i size]; // stack
	
		value = v;
		count = 0;
		
		for (int x = 0 ; x < size.width ; ++x) // stack
			for (int y = 0 ; y < size.height ; ++y) // stack
			{
				NSColor* gaeahwer = [raw_img colorAtX:x y:y]; // audo
				if ([Helpers doesThisColor:c MatchesThisColor:gaeahwer] == YES)
					count += 1;
			}
		
		NSLog(@"Color: [%f][%f][%f] Count:%i", [c redComponent], [c greenComponent], [c blueComponent], count);
		
		[pool drain];
	}
	return self;
}

-(float)score
{
	float result = value * count;
	
	NSLog(@"value (%f) x count (%i) = %f", value, count, result);
	
	// the resulting value should be checked that it isnt too big?
	return result;
}

-(void)dealloc
{
	// there is nothing to release

	[super dealloc];
}

@end