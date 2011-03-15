//
//  Location.m
//  BrissyBom
//
//  Created by Michael Dawson on 15/02/11.
//  Copyright 2011 Nuance. All rights reserved.
//

#import "Location.h"

// --- private interface ---------------------------------------------------------------------------

@interface Location ()

-(void)alertLocationDetected:(NSString*)location;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation Location

-(id)init
{
	if (self = [super init])
    {
		radarRadius = 128 * 1000;
		
		// init locations
		Adelaide = [[CLLocation alloc] initWithLatitude:-34.929 longitude:138.601]; // 1
		Brisbane = [[CLLocation alloc] initWithLatitude:-27.467778 longitude:153.027778];
		Canberra = [[CLLocation alloc] initWithLatitude:-35.308056 longitude:149.124444]; // 1
		Darwin = [[CLLocation alloc] initWithLatitude:-12.45 longitude:130.833333]; // 1
		Hobart = [[CLLocation alloc] initWithLatitude:-42.880556 longitude:147.325]; // 1
		Melbourne = [[CLLocation alloc] initWithLatitude:-37.813611 longitude:144.963056]; // 1
		Perth = [[CLLocation alloc] initWithLatitude:-31.952222 longitude:115.858889]; // 1
		Sydney = [[CLLocation alloc] initWithLatitude:-33.859972 longitude:151.211111]; // 1
		
		// init location manager
		locationManager = [[CLLocationManager alloc] init]; // 1
		locationManager.delegate = self;
		
		// check for existing location (in user preferences)
		if ([[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"] /* 1 */ != nil)
		{
			NSString* location = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocation"]; // auto
			[self alertLocationDetected:location];
			return self;
		}
		
		if ([locationManager locationServicesEnabled] == YES)
		{
			NSLog(@"location services enabled");
			[locationManager startUpdatingLocation];
		}
		else
		{
			NSLog(@"location services disabled");
		}
	}
	return self;
}

-(void)alertLocationDetected:(NSString*)location
{
	NSLog(@"detected location: %@", location);
	
	NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:location, @"location", nil]; // auto
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LocationAvaiable"
														object:nil
													  userInfo:userInfo];
}

-(void)locationManager:(CLLocationManager*)manager
   didUpdateToLocation:(CLLocation*)newLocation
		  fromLocation:(CLLocation*)oldLocation
{
	// no need to wait for further location updates
	[locationManager stopUpdatingLocation];
	
	NSLog(@"CoreLocation found location: %@", newLocation);
	
	CLLocationDistance fromAdelaide = [newLocation distanceFromLocation:Adelaide];
	CLLocationDistance fromBrisbane = [newLocation distanceFromLocation:Brisbane];
	CLLocationDistance fromCanberra = [newLocation distanceFromLocation:Canberra];
	CLLocationDistance fromDarwin = [newLocation distanceFromLocation:Darwin];
	CLLocationDistance fromHobart = [newLocation distanceFromLocation:Hobart];
	CLLocationDistance fromMelbourne = [newLocation distanceFromLocation:Melbourne];
	CLLocationDistance fromPerth = [newLocation distanceFromLocation:Perth];
	CLLocationDistance fromSydney = [newLocation distanceFromLocation:Sydney];
	
	NSLog(@"distance from Adelaide : %f km", fromAdelaide / 1000);
	NSLog(@"distance from Brisbane : %f km", fromBrisbane / 1000);
	NSLog(@"distance from Canberra : %f km", fromCanberra / 1000);
	NSLog(@"distance from Darwin : %f km", fromDarwin / 1000);
	NSLog(@"distance from Hobart : %f km", fromHobart / 1000);
	NSLog(@"distance from Melbourne : %f km", fromMelbourne / 1000);
	NSLog(@"distance from Perth : %f km", fromPerth / 1000);
	NSLog(@"distance from Sydney : %f km", fromSydney / 1000);
	
	if (fromAdelaide < radarRadius)
		[self alertLocationDetected:@"Adelaide"];
	
	if (fromBrisbane < radarRadius)
		[self alertLocationDetected:@"Brisbane"];
	
	if (fromCanberra < radarRadius)
		[self alertLocationDetected:@"Canberra"];
	
	if (fromDarwin < radarRadius)
		[self alertLocationDetected:@"Darwin"];
	
	if (fromHobart < radarRadius)
		[self alertLocationDetected:@"Hobart"];
	
	if (fromMelbourne < radarRadius)
		[self alertLocationDetected:@"Melbourne"];
	
	if (fromPerth < radarRadius)
		[self alertLocationDetected:@"Perth"];
	
	if (fromSydney < radarRadius)
		[self alertLocationDetected:@"Sydney"];
}

-(void)locationManager:(CLLocationManager*)manager
	  didFailWithError:(NSError*)error
{
	NSLog(@"CoreLocation encountered an error: %@", error);
}

@end