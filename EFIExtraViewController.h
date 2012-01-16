//
//  EFIExtraInstallViewController.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIDropExtraView.h"

@interface EFIExtraViewController : NSViewController {
	EFIDropExtraView *dropExtraView;
}
@property (nonatomic, retain) IBOutlet EFIDropExtraView *dropExtraView;
@end
