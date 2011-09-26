//
//  PBPaste.h
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const PBPasteFormatKey = @"format";
static NSString* const PBPasteExpiryKey = @"expiry";

@class PBPasteFormat, PBPasteExpiry;

@interface PBPaste : NSObject
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy, getter=isPrivate) NSNumber* private;
@property (nonatomic, retain) PBPasteFormat* format;
@property (nonatomic, retain) PBPasteExpiry* expiry;

+ (id)pasteWithText:(NSString*)pasteText
             format:(PBPasteFormat*)formatOrNil
             expiry:(PBPasteExpiry*)expiryOrNil;
- (id)initWithText:(NSString*)pasteText
            format:(PBPasteFormat*)formatOrNil
            expiry:(PBPasteExpiry*)expiryOrNil;
@end
