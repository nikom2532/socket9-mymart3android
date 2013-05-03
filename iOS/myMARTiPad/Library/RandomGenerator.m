//
//  RandomGenerator.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "RandomGenerator.h"

@implementation RandomGenerator


/**
 * Method name: getNewRandomKey
 * Description: <#description#>
 * Parameters: -
 * Return: randomString
 */

+ (NSString *)getNewRandomKey {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    int len = 32;
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    
    for (int i=0; i<len; i++) {
        
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end