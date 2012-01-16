//  EFIInstaller.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// Last edit by eric_bro (eric.broska@me.com) @ 1.1.12

#import "EFIInstaller.h"
#import "EFIInstallInfo.h"



@interface EFIInstaller (Private) 
-(void) removeMountHFSError;
-(void) reformatEFIPartition;
-(void) mountEFIPartition;
-(void) installBootloader;
-(void) copyBootFile;
-(void) copyExtra;
-(void) unmountEFIPartitionAndDeleteMountDirectory;
-(void) makePartitionBootable;
@end

@implementation EFIInstaller
@synthesize operationQueue;
@synthesize delegate;
@synthesize operationsCount;

-(id) initWithInstallInfo:(EFIInstallInfo*)info {
    
    if (self = [super init]) {
        installInfo = info;
	    applicationPath = [[NSBundle mainBundle] bundlePath];
	    efiPartition = [[NSString alloc] initWithString:[installInfo.deviceNode stringByAppendingFormat:@"s1"]];
    } else {
        return (self=nil, nil);
    }
	return self;
}
 
- (void)dealloc {
    [efiPartition release];
    [installInfo release];
    [super dealloc];
} 
 
 - (void)install {    
    /* Simple check */
    if ( ! [EBTerminalCommander runBinaryFile: @"/bin/mkdir" withArguments: nil asSuperuser: YES]) {
        /* Catching an error while getting the root's rights */
        /* do smth... */         
    } else {
        NSLog(@"Begin the installation...");
        [delegate userDidAuthorized];
        
        [self removeMountHFSError];
        [self reformatEFIPartition];        
        [self installBootloader];
        [self mountEFIPartition];
        [self copyBootFile];
        [self copyExtra];        
        [self unmountEFIPartitionAndDeleteMountDirectory];
        [self makePartitionBootable];
        [self removeMountHFSError];
        
        [delegate installerDidFinished];
    }          
}

@end


@implementation EFIInstaller (Private)

-(void) removeMountHFSError {
	NSLog(@"Removing the Mount Error...");
    if ([EBTerminalCommander runBinaryFile: @"/sbin/fsck_hfs" 
                         withArguments: [NSArray arrayWithObject: efiPartition] 
                           asSuperuser: YES]) {
                           
        [delegate mountHFSErrorWasRemoved];                 
    }                           
}

-(void) reformatEFIPartition {	  
    NSLog(@"Reformatting the EFI Partition...");
    if ([EBTerminalCommander runBinaryFile: @"/sbin/newfs_hfs"
                         withArguments: [NSArray arrayWithObjects: @"-v", @"EFI", efiPartition, nil] 
                           asSuperuser: YES]) {
    
        [delegate EFIPartitionReformated];
    }
}

-(void) mountEFIPartition {

    if ([EBTerminalCommander runBinaryFile: @"/bin/mkdir"
                         withArguments: [NSArray arrayWithObjects: @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
                           
        if ([EBTerminalCommander runBinaryFile: @"/sbin/mount_hfs"
                         withArguments: [NSArray arrayWithObjects: efiPartition, @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
        
            [delegate EFIPartitionMounted];
        }
    }
}

-(void) installBootloader {
      
	NSLog(@"Installing a Bootloader...");
	
	NSString * fdisk    = [applicationPath stringByAppendingString: @"/Contents/Resources/fdisk"];
	NSString * rdiskX   = [efiPartition substringWithRange: NSMakeRange(0,10)];	
	NSString * boot0dir = [applicationPath stringByAppendingString: @"/Contents/Resources/boot0"];
    NSLog(@"%@ %@ %@",fdisk,rdiskX,boot0dir);
	if ([EBTerminalCommander runBinaryFile: fdisk
                         withArguments: [NSArray arrayWithObjects: @"-f", boot0dir, @"-u", @"-y", rdiskX, nil] 
                           asSuperuser: YES]) {
	
	    NSString * rdiskXsY = [@"of=" stringByAppendingString: [NSString stringWithFormat: @"%@s1", rdiskX]];
	    NSString * boot1hdir = [applicationPath stringByAppendingString: @"/Contents/Resources/boot1h"];
	    boot1hdir = [@"if=" stringByAppendingString: boot1hdir];
        
         NSLog(@"%@ %@",rdiskXsY,boot1hdir);
	    
	    if ([EBTerminalCommander runBinaryFile: @"/bin/dd"
                         withArguments: [NSArray arrayWithObjects: boot1hdir, rdiskXsY, nil] 
                           asSuperuser: YES]) {
	        
	        [delegate bootloaderBeganInstallation];
	    }
	}
}

-(void) copyBootFile {
    NSLog(@"Copying the Boot File...");
    if ([EBTerminalCommander runBinaryFile: @"/bin/cp"
                         withArguments: [NSArray arrayWithObjects: installInfo.bootfile, @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
    
        [delegate bootFileCopied];
    }
}

-(void) copyExtra {
    NSLog(@"Copying an Extra Path Oprtional Method...");
    if ([EBTerminalCommander runBinaryFile: @"/bin/cp"
                         withArguments: [NSArray arrayWithObjects: @"-R", installInfo.extraDir, @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
    
        [delegate extraPathCopied];
    }
}

-(void) unmountEFIPartitionAndDeleteMountDirectory {
    
    NSLog(@"Unmounting the EFI partition and deleting the EFI directory...");
    if ([EBTerminalCommander runBinaryFile: @"/sbin/umount"
                         withArguments: [NSArray arrayWithObjects: @"-f", @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
        if ([EBTerminalCommander runBinaryFile: @"/bin/rm"
                         withArguments: [NSArray arrayWithObjects: @"-rf", @"/Volumes/EFI", nil] 
                           asSuperuser: YES]) {
            
            [delegate EFIPartitionUnmountedAndMountDirectoryDeleted];
        } 
    }
}

-(void) makePartitionBootable {
    NSLog(@"Making a Partition Bootable...");

    NSString * makeBoot = [applicationPath stringByAppendingString:@"/Contents/Resources/mb.sh"];
    if ([EBTerminalCommander runBinaryFile: @"/bin/sh"
                         withArguments: [NSArray arrayWithObjects: makeBoot, installInfo.deviceNode, nil] 
                           asSuperuser: YES]) {
         
         [delegate partitionMadeBootable];
    }
}

@end