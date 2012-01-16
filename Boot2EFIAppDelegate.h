//
//  Boot2EFIAppDelegate.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIViewController.h"
#import "InstallationViewController.h"

@interface Boot2EFIAppDelegate : NSObject <NSApplicationDelegate,EFIInstallerDelegate,EFIViewControllerDelegate> {
    NSWindow *window;
	EFIViewController *efiViewController;
    InstallationViewController *installationViewController;
    EFIInstaller *efiInstaller;
}

-(IBAction)donate:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet EFIViewController *efiViewController;
@property (nonatomic, retain) IBOutlet InstallationViewController *installationViewController;
@property (nonatomic, retain) EFIInstaller *efiInstaller;

@end
