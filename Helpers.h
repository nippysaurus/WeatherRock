//
//  Helpers.h
//  BrissyBom
//
//  Created by Michael Dawson on 25/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Helpers : NSObject {

}

+(NSString*)pathFromUserLibraryPath:(NSString*)inSubPath;

+(void)sendFeedback;

+(BOOL)doesThisColor:(NSColor*)ca MatchesThisColor:(NSColor*)cb;

+(NSString*)defaultMailApplication;

@end