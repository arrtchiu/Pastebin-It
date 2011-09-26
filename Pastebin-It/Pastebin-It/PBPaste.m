//
//  PBPaste.m
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import "PBPaste.h"
#import "PBPasteFormat.h"
#import "PBPasteExpiry.h"

@implementation PBPaste
@synthesize text, title, private, format, expiry;

+ (id)pasteWithText:(NSString*)text
             format:(PBPasteFormat*)formatOrNil
             expiry:(PBPasteExpiry*)expiryOrNil
{
    return [[[self alloc] initWithText:text
                                format:formatOrNil
                                expiry:expiryOrNil] autorelease];
}

- (id)initWithText:(NSString*)pasteText
            format:(PBPasteFormat*)formatOrNil
            expiry:(PBPasteExpiry*)expiryOrNil
{
    if ((self = [self init])) {
        self.text   = pasteText;
        self.title  = @"";
        
        //TODO: put in NSUserDefaults
        self.private= [NSNumber numberWithInteger:NSOffState];
        
        self.format = (formatOrNil == nil) ? [PBPasteFormat defaultFormat] : formatOrNil;

        //TODO: turn nils into real objects
        self.expiry = expiryOrNil;
    }
    
    return self;
}

- (void)dealloc
{
    self.text   = nil;
    self.title  = nil;
    self.private= nil;
    self.format = nil;
    self.expiry = nil;
    [super dealloc];
}


- (NSString*)description
{
    return [NSString stringWithFormat:@"%@: Title: %@; Private: %@; Format: %@; Expiry: %@", [super description], self.title, self.private, self.format.name, self.expiry.name];
}
@end
