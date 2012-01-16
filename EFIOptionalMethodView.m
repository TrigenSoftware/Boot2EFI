//
//  EFIOptionalMethodView.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIOptionalMethodView.h"


@implementation EFIOptionalMethodView
@synthesize dropDSDTView;
@synthesize dropKextView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (![NSBundle loadNibNamed:@"EFIOptionalMethodView" owner:self]) {
		NSLog(@"cant load OptionalMethodView");
	}
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.

}

@end
