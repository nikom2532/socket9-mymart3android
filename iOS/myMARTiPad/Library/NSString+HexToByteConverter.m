//
//  NSString+HexToByteConverter.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "NSString+HexToByteConverter.h"

@implementation NSString (HexToByteConverter)



- (NSData *) convertHexToBytes
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
        
    }
    
    return data;
}

@end