//
//  Helpers.m
//  BrissyBom
//
//  Created by Michael Dawson on 25/01/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+(NSString*)pathFromUserLibraryPath:(NSString*)inSubPath
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSArray* domains = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES); // ?
	NSString* baseDir= [domains objectAtIndex:0]; // ?
	NSString* result = [baseDir stringByAppendingPathComponent:inSubPath]; // ?

	[result retain];
	
	[pool drain];
	
	return [result autorelease];
}

+(NSString*)defaultMailApplication
{
	// FROM
	// http://forums.macrumors.com/showthread.php?t=718246
	
	NSURL *mailtoURL = [NSURL URLWithString:@"mailto:"]; // auto
	CFURLRef emailURL = NULL;
	LSGetApplicationForURL((CFURLRef)mailtoURL, kLSRolesAll, NULL, &emailURL);

	return [(NSURL*)emailURL description]; // auto
}

+(void)sendFeedback
{
	// FROM:
	// http://dbachrach.com/blog/2009/03/how-to-send-an-email-in-cocoa/
	// http://hintsforums.macworld.com/showthread.php?t=80309
	
	NSString* to = @"brissybomapp@me.com";
	NSString* subject = @"BrissyBom BETA Feedback";
	
	//NSString* body = @"I really like BrissyBom because ...";
	NSString* body = @"You can improve BrissyBom by ...";
	
	NSString* defaultMailApplication = [Helpers defaultMailApplication]; // auto
	
	NSLog(@"default email application: %@", defaultMailApplication);
	
	if ([defaultMailApplication isEqualToString:@"file://localhost/Applications/Mail.app/"] == NO)
	{
		NSLog(@"mail application [%@] is not supported yet", defaultMailApplication);
		
		// TODO pop up error message
		
		return;
	}
	
	NSAppleScript *mailScript;
	NSString *scriptString= [NSString stringWithFormat:@"tell application \"Mail\"\nset theNewMessage to make new outgoing message with properties {subject:\"%@\", content:\"%@\", visible:true}\ntell theNewMessage\nmake new to recipient at end of to recipients with properties {address:\"%@\"}\nend tell\nactivate\nend tell\n", subject, body, to];
	mailScript = [[NSAppleScript alloc] initWithSource:scriptString];
	[mailScript executeAndReturnError:nil];
	[mailScript release];
}

+(BOOL)doesThisColor:(NSColor*)ca MatchesThisColor:(NSColor*)cb
{
//	if ([ca alphaComponent] != 1 || [cb alphaComponent] != 1)
//		return NO;
	
	//BOOL _floatsOrDoublesAreEqual = ( fabs(C.x - D.x) <= _epsilon );
	float threshold = 0.0001;	
	
//	CGFloat a = [ca redComponent];
//	CGFloat b = [cb redComponent];
	
	//if([ca redComponent] != [cb redComponent])
	if(fabs([ca redComponent] - [cb redComponent]) > threshold)
	{
		//NSLog(@"%f != %f", [ca redComponent], [cb redComponent]);
		return NO;
	}
	
	//if ([ca greenComponent] != [cb greenComponent])
	if (fabs([ca greenComponent] - [cb greenComponent]) > threshold)
	{
		//NSLog(@"%f != %f", [ca greenComponent], [cb greenComponent]);
		return NO;
	}
	
	//if ([ca blueComponent] != [cb blueComponent])
	if (fabs([ca blueComponent] - [cb blueComponent]) > threshold)
	{
		//NSLog(@"%f != %f", [ca blueComponent], [cb blueComponent]);
		return NO;
	}
	
	return YES;
}

@end