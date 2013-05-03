//
//  SignatureGenerator.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "SignatureGenerator.h"

@implementation SignatureGenerator

/**
 * Method name: getSignature
 * Description: <#description#>
 * Parameters: inputString, privateSignatureKey
 * Return: hashString
 */

+ (NSString *)getSignature :(NSString *)inputString :(NSString *)privateSignatureKey
{
    CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:inputString hmacKey:privateSignatureKey];
    NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
    
    return hashString;
}

@end
