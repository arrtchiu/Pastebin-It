//
//  PBPasteFormat.h
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const PBPasteFormatNameKey  = @"name";
static NSString* const PBPasteFormatValueKey = @"value";


@interface PBPasteFormat : NSObject
@property (nonatomic, copy, readonly) NSString* name;  /// Display name of format.
@property (nonatomic, copy, readonly) NSString* value; /// Value to be posted to pastebin for format.

+ (NSArray*)allFormats;
+ (NSArray*)formatsMatchingPredicate:(NSPredicate*)predicate;
+ (PBPasteFormat*)formatMatchingPredicate:(NSPredicate*)predicate;
+ (PBPasteFormat*)formatWithName:(NSString*)name;
+ (PBPasteFormat*)formatWithValue:(NSString*)value;
+ (PBPasteFormat*)defaultFormat;
+ (NSSortDescriptor*)bestSortDescriptor;
@end
