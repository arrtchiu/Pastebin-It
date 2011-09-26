//
//  PBPasteWindowController.m
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import "PBPasteWindowController.h"
#import "PBPaste.h"
#import "PBPasteFormat.h"
#import "PBPasteExpiry.h"

static NSString* const kPBPasteWindowNibName = @"PBPasteWindow";


@interface PBPasteWindowController ()
@property (nonatomic, retain, readwrite) PBPaste* paste;
@property (nonatomic, retain, readwrite) NSArray* formatSortDescriptors;
@property (nonatomic, retain, readwrite) NSArray* expirySortDescriptors;
@end


@implementation PBPasteWindowController

#pragma mark Properties & KVO

@synthesize formatArrayController, expiryArrayController; 
@synthesize formatSortDescriptors, expirySortDescriptors, paste;

#pragma mark Lifecycle & Memory Management

- (id)initWithPaste:(PBPaste*)aPaste
{
    if ((self = [self initWithWindowNibName:kPBPasteWindowNibName])) {
        self.paste = aPaste;
        self.formatSortDescriptors = [NSArray arrayWithObject:[PBPasteFormat bestSortDescriptor]];
        self.expirySortDescriptors = [NSArray arrayWithObject:[PBPasteExpiry bestSortDescriptor]];
    }
    
    return self;
}

- (void)dealloc
{
    [self.paste unbind:PBPasteFormatKey];
    [self.paste unbind:PBPasteExpiryKey];
    self.paste = nil;
    self.formatSortDescriptors = nil;
    self.expirySortDescriptors = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.paste bind:PBPasteFormatKey toObject:formatArrayController withKeyPath:@"selection.self" options:nil];
    [self.paste bind:PBPasteExpiryKey toObject:expiryArrayController withKeyPath:@"selection.self" options:nil];
}

#pragma mark User Actions

- (IBAction)submitButtonPressed:(id)sender
{
    NSLog(@"submit: %@", self.paste);
}

- (IBAction)cancelButtonPressed:(id)sender
{
    //TODO: Ask the user if they're sure
    [self.window performClose:sender];
}
@end
