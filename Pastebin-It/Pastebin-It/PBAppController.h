//
//  PBAppController.h
//  Pastebin-It
//
//  Created by Matthew Urquhart on 23/09/11.
//  Copyright 2011 XciteLogic Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBAppController : NSObject <NSApplicationDelegate>
@property (nonatomic, retain, readonly) NSArray* pasteFormats;
@property (nonatomic, retain, readonly) NSArray* pasteExpiries;

+ (PBAppController*)sharedInstance;
- (void)pastebinText:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)error;
@end
