//
//  InstallationViewController.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIInstaller.h"


@interface InstallationViewController : NSViewController{
    IBOutlet NSProgressIndicator *progressIndicator;
    IBOutlet NSTextField *statusLabel;
    
}

@property (nonatomic, retain) NSTextField *statusLabel;
@property (nonatomic, retain) NSProgressIndicator *progressIndicator;
@end
