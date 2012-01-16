//
//  EFIDiskUtil.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIDiskUtil.h"

@implementation EFIDiskUtil

- (id)init {
    self = [super init];
    assert(self);
	return self;
}
- (NSMutableArray*)deviceNodes {
	// run task
	NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/sbin/diskutil"];
	
    NSArray *arguments;
	arguments = [NSArray arrayWithObject:@"list"];
    [task setArguments: arguments];
	
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
	
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
	
    [task launch];
    [task waitUntilExit];
	
    NSData *data;
	
    data = [file readDataToEndOfFile];
	
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	
	// deviceID array
	NSMutableArray * deviceNodes = [NSMutableArray array];
	
	//***********************************************************************************
	// searching strings with substring "/dev/disk". it means that its disk identifiers 
	int _beg = 0;//begin of ich string 
	int _end = 0;//end of ich string
	int diskCount = 0;
	NSString * stringToSearch = @"/dev/disk";
	
	for (int i = 0; i < [string length]; i++) {
		if ([string characterAtIndex:i] == '\n') {
			_end = i;
			NSString * subStr = [[NSString alloc] initWithString:[string substringWithRange:NSMakeRange(_beg,_end - _beg)]];

			if ([subStr rangeOfString:stringToSearch].location == 0) {
				diskCount++;
				[deviceNodes addObject:subStr];
				NSLog(@"Disk detected: %d with name : %@",diskCount,subStr);
			}
			_beg = _end+1;
		}
	}
	return deviceNodes;
}

- (DeviceInformation*)deviceInfoWithNode:(NSString*)deviceNode {

	DeviceInformation * deviceInfo = [[DeviceInformation alloc] init];
	deviceInfo.deviceNode = deviceNode;

	// execute task
	NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/sbin/diskutil"];
	
    NSArray *arguments;
	arguments = [NSArray arrayWithObjects: @"info", deviceNode, nil, nil];
    [task setArguments: arguments];
	
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
	
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
	
    [task launch];
    [task waitUntilExit];
	
    NSData *data;
    data = [file readDataToEndOfFile];
	
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
	NSLog(@"%@",string);
	//***********************************************************************************
	// searching strings with substring "Media Name:". it is name of device
	int _beg = 0;//begin of ich string 
	int _end = 0;//end of ich string
	NSString * stringToSearch = @"Device / Media Name:";
	
	for (int i = 0; i < [string length]; i++) 
	{
		if ([string characterAtIndex:i] == '\n') 
		{
			_end = i;
			
			NSString * subStr = [[NSString alloc] initWithString:[string substringWithRange:
																  NSMakeRange(_beg,_end - _beg)]];
			
			if ([subStr rangeOfString:stringToSearch].location == 3) 
			{
				
				NSString * devName = [[NSString alloc] initWithString:[subStr substringWithRange:
																	NSMakeRange(29,[subStr length] - 29)]];				
				deviceInfo.deviceName = devName;	

			}
			_beg = _end+1;
		}
	}
	
	//***********************************************************************************
	// searching strings with substring "Media Name:". it is name of device
	_beg = 0;//begin of ich string 
	_end = 0;//end of ich string
	stringToSearch = @"Partition Type:";
	
	for (int i = 0; i < [string length]; i++) 
	{	
		if ([string characterAtIndex:i] == '\n') 
		{
			_end = i;
			
			NSString * subStr = [[NSString alloc] initWithString:[string substringWithRange:
																  NSMakeRange(_beg,_end - _beg)]];
			
			if ([subStr rangeOfString:stringToSearch].location == 3) 
			{
				NSString * partType = [[NSString alloc] initWithString:[subStr substringWithRange:
																		NSMakeRange(29,[subStr length] - 29)]];
				if ([partType isEqualToString:@"GUID_partition_scheme"]) {
					deviceInfo.deviceType = GUID_partition_scheme;
				}
				if ([partType isEqualToString:@"Apple_partition_scheme"]) {
					deviceInfo.deviceType = Apple_partition_scheme;
				}
				if ([partType isEqualToString:@"FDisk_partition_scheme"]) {
					deviceInfo.deviceType = FDisk_partition_scheme;
				}

			}
			_beg = _end+1;
		}
	}
	return deviceInfo;
}

@end
