//
//  Location.h
//  BrissyBom
//
//  Created by Michael Dawson on 15/02/11.
//  Copyright 2011 Nuance. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject <CLLocationManagerDelegate> {

	double radarRadius;
	
	// locations
	CLLocation* Adelaide;
	CLLocation* Brisbane;
	CLLocation* Canberra;
	CLLocation* Darwin;
	CLLocation* Hobart;
	CLLocation* Melbourne;
	CLLocation* Perth;
	CLLocation* Sydney;
	
	// location manager
	CLLocationManager *locationManager;
	
}

@end