//
//  ImageAnalysis.m
//  BackgroundApplication
//
//  Created by Michael Dawson on 31/12/10.
//  Copyright 2010 Nippysaurus. All rights reserved.
//

#import "ImageAnalysis.h"

@implementation ImageAnalysis

-(id)initWithImage:(NSImage*)i
{
    if (self = [super init])
    {
//		NSImage* kberkbf = [[NSImage alloc] initWithContentsOfFile:@"/Users/michael/Desktop/IDR663.gif"];
//		NSBitmapImageRep* raw_img = [NSBitmapImageRep imageRepWithData:[kberkbf TIFFRepresentation]]; // auto
//		
//		NSColor* kkbskv = [raw_img colorAtX:133 y:530];
//		NSColor* rkkjkb = [NSColor colorWithDeviceRed:0.960784 green:0.960784 blue:1 alpha:1];
//		
//		NSLog(@"A = %@", kkbskv);
//		NSLog(@"A = %@", [kkbskv colorSpace]);
//		NSLog(@"B = %@", rkkjkb);
//		NSLog(@"B = %@", [kkbskv colorSpace]);
//		
//		if ([Helpers doesThisColor:kkbskv MatchesThisColor:rkkjkb] == YES)
//			NSLog(@"MATCH");
//		else
//			NSLog(@"NOMATCH");
		
//		detail_a = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:133 y:530] Value:0.01 Image:i];
//		detail_b = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:161 y:530] Value:0.05 Image:i];
//		detail_c = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:186 y:530] Value:0.05 Image:i];
//		detail_d = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:213 y:530] Value:0.05 Image:i];
//		detail_e = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:242 y:530] Value:0.1 Image:i];
//		detail_f = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:264 y:530] Value:0.1 Image:i];
//		detail_g = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:290 y:530] Value:0.2 Image:i];
//		detail_h = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:323 y:530] Value:0.2 Image:i];
//		detail_i = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:347 y:530] Value:0.4 Image:i];
//		detail_j = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:370 y:530] Value:0.4 Image:i];
//		detail_k = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:395 y:530] Value:0.4 Image:i];
//		detail_l = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:422 y:530] Value:1.0 Image:i];
//		detail_m = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:445 y:530] Value:1.0 Image:i];
//		detail_n = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:477 y:530] Value:1.0 Image:i];
//		detail_o = [[ColorDetail alloc] initWithColor:[raw_img colorAtX:500 y:530] Value:1.0 Image:i];

		detail_a = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.960784 green:0.960784 blue:1 alpha:1] Value:0.01 Image:i];
		detail_b = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.705882 green:0.705882 blue:1 alpha:1] Value:0.05 Image:i];
		detail_c = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.470588 green:0.470588 blue:1 alpha:1] Value:0.05 Image:i];
		detail_d = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.0784314 green:0.0784314 blue:1 alpha:1] Value:0.05 Image:i];
		detail_e = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0 green:0.847059 blue:0.764706 alpha:1] Value:0.1 Image:i];
		detail_f = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0 green:0.588235 blue:0.564706 alpha:1] Value:0.1 Image:i];
		detail_g = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0 green:0.4 blue:0.4 alpha:1] Value:0.2 Image:i];
		detail_h = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:1] Value:0.2 Image:i];
		detail_i = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:1 green:0.784314 blue:0 alpha:1] Value:0.4 Image:i];
		detail_j = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:1 green:0.588235 blue:0 alpha:1] Value:0.4 Image:i];
		detail_k = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:1 green:0.392157 blue:0 alpha:1] Value:0.4 Image:i];
		detail_l = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1] Value:1.0 Image:i];
		detail_m = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.784314 green:0 blue:0 alpha:1] Value:1.0 Image:i];
		detail_n = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.470588 green:0 blue:0 alpha:1] Value:1.0 Image:i];
		detail_o = [[ColorDetail alloc] initWithColor:[NSColor colorWithDeviceRed:0.156863 green:0 blue:0 alpha:1] Value:1.0 Image:i];
		
//		[kberkbf release];
	}

	return self;
}

-(float)score
{
	float tally = 0.0f;

	tally += [detail_a score];
	tally += [detail_b score];
	tally += [detail_c score];
	tally += [detail_d score];
	tally += [detail_e score];
	tally += [detail_f score];
	tally += [detail_g score];
	tally += [detail_h score];
	tally += [detail_i score];
	tally += [detail_j score];
	tally += [detail_k score];
	tally += [detail_l score];
	tally += [detail_m score];
	tally += [detail_n score];
	tally += [detail_o score];
	
	return tally;
}

-(void)dealloc
{
	[detail_a release];
	[detail_b release];
	[detail_c release];
	[detail_d release];
	[detail_e release];
	[detail_f release];
	[detail_g release];
	[detail_h release];
	[detail_i release];
	[detail_j release];
	[detail_k release];
	[detail_l release];
	[detail_m release];
	[detail_n release];
	[detail_o release];
	
	[super dealloc];
}

@end