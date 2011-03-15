//
//  RadarMenuItem.m
//  BrissyBom
//
//  Created by Michael Dawson on 1/03/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RadarMenuItem.h"

// define this to use the animator to set the new view (doesnt seem to work yet)
#undef EXPERIMENTAL_ANIMATOR

@implementation RadarMenuItem

//-(void)awakeFromNib
//{
//	RadarView* knerkb = [[RadarView alloc] init];
//	
//	[self setView:knerkb];
//	
//	[knerkb setNeedsDisplay:YES];
//}

-(void)setNewImage:(NSImage*)image
{
	RadarView* knerkb = [[RadarView alloc] initWithImage:image];

    id oldView = [self view];
    
    if (oldView == nil)
    {
        [self setView:knerkb];
    }
    else
    {
        #ifdef EXPERIMENTAL_ANIMATOR
        id animator = [oldView animator];
        [animator replaceSubview:[oldView view] with:knerkb];
        #else
        [self setView:knerkb];
        #endif
    }
	
	[knerkb setNeedsDisplay:YES];
}

@end