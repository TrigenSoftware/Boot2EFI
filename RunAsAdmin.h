//
//  RunAsAdmin.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol RunAsAdminDelegate 

-(void)authorizationSuccess;

@end

@interface RunAsAdmin : NSObject {
    id <RunAsAdminDelegate> _delegate;
	NSString * _command;
	NSMutableArray * _arguments;
	AuthorizationRef _authorizationRef;//ссылка на объект авторизации
	OSStatus _status;//статус выполнения авторизации
}
- (RunAsAdmin*)init;
- (RunAsAdmin*)initWithDelegate:(id)delegate;
- (void)setCommand:(NSString*)com;
- (void)setArguments:(NSMutableArray*)args;
- (NSString*)command;
- (NSMutableArray*)arguments;
- (void)runCommand;

@property (nonatomic, retain) id <RunAsAdminDelegate> delegate;
@end
