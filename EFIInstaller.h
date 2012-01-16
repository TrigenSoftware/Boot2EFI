//
//  EFIInstaller.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIInstallInfo.h"
//#import "RunAsAdmin.h"
#import "EBTerminalCommander.h"


@protocol EFIInstallerDelegate

-(void)installerDidFinished;
-(void)installerDidStarted;
-(void)userDidAuthorized;

//operation messages
-(void) mountHFSErrorWasRemoved;
-(void) EFIPartitionReformated;
-(void) EFIPartitionMounted;
-(void) fileStructureWasCreated;
-(void) bootloaderBeganInstallation;
-(void) bootFileCopied;
-(void) kextsCopied;
-(void) extraPathCopied;
-(void) DSDTCopied;
-(void) EFIPartitionUnmountedAndMountDirectoryDeleted;
-(void) partitionMadeBootable;

@end


@interface EFIInstaller : NSObject {
    id <EFIInstallerDelegate> delegate;
	EFIInstallInfo * installInfo;
	//RunAsAdmin * runAsAdmin;
	NSString *efiPartition;
	NSString *applicationPath;
	NSMutableArray *args;
	double timeToWait;
    NSOperationQueue *operationQueue;
    int operationsCount;
}

-(EFIInstaller*)initWithInstallInfo:(EFIInstallInfo *) info;
-(void) install;

@property (nonatomic, retain) NSOperationQueue *operationQueue;
@property (nonatomic, retain) id <EFIInstallerDelegate> delegate;
@property (nonatomic, assign) int operationsCount;
@end
