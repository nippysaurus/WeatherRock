//
//  ColorDetail.h
//  BrissyBom
//
//  Created by Michael Dawson on 23/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ColorDetail : NSObject {
	
	// the value given to each pixel of this color
	float value;
	
	// the number of pixels with this color;
	int count;

}

-(id)initWithColor:(NSColor*)c Value:(float)v Image:(NSImage*)i;

-(float)score;

@end