//
//  EFIDropKextsView.h
//
//  Created by Eduard Sionov on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EFIDropKextsView : NSView
{
    NSImage *_ourImage;
	BOOL highlight;
	NSMutableArray *kexts;
	
}
- (void)setImage:(NSImage *)newImage;
- (NSImage *)image;
- (NSMutableArray*)getKexts;
@end