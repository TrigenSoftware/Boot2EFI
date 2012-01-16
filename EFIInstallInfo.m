//
//  EFIInstallInfo.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIInstallInfo.h"


@implementation EFIInstallInfo

- (EFIInstallInfo*)init {
    self = [super init];
    assert(self);
	return self;
}

@synthesize deviceNode;
@synthesize bootfile;
@synthesize extraDir;

@end
