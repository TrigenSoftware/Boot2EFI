//
//  EFIViewController.h
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIInstallInfo.h"
#import "EFIDiskUtil.h"
#import "EFIDropBootView.h"
#import "EFIDropKextsView.h"
#import "EFIInstallMethodViewController.h"
#import "EFIInstaller.h"

@protocol EFIViewControllerDelegate

-(void)parametersSelectionComplete;

@end

@interface EFIViewController : NSViewController {
    
	IBOutlet id <EFIViewControllerDelegate> delegate;
	EFIInstallInfo * installInfo;
	EFIDiskUtil * diskUtil;
	NSMutableArray * deviceInformationArray;
    IBOutlet NSPopUpButton *bootPopUp;
    IBOutlet NSPopUpButton *deviceNamePopUp;
	IBOutlet NSPopUpButton *installMethodPopUp;
	EFIInstallMethodViewController *methodViewController;
	IBOutlet NSView *methodView;
}
- (IBAction)installPressed:(id)sender;
- (IBAction)deviceNodeSelected:(id)sender;
- (void)alarmNoGUID;

@property (nonatomic, retain) id <EFIViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet EFIInstallMethodViewController *methodViewController;
@property (nonatomic, retain) EFIInstallInfo * installInfo;
@end
