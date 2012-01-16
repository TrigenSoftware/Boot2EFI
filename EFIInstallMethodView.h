//
//  EFIInstallMethodView.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIOptionalMethodView.h"
#import "EFIExtraMethodView.h"

@interface EFIInstallMethodView : NSView {
	EFIOptionalMethodView *optionallMethodView;
	EFIExtraMethodView *extraMethodView;
	NSView *view;
}
@property (nonatomic, retain) IBOutlet EFIOptionalMethodView *optionallMethodView;
@property (nonatomic, retain) IBOutlet EFIExtraMethodView *extraMethodView;
@property (nonatomic, retain) IBOutlet NSView *view;
@end
