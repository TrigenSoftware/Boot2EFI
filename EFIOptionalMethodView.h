//
//  EFIOptionalMethodView.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EFIDropDSDTView.h"
#import "EFIDropKextsView.h"

@interface EFIOptionalMethodView : NSView {
	IBOutlet EFIDropDSDTView *dropDSDTView;
	IBOutlet EFIDropKextsView *dropKextView;
	
}
@property (nonatomic, retain) IBOutlet EFIDropDSDTView *dropDSDTView;
@property (nonatomic, retain) IBOutlet EFIDropKextsView *dropKextView;
@end
