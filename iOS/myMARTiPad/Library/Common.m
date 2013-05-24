//
//  Common.m
//  MyMart
//

#import "Common.h"

@implementation Common

/**
 * Method name: getRequestDateAndTimeForAPI
 * Description: Get date and time to generate signature for calling API
 * Parameters: quickPin
 * Return: dateString
 */

+ (NSString *)getRequestDateAndTimeForAPI
{
    @try {
        
        // Get Date/Time
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]]; // Set time to Australia time use GMT+8
        [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss.FFF'Z'"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        return dateString;
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }
    
}

@end
