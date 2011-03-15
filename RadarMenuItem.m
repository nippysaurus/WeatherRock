//
//  RadarMenuItem.m
//  BrissyBom
//
//  Created by Michael Dawson on 1/03/11.
//  Copyright 2011 Nuance. All rights reserved.
//

#import "RadarMenuItem.h"

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
	
    // current view
    id oldView = [self view];
    
    if (oldView == nil)
    {
        [self setView:knerkb];
    }
    else
    {
        //[oldView view
        id animator = [oldView animator];
        [animator replaceSubview:[oldView view] with:knerkb];
    }
    
	//[self setView:knerkb];
	
	[knerkb setNeedsDisplay:YES];
}

@end