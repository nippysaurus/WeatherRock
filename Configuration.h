//
//  Configuration.h
//  BrissyBom
//
//  Created by Michael Dawson on 3/02/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Configuration : NSObject {

	NSImage* ErrorIcon;
	NSImage* ErrorIconAlt;
	
	NSImage* Icon_L0;
	NSImage* Icon_L0Alt;
	NSImage* Icon_L1;
	NSImage* Icon_L1Alt;
	NSImage* Icon_L2;
	NSImage* Icon_L2Alt;
	NSImage* Icon_L3;
	NSImage* Icon_L3Alt;
	
	NSNumber* Threshold_L1;
	NSNumber* Threshold_L2;
	NSNumber* Threshold_L3;
	
	NSString* RadarImageTemplate;
	
	NSNumber* IntervalAfterSuccess;
	NSNumber* IntervalAfterFirstFailure;
	NSNumber* IntervalAfterSubsequentFailures;
			
	NSDictionary* Locations;
	
	NSDictionary* Layers;
	
	//NSDictionary* TransparencyTemplates;
	
}

@property (readonly,nonatomic) NSImage * ErrorIcon;
@property (readonly,nonatomic) NSImage * ErrorIconAlt;

@property (readonly,nonatomic) NSImage * Icon_L0;
@property (readonly,nonatomic) NSImage * Icon_L0Alt;
@property (readonly,nonatomic) NSImage * Icon_L1;
@property (readonly,nonatomic) NSImage * Icon_L1Alt;
@property (readonly,nonatomic) NSImage * Icon_L2;
@property (readonly,nonatomic) NSImage * Icon_L2Alt;
@property (readonly,nonatomic) NSImage * Icon_L3;
@property (readonly,nonatomic) NSImage * Icon_L3Alt;

@property (readonly,nonatomic) NSNumber * Threshold_L1;
@property (readonly,nonatomic) NSNumber * Threshold_L2;
@property (readonly,nonatomic) NSNumber * Threshold_L3;

@property (readonly,nonatomic) NSString * RadarImageTemplate;

@property (readonly,nonatomic) NSNumber * IntervalAfterSuccess;
@property (readonly,nonatomic) NSNumber * IntervalAfterFirstFailure;
@property (readonly,nonatomic) NSNumber * IntervalAfterSubsequentFailures;

@property (readonly,nonatomic) NSDictionary * Layers;

@property (readonly,nonatomic) NSDictionary * Locations;

//@property (readonly,nonatomic) NSDictionary * TransparencyTemplates;

+(Configuration*)sharedManager;

-(void)configureManagedObjectContext;

@end