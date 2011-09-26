//
//  PBPasteExpiry.h
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const PBPasteExpiryNameKey  = @"name";
static NSString* const PBPasteExpiryValueKey = @"value";

@interface PBPasteExpiry : NSObject
@property (nonatomic, copy, readonly) NSString* name;  /// Display name of expiry.
@property (nonatomic, copy, readonly) NSString* value; /// Value to be posted to pastebin for expiry.

+ (NSArray*)allExpiries;
+ (NSArray*)expiriesMatchingPredicate:(NSPredicate*)predicate;
+ (PBPasteExpiry*)expiryMatchingPredicate:(NSPredicate*)predicate;
+ (PBPasteExpiry*)expiryWithName:(NSString*)name;
+ (PBPasteExpiry*)expiryWithValue:(NSString*)value;
+ (PBPasteExpiry*)defaultExpiry;
+ (NSSortDescriptor*)bestSortDescriptor;
@end
