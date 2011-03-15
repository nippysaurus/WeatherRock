//
//  RadarDownloader.h
//  BrissyBom
//
//  Created by Michael Dawson on 26/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RadarDownloader : NSObject {

	NSDateFormatter* fileNameDateFormat; // used by "urlForDate:" to format filename
}

-(NSString*)urlForDate:(NSDate*)time;

-(NSDictionary*)radarUrlSequenceStarting:(NSDate*)starting AtIntervals:(NSTimeInterval)interval ForMaximum:(NSTimeInterval)max;

-(BOOL)latestRadarAfter:(NSDate*)starting outDate:(NSDate**)date outUrl:(NSString**)url outData:(NSData**)data;

@end