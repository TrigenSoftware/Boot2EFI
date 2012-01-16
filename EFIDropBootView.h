//
//  EFIDropBootView.h
//
//  Created by Eduard Sionov on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EFIDropBootView : NSView
{
    NSImage *_ourImage;
	BOOL highlight;
	NSString *bootDirectory;
	
}
- (void)setImage:(NSImage *)newImage;
- (NSImage *)image;
- (NSString*) getBootDirectory;
@end

