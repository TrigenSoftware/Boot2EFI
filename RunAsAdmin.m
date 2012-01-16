//
//  RunAsAdmin.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RunAsAdmin.h"

@implementation RunAsAdmin
@synthesize delegate=_delegate;
-(id) init {
	// AuthorizationCreate and pass NULL as the initial
	// AuthorizationRights set so that the AuthorizationRef gets created
	// successfully, and then later call AuthorizationCopyRights to
	// determine or extend the allowable rights.
	// http://developer.apple.com/qa/qa2001/qa1172.html
	
	self = [super init];
    assert(self);
	
	self->_status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment,
								 kAuthorizationFlagDefaults, &self->_authorizationRef);
	
	 
    if (self->_status != errAuthorizationSuccess)
		NSLog(@"Error Creating Initial Authorization: %d", self->_status);
	
	//kAuthorizationRightExecute == "system.privilege.admin";
	AuthorizationItem right = {kAuthorizationRightExecute, 0, NULL, 0};
	AuthorizationRights rights = {1, &right};
	AuthorizationFlags flags = kAuthorizationFlagDefaults |
	kAuthorizationFlagInteractionAllowed |
	kAuthorizationFlagPreAuthorize |
	kAuthorizationFlagExtendRights;
	
	// Call AuthorizationCopyRights to determine or extend the allowable rights.
	self->_status = AuthorizationCopyRights(self->_authorizationRef, &rights, NULL, flags, NULL);

	if (self->_status != errAuthorizationSuccess) {
        NSLog(@"Copy Rights Unsuccessful: %d", self->_status);
    } else {
        if (self.delegate != nil) {
            [self.delegate authorizationSuccess];
        }
        
    }
	 
	return self;
}
-(RunAsAdmin*) initWithDelegate:(id)delegate {
    self->_delegate = delegate;
    self = [self init];
    assert(self);

    return self;
}
-(void) setCommand:(NSString*)command {
	self->_command = command;
}
-(void) setArguments:(NSMutableArray*)arguments {
	self->_arguments = arguments;
}
-(NSString*)command {
	return self->_command;
}
-(NSMutableArray*)arguments {
	return self->_arguments;
}

-(void)runCommand {
	char * a1;
	char * a2;
	char * a3;
	char * a4;
	char * a5;
	char * a6;
	
	if ([self->_arguments count] == 0) {		
		a1 = NULL;
		a2 = NULL;
		a3 = NULL;
		a4 = NULL;
		a5 = NULL;		
		a6 = NULL;
	}
	if ([self->_arguments count] == 1) {		
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = NULL;
		a3 = NULL;
		a4 = NULL;
		a5 = NULL;		
		a6 = NULL;
	}
	if ([self->_arguments count] == 2) {
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = (char*)[[self->_arguments objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
		a3 = NULL;
		a4 = NULL;
		a5 = NULL;		
		a6 = NULL;		
	}
	if ([self->_arguments count] == 3) {
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = (char*)[[self->_arguments objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
		a3 = (char*)[[self->_arguments objectAtIndex:2] cStringUsingEncoding:NSUTF8StringEncoding];
		a4 = NULL;		
		a5 = NULL;		
		a6 = NULL;
	}
	if ([self->_arguments count] == 4) {
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = (char*)[[self->_arguments objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
		a3 = (char*)[[self->_arguments objectAtIndex:2] cStringUsingEncoding:NSUTF8StringEncoding];
		a4 = (char*)[[self->_arguments objectAtIndex:3] cStringUsingEncoding:NSUTF8StringEncoding];		
		a5 = NULL;		
		a6 = NULL;
	}
	if ([self->_arguments count] == 5) {
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = (char*)[[self->_arguments objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
		a3 = (char*)[[self->_arguments objectAtIndex:2] cStringUsingEncoding:NSUTF8StringEncoding];
		a4 = (char*)[[self->_arguments objectAtIndex:3] cStringUsingEncoding:NSUTF8StringEncoding];		
		a5 = (char*)[[self->_arguments objectAtIndex:4] cStringUsingEncoding:NSUTF8StringEncoding];		
		a6 = NULL;
	}
	if ([self->_arguments count] == 6) {
		a1 = (char*)[[self->_arguments objectAtIndex:0] cStringUsingEncoding:NSUTF8StringEncoding];
		a2 = (char*)[[self->_arguments objectAtIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
		a3 = (char*)[[self->_arguments objectAtIndex:2] cStringUsingEncoding:NSUTF8StringEncoding];
		a4 = (char*)[[self->_arguments objectAtIndex:3] cStringUsingEncoding:NSUTF8StringEncoding];		
		a5 = (char*)[[self->_arguments objectAtIndex:4] cStringUsingEncoding:NSUTF8StringEncoding];		
		a6 = (char*)[[self->_arguments objectAtIndex:5] cStringUsingEncoding:NSUTF8StringEncoding];		
	}
	
	char * arg[] = {a1,a2,a3,a4,a5,a6};
	
	//команда, которую надо выполнить
	char * tool = (char *)[self->_command cStringUsingEncoding:NSUTF8StringEncoding];
	
	FILE *pipe = NULL;
	//выполняем команду с заданными параметрами
	self->_status = AuthorizationExecuteWithPrivileges(self->_authorizationRef, tool,
												kAuthorizationFlagDefaults, arg, &pipe);
	if (self->_status != errAuthorizationSuccess)
		NSLog(@"Error: %d ", self->_status);
	[self->_arguments removeAllObjects];
}

@end
