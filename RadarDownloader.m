//
//  RadarDownloader.m
//  BrissyBom
//
//  Created by Michael Dawson on 26/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RadarDownloader.h"

@implementation RadarDownloader

-(id)init
{
	if (self = [super init])
	{
		fileNameDateFormat = [[NSDateFormatter alloc] init]; // 1
		[fileNameDateFormat setDateFormat:@"yyyyMMddHHmm"];
		[fileNameDateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	}
	
	return self;
}

-(NSString*)urlForDate:(NSDate*)time
{
	NSString* fileNameDate = [fileNameDateFormat stringFromDate:time]; // auto
	
	Configuration* configuration = [Configuration sharedManager];
	NSString* radarImageTemplate = configuration.RadarImageTemplate;
	
	NSString* location = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"]; // auto
	NSString* radar = [configuration.Locations objectForKey:location]; // auto
	
	NSString* result = [NSString stringWithFormat:radarImageTemplate, radar, fileNameDate]; // auto?
		
	return result;
}

-(NSDictionary*)radarUrlSequenceStarting:(NSDate*)starting AtIntervals:(NSTimeInterval)interval ForMaximum:(NSTimeInterval)max
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableDictionary* result = [[NSMutableDictionary alloc] init]; // 1

	NSDate* lowerLimit = [starting dateByAddingTimeInterval:-max]; // auto
	NSDate* upperLimit = [starting dateByAddingTimeInterval:max]; // auto

	while ([starting timeIntervalSinceDate:lowerLimit] > 0 && [starting timeIntervalSinceDate:upperLimit] < 0)
	{
		NSString* url = [self urlForDate:starting];
		
		[result setObject:url forKey:starting];
		starting = [starting dateByAddingTimeInterval:interval];
	}
	
	[pool drain];

	return [result autorelease];
}

-(BOOL)latestRadarAfter:(NSDate*)starting outDate:(NSDate**)outDate outUrl:(NSString**)outUrl outData:(NSData**)outData
{
	NSDictionary* urls = [self radarUrlSequenceStarting:starting
											 AtIntervals:(NSTimeInterval)-(1 * 60)
											  ForMaximum:(NSTimeInterval)(10 * 60)]; // auto
	
	NSLog(@"urls to download: %@", urls);
	
	NSEnumerator* enumerator = [urls keyEnumerator]; // auto
	id key = nil;

	while (key = [enumerator nextObject]) // auto
	{
		NSString* value = [urls objectForKey:key]; // auto
		NSURL *url = [NSURL URLWithString:value]; // auto
		NSData* data = [NSData dataWithContentsOfURL: url]; // auto

		if (data != nil)
		{
			NSLog(@"the winner was: %@", url);
			
			*outDate = key;
			*outUrl = value;
			*outData = data;

			return YES;
		}
	}
	
	return NO;
}

-(void)dealloc
{
	[fileNameDateFormat release];
	
	[super dealloc];
}

@end