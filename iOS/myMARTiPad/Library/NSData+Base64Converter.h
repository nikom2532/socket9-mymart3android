//
//  NSData+Base64Converter.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogManager.h"

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (Base64Converter)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)convertToBase64;

// added by Hiroshi Hashiguchi
- (NSString *)base64EncodedStringWithSeparateLines:(BOOL)separateLines;

@end
