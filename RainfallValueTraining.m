//
//  RailfallValueTraining.m
//  BrissyBom
//
//  Created by Michael Dawson on 7/02/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RainfallValueTraining.h"

@implementation RainfallValueTraining

static float currentRainfallValue;

+(void)setCurrentRainfallValue:(float)value
{
	currentRainfallValue = value;
}

+(void)createFileWithWarningLevel:(NSString*)warningLevel
{
	NSLog(@"creating rainfall value training file");
	
	@try
	{
//		NSString* timestamp = nil;
//		
//		// populate timestamp
//		NSDateFormatter* fileNameDateFormat = [[NSDateFormatter alloc] init]; // 1
//		[fileNameDateFormat setDateFormat:@"yyyyMMddHHmm"];
//		timestamp = [fileNameDateFormat stringFromDate:[NSDate date]];
//		[fileNameDateFormat release];
		
		NSString* library = [Helpers pathFromUserLibraryPath:@"BrissyBom"];
		
//		NSString* filename = [NSString stringWithFormat:@"[%@][%@][%f].png", timestamp, warningLevel, currentRainfallValue]; // auto
		NSString* filename = [NSString stringWithFormat:@"%f.png", currentRainfallValue]; // auto
		
		NSString* radarImageSrcPath = [library stringByAppendingPathComponent:@"IDR663.png"];
		NSString* radarImageDstPath = [library stringByAppendingPathComponent:filename];
		
		[[NSFileManager defaultManager] copyItemAtPath:radarImageSrcPath toPath:radarImageDstPath error:nil];
	}
	@catch (NSException * e)
	{
		NSLog(@"error creating training file");
	}
}

-(void)setZero:(id)sender
{
	[RainfallValueTraining createFileWithWarningLevel:@"0"];
}

-(void)setOne:(id)sender
{
	[RainfallValueTraining createFileWithWarningLevel:@"1"];
}

-(void)setTwo:(id)sender
{
	[RainfallValueTraining createFileWithWarningLevel:@"2"];
}

-(void)setThree:(id)sender
{
	[RainfallValueTraining createFileWithWarningLevel:@"3"];
}

@end