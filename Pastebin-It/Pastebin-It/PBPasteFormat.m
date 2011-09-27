//
//  PBPasteFormat.m
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import "PBPasteFormat.h"

#define kFormatsFilename @"formats"

static NSArray* __allFormats = nil;


@interface PBPasteFormat ()
@property (nonatomic, copy, readwrite) NSString* name;
@property (nonatomic, copy, readwrite) NSString* value;
@end


@interface PBPasteFormat (Internal)
+ (NSArray*)_createArrayOfAllFormats;
+ (PBPasteFormat*)_formatWithKey:(NSString*)key
                   matchingValue:(NSString*)value;
- (id)_initWithName:(NSString*)aName
              value:(NSString*)aValue;
@end


@implementation PBPasteFormat
@synthesize name, value;

+ (NSArray*)allFormats
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __allFormats = [self _createArrayOfAllFormats];
    });
    
    return __allFormats;
}

+ (NSArray*)formatsMatchingPredicate:(NSPredicate*)predicate
{
    return [[self allFormats] filteredArrayUsingPredicate:predicate];
}

+ (PBPasteFormat*)formatMatchingPredicate:(NSPredicate*)predicate
{
    NSArray* matches = [self formatsMatchingPredicate:predicate];
    if ([matches count]) {
        return [matches objectAtIndex:0];
    }
    
    return nil;
}

+ (PBPasteFormat*)formatWithName:(NSString*)name
{
    return [self _formatWithKey:PBPasteFormatNameKey matchingValue:name];
}

+ (PBPasteFormat*)formatWithValue:(NSString*)value
{
    return [self _formatWithKey:PBPasteFormatValueKey matchingValue:value];
}

+ (PBPasteFormat*)defaultFormat
{
    //TODO: Put this in NSUserDefaults
    return [self formatWithValue:@"text"];
}

+ (NSSortDescriptor*)bestSortDescriptor
{
    return [NSSortDescriptor sortDescriptorWithKey:PBPasteFormatNameKey ascending:YES];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@: Name: %@ Value: %@", [super description], [self name], [self value]];
}
@end


@implementation PBPasteFormat (Internal)
+ (NSArray*)_createArrayOfAllFormats
{
    
    NSBundle* bundle = [NSBundle bundleForClass:self];
    NSURL* formatFileURL = [bundle URLForResource:kFormatsFilename withExtension:@"plist"];
    NSDictionary* formats = [NSDictionary dictionaryWithContentsOfURL:formatFileURL];
    NSMutableArray* formatObjects = [NSMutableArray arrayWithCapacity:[formats count]];
    [formats enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

#ifdef DEBUG //only check for debug builds
        NSAssert([key isKindOfClass:[NSString class]], @"Key in format plist not string!");
        NSAssert([obj isKindOfClass:[NSString class]], @"Object in format plist not string!");
#endif
        
        PBPasteFormat* format = [[[self alloc] _initWithName:key value:obj] autorelease];
        [formatObjects addObject:format];
    }];
    
    return [formatObjects copy];
}

+ (PBPasteFormat*)_formatWithKey:(NSString*)key
                   matchingValue:(NSString*)value
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.%@ == %@", key, value];
    return [self formatMatchingPredicate:predicate];
}

- (id)_initWithName:(NSString*)aName
              value:(NSString*)aValue
{
    if ((self = [self init])) {
        self.name = aName;
        self.value = aValue;
    }
    
    return self;
}
@end
