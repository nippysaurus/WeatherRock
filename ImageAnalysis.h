//
//  ImageAnalysis.h
//  BackgroundApplication
//
//  Created by Michael Dawson on 31/12/10.
//  Copyright 2010 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColorDetail.h"

@interface ImageAnalysis : NSObject {

	ColorDetail * detail_a;
	ColorDetail * detail_b;
	ColorDetail * detail_c;
	ColorDetail * detail_d;
	ColorDetail * detail_e;
	ColorDetail * detail_f;
	ColorDetail * detail_g;
	ColorDetail * detail_h;
	ColorDetail * detail_i;
	ColorDetail * detail_j;
	ColorDetail * detail_k;
	ColorDetail * detail_l;
	ColorDetail * detail_m;
	ColorDetail * detail_n;
	ColorDetail * detail_o;
	
	float score;
	
}

@property (readonly) float score;

-(id)initWithImage:(NSImage*)i;

@end