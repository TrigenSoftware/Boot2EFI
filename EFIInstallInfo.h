//
//  EFIInstallInfo.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EFIInstallInfo : NSObject {
	NSString * bootfile;
	NSString * extraDir;
	NSString * deviceNode;
}

@property (nonatomic,assign) NSString * deviceNode;
@property (nonatomic,assign) NSString * bootfile;
@property (nonatomic,assign) NSString * extraDir;
@end
