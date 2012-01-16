//
//  EFIDiskUtil.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DeviceInformation.h"
@interface EFIDiskUtil : NSObject {
}
- (id)init;
- (NSMutableArray*)deviceNodes;
- (DeviceInformation*)deviceInfoWithNode:(NSString*)deviceNode;

@end
