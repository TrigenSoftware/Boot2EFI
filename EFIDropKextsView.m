//
//  EFIDSDTView.m
//
//  Created by Eduard Sionov on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIDropKextsView.h"

@implementation EFIDropKextsView

- (void)awakeFromNib {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *dropHereImagePath = [[NSString alloc] initWithString:[appPath stringByAppendingString:@"/Contents/Resources/images/dropHere.png"]];
	NSImage *dropHereImage = [[NSImage alloc] initWithContentsOfFile:dropHereImagePath];
	[self setImage:dropHereImage];	
	kexts = [NSMutableArray array];
	[kexts retain];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
		//are offering
		highlight=YES;
		[self setNeedsDisplay: YES];
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
		//to tell them we aren't interested
		highlight=YES;
		[self setNeedsDisplay: YES];
        return NSDragOperationNone;
    }
	
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
		//are offering
		highlight=YES;
		[self setNeedsDisplay: YES];        
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
		//to tell them we aren't interested
		highlight=YES;
		[self setNeedsDisplay: YES];
        return NSDragOperationNone;
    }
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    //we aren't particularily interested in this so we will do nothing
    //this is one of the methods that we do not have to implement
	
	highlight=NO;//remove highlight of the drop zone
    [self setNeedsDisplay: NO];
}

- (void)draggingEnded:(id <NSDraggingInfo>)sender
{
    //we don't do anything in our implementation
    //this could be ommitted since NSDraggingDestination is an infomal
	//protocol and returns nothing
	
	highlight=NO;//remove highlight of the drop zone
    [self setNeedsDisplay: NO];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
	//gets the dragging-specific pasteboard from the sender
	
	
	//need to know is this file dsdt.aml	
	//we have a list of file names in an NSData object
	NSArray *fileArray = 
	[paste propertyListForType:@"NSFilenamesPboardType"];
	//be caseful since this method returns id.  
	//We just happen to know that it will be an array.

	for (int i=0;i < [fileArray count]; i++) {
		NSString *path = [fileArray objectAtIndex:i];
		
		NSString *fileName = [[NSString alloc] initWithString:[path substringWithRange:NSMakeRange([path length] - 5, 5)]];
		//application path
		NSString *appPath = [[NSBundle mainBundle] bundlePath];
		
		if ([fileName isEqualToString:@".kext"]) {
			NSString *goodImagePath = [[NSString alloc] initWithString:[appPath stringByAppendingString:@"/Contents/Resources/images/good.png"]];		
			NSImage *goodImage = [[NSImage alloc] initWithContentsOfFile:goodImagePath];
			[kexts addObject:[[NSString alloc]initWithString:path]];
			[kexts retain];
			[self setImage:goodImage];
		} else {
			NSString *badImagePath = [[NSString alloc] initWithString:[appPath stringByAppendingString:@"/Contents/Resources/images/bad.png"]];		
			NSImage *badImage = [[NSImage alloc] initWithContentsOfFile:badImagePath];
			
			[self setImage:badImage];
			NSRunAlertPanel(@"Paste Error", 
							[NSString stringWithFormat:
							 @"Drag and drop \".kext\" files",
							 path], nil, nil, nil);
			return NO;		
		}
	}	
	
    [self setNeedsDisplay:NO];    //redraw us with the new image
    return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    //re-draw the view with our new data
    [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType, 
								   NSFilenamesPboardType, nil]];
    return self;
}

- (void)dealloc
{
    [self unregisterDraggedTypes];
    [super dealloc];
}

- (void)drawRect:(NSRect)rect
{
    NSRect ourBounds = [self bounds];
    NSImage *image = [self image];
    [super drawRect:rect];
    [image compositeToPoint:(ourBounds.origin) operation:NSCompositeSourceOver];
	[super drawRect:rect];//do the usual draw operation to display the image
    if(highlight){
        //highlight by overlaying a gray border
        [[NSColor grayColor] set];
        [NSBezierPath setDefaultLineWidth: 5];
        [NSBezierPath strokeRect: rect];
    }
}

- (void)setImage:(NSImage *)newImage
{
    NSImage *temp = [newImage retain];
    [_ourImage release];
    _ourImage = temp;
}

- (NSImage *)image
{
    return _ourImage;
}
- (NSMutableArray*)getKexts {
	return kexts;
}
@end
