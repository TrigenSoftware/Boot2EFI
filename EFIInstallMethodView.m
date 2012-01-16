//
//  EFIInstallMethodView.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIInstallMethodView.h"


@implementation EFIInstallMethodView

@synthesize extraMethodView;
@synthesize optionallMethodView;
@synthesize view;

- (id)initWithFrame:(NSRect)frame {
    if (![NSBundle loadNibNamed:@"EFIInstallMethodView" owner:self]) {

    }
	return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	
}

@end
