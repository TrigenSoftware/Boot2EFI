//
//  InstallationView.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InstallationView.h"


@implementation InstallationView
@synthesize progressIndicator;
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
