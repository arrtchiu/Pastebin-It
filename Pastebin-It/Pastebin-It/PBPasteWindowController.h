//
//  PBPasteWindowController.h
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PBPaste;

@interface PBPasteWindowController : NSWindowController
@property (nonatomic, assign) IBOutlet NSArrayController* formatArrayController;
@property (nonatomic, assign) IBOutlet NSArrayController* expiryArrayController;
@property (nonatomic, retain, readonly) NSArray* formatSortDescriptors;
@property (nonatomic, retain, readonly) NSArray* expirySortDescriptors;
@property (nonatomic, retain, readonly) PBPaste* paste;

- (id)initWithPaste:(PBPaste*)paste;
- (IBAction)submitButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
@end
