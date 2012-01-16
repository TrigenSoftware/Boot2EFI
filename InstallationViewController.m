//
//  InstallationViewController.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InstallationViewController.h"


@implementation InstallationViewController
@synthesize progressIndicator;
@synthesize statusLabel;

- (void)awakeFromNib {

    [progressIndicator startAnimation:self];
    [progressIndicator setUsesThreadedAnimation:YES];
}


@end
