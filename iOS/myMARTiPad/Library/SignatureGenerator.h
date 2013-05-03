//
//  SignatureGenerator.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "NSString+HexToByteConverter.h"
#import "NSData+Base64Converter.h"

@interface SignatureGenerator : NSObject

+ (NSString *)getSignature :(NSString *)inputString :(NSString *)privateSignatureKey;

@end
