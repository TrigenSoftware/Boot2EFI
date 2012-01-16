//
//  Device.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
typedef enum {
	GUID_partition_scheme = 0,
	Apple_partition_scheme = 1,
	FDisk_partition_scheme = 2
} DeviceType;

typedef struct {
	NSString * deviceID;
	NSString * deviceName;
	DeviceType deviceType;
	NSString * deviceNode;
} DeviceInfo;

