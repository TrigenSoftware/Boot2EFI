//
//  Boot2EFIAppDelegate.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Boot2EFIAppDelegate.h"
#import "EFIDiskUtil.h"
#import "EFIViewController.h"

@implementation Boot2EFIAppDelegate

@synthesize window;
@synthesize efiViewController;
@synthesize installationViewController;
@synthesize efiInstaller;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
    
	[[window contentView] addSubview:efiViewController.view positioned:0 relativeTo:nil];
}

#pragma -
#pragma EFIViewControllerDelegate Method

-(void)parametersSelectionComplete {
    
     NSOperationQueue *installationProccessQueue = [[NSOperationQueue alloc] init];
     [installationProccessQueue addOperationWithBlock:^{
         //create EFIInstaller object for full instalation
         efiInstaller = [[EFIInstaller alloc] initWithInstallInfo:efiViewController.installInfo];
         efiInstaller.delegate = self;
         [efiInstaller install];
     }];
}

#pragma -
#pragma EFIInstallerDelegate Method

-(void)userDidAuthorized {
    NSArray *subviews = [[window contentView] subviews];
    [[subviews objectAtIndex:1] removeFromSuperview];
    [[subviews objectAtIndex:0] removeFromSuperview];
    //[[subviews objectAtIndex:1] removeFromSuperview];
    /*for (id subview in subviews) {
        [subview removeFromSuperview];
    }*/
    

    [[window contentView] addSubview:installationViewController.view positioned:0 relativeTo:nil];
}
-(void)installerDidFinished {
    [window orderOut:nil];
    NSRunAlertPanel(@"Installation complete!", [NSString stringWithFormat:@"Be happy!"], nil, nil, nil);
	[[NSApplication sharedApplication] terminate:self];
}
-(void)installerDidStarted {
    [installationViewController.progressIndicator setDoubleValue:0.0];
}
-(void)mountHFSErrorWasRemoved {
    [installationViewController.statusLabel setStringValue:@"Removing mount_hfs error"];

}
-(void)EFIPartitionReformated {
    [installationViewController.statusLabel setStringValue:@"Formating EFI partition"];
    [installationViewController.progressIndicator setDoubleValue:10.0];
}
-(void)EFIPartitionMounted {
    [installationViewController.statusLabel setStringValue:@"Mounting EFI partition"];
    [installationViewController.progressIndicator setDoubleValue:20.0];
}
-(void)fileStructureWasCreated {
    [installationViewController.statusLabel setStringValue:@"Creating file structure"];
    [installationViewController.progressIndicator setDoubleValue:30.0];
}
-(void)bootloaderBeganInstallation {
    [installationViewController.statusLabel setStringValue:@"Installing bootloader"];
    [installationViewController.progressIndicator setDoubleValue:40.0];
}
-(void)bootFileCopied {
    [installationViewController.statusLabel setStringValue:@"Copying boot file"];
[installationViewController.progressIndicator setDoubleValue:50.0];
}
-(void)kextsCopied {
    [installationViewController.statusLabel setStringValue:@"Copying extensions"];
    [installationViewController.progressIndicator setDoubleValue:60.0];
}
-(void)extraPathCopied {
    [installationViewController.statusLabel setStringValue:@"Copying Extra folder"];
    [installationViewController.progressIndicator setDoubleValue:70.0];
}
-(void)DSDTCopied {
    [installationViewController.statusLabel setStringValue:@"Copying DSDT"];
    [installationViewController.progressIndicator setDoubleValue:80.0];
}
-(void) EFIPartitionUnmountedAndMountDirectoryDeleted {
    [installationViewController.statusLabel setStringValue:@"Unmounting EFI partition"];
[installationViewController.progressIndicator setDoubleValue:90.0];
}
-(void) partitionMadeBootable {
    [installationViewController.statusLabel setStringValue:@"Making partition bootable"];
    [installationViewController.progressIndicator setDoubleValue:100.0];
}

-(IBAction)donate:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: @"http://trigen.pro/donate"]];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
