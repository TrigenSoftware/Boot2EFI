//
//  DeviceInformation.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	GUID_partition_scheme = 0,
	Apple_partition_scheme = 1,
	FDisk_partition_scheme = 2
} DeviceType;

@interface DeviceInformation : NSObject {
	NSString * deviceID;
	NSString * deviceName;
	DeviceType deviceType;
	NSString * deviceNode;	
}
- (id)init;

@property (nonatomic,assign) NSString * deviceID;
@property (nonatomic,assign) NSString * deviceName;
@property (nonatomic,assign) NSString * deviceNode;
@property (nonatomic,assign) DeviceType deviceType;

@end
