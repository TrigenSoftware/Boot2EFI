//
//  EFIInstallMethodViewController.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIOptionalViewController.h"
#import "EFIExtraViewController.h"


@interface EFIInstallMethodViewController : NSViewController {
	EFIOptionalViewController *optionalViewController;
	EFIExtraViewController *extraViewController;
}
@property (nonatomic, retain) IBOutlet EFIOptionalViewController *optionalViewController;
@property (nonatomic, retain) IBOutlet EFIExtraViewController *extraViewController;
@end
