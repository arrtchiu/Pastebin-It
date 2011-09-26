//
//  PBPasteExpiry.m
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import "PBPasteExpiry.h"

#define kExpiriesFilename @"expiries"

static NSArray* __allExpiries = nil;

@interface PBPasteExpiry ()
@property (nonatomic, copy, readwrite) NSString* name;
@property (nonatomic, copy, readwrite) NSString* value;
@end


@interface PBPasteExpiry (Internal)
+ (NSArray*)_createArrayOfAllExpiries;
+ (PBPasteExpiry*)_expiryWithKey:(NSString*)key
                   matchingValue:(NSString*)value;
- (id)_initWithName:(NSString*)aName value:(NSString*)aValue;
@end


@implementation PBPasteExpiry
@synthesize name, value;

+ (NSArray*)allExpiries
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __allExpiries = [self _createArrayOfAllExpiries];
    });
    
    return __allExpiries;
}

+ (NSArray*)expiriesMatchingPredicate:(NSPredicate*)predicate
{
    return [[self allExpiries] filteredArrayUsingPredicate:predicate];
}

+ (PBPasteExpiry*)expiryMatchingPredicate:(NSPredicate*)predicate
{
    NSArray* expiries = [self expiriesMatchingPredicate:predicate];
    if ([expiries count]) {
        return [expiries objectAtIndex:0];
    }
    
    return nil;
}

+ (PBPasteExpiry*)expiryWithName:(NSString*)name
{
    return [self _expiryWithKey:PBPasteExpiryNameKey matchingValue:name];
}

+ (PBPasteExpiry*)expiryWithValue:(NSString*)value
{
    return [self _expiryWithKey:PBPasteExpiryValueKey matchingValue:value];
}

+ (PBPasteExpiry*)defaultExpiry
{
    //TODO: Put this in NSUserDefaults
    return [self expiryWithValue:@"N"];
}

+ (NSSortDescriptor*)bestSortDescriptor
{
    //TODO: Implement
    return [NSSortDescriptor sortDescriptorWithKey:PBPasteExpiryNameKey ascending:YES
                                        comparator:^NSComparisonResult(id obj1, id obj2) {
                                            return NSOrderedSame;
                                        }];
}
@end


@implementation PBPasteExpiry (Internal)
+ (NSArray*)_createArrayOfAllExpiries
{
    NSBundle* bundle = [NSBundle bundleForClass:self];
    NSURL* expiriesURL = [bundle URLForResource:kExpiriesFilename withExtension:@"plist"];
    NSDictionary* expiries = [NSDictionary dictionaryWithContentsOfURL:expiriesURL];
    NSMutableArray* expiriesObjects = [NSMutableArray arrayWithCapacity:[expiries count]];
    [expiries enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
#ifdef DEBUG
        NSAssert([key isKindOfClass:[NSString class]], @"Key in expiries plist not string!");
        NSAssert([obj isKindOfClass:[NSString class]], @"Object in expiries plist not string!");
#endif
        
        PBPasteExpiry* expiry = [[[self alloc] _initWithName:key value:obj] autorelease];
        [expiriesObjects addObject:expiry];
    }];
    
    return [[expiriesObjects copy] autorelease];
}

+ (PBPasteExpiry*)_expiryWithKey:(NSString*)key
                   matchingValue:(NSString*)value
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.%@ == %@", key, value];
    return [self expiryMatchingPredicate:predicate];
}

- (id)_initWithName:(NSString*)aName value:(NSString*)aValue
{
    if ((self = [self init])) {
        self.name  = aName;
        self.value = aValue;
    }
    
    return self;
}
@end
