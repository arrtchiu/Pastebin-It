//
//  PBAppController.m
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import "PBAppController.h"
#import "PBPasteWindowController.h"
#import "PBPaste.h"
#import "PBPasteFormat.h"
#import "PBPasteExpiry.h"

static PBAppController* __sharedInstance = nil;


@interface PBAppController ()
@property (nonatomic, retain, readwrite) NSArray* pasteFormats;
@property (nonatomic, retain, readwrite) NSArray* pasteExpiries;
- (id)_init;
@end


@implementation PBAppController

#pragma mark Properties & KVO
@synthesize pasteFormats;
@synthesize pasteExpiries;

#pragma mark Lifecycle & Memory Management

+ (PBAppController*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[super alloc] _init];
    });
    
    return __sharedInstance;
}

//+ (id)allocWithZone:(NSZone *)zone
//{
//    return [self sharedInstance];
//}

- (id)retain
{
    return self;
}

- (id)autorelease
{
    return self;
}

- (oneway void)release
{
    //do nothing
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (id)init
{
    return [[self class] sharedInstance];
}

- (id)_init
{
    if ((self = [super init])) {
        self.pasteFormats  = [PBPasteFormat allFormats];
        self.pasteExpiries = [PBPasteExpiry allExpiries];
    }
    
    return self;
}

- (void)dealloc
{
    self.pasteFormats  = nil;
    self.pasteExpiries = nil;
    [super dealloc];
}

#pragma mark NSApplicationDelegate Methods

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [NSApp setServicesProvider:self];
    NSUpdateDynamicServices();
}

#pragma mark Service Methods

- (void)pastebinText:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)error
{
    NSArray* classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary* options = [NSDictionary dictionary];
    
    if (![pboard canReadObjectForClasses:classes options:options]) {
        *error = @"Invalid type.";
    }
    
    NSString* pboardString = [pboard stringForType:NSPasteboardTypeString];
    NSLog(@"String: %@", pboardString);
    
    PBPaste* paste = [PBPaste pasteWithText:pboardString
                                     format:nil
                                     expiry:nil];
    PBPasteWindowController* wc = [[PBPasteWindowController alloc] initWithPaste:paste];
    [wc showWindow:self];
}
@end
