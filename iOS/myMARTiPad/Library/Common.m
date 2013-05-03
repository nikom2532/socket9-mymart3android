//
//  Common.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "Common.h"

@implementation Common

/**
 * Method name: getRequestDateAndTimeForAPI
 * Description: <#description#>
 * Parameters: quickPin
 * Return: dateString
 */

+ (NSString *)getRequestDateAndTimeForAPI
{
    
    // Get Date/Time
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]]; // Set time to Australia time use GMT+8
    [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.FFF'Z'"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}

@end
