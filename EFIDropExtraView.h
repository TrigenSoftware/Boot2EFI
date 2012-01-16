//
//  EFIDropExtraView.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EFIDropExtraView : NSView 
{
	NSImage *_ourImage;
	BOOL highlight;
	NSString *extra;
	
}
- (void)setImage:(NSImage *)newImage;
- (NSImage *)image;
- (NSString*)getExtra;


@end
