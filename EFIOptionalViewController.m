//
//  EFIOptionalViewController.m
//  Boot2EFI
//
//  Created by Eduard Sionov on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIOptionalViewController.h"


@implementation EFIOptionalViewController
@synthesize dropBootView;
@synthesize dropExtraView;

-(void) loadView {
	[NSBundle loadNibNamed:@"OptionalView" owner:self];
}
@end
