//
//  InstallationView.h
//  Boot2EFI
//
//  Created by Eduard Sionov on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface InstallationView : NSView {
@private
    IBOutlet NSProgressIndicator *progressIndicator;
}
@property (nonatomic, retain) NSProgressIndicator *progressIndicator;
@end
