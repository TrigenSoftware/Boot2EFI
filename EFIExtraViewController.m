//
//  EFIExtraInstallViewController.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIExtraViewController.h"


@implementation EFIExtraViewController

@synthesize dropExtraView;

-(void)loadView {
	[NSBundle loadNibNamed:@"ExtraView" owner:self];
}
@end
