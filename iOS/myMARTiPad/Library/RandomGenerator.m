//
//  RandomGenerator.m
//  MyMart
//

#import "RandomGenerator.h"

@implementation RandomGenerator


/**
 * Method name: getNewRandomKey
 * Description: Randomly generating string as a IV for encryption
 * Parameters: -
 * Return: randomString
 */

+ (NSString *)getNewRandomKey{
    
    @try {
        
        NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
        int len = 16;
        
        NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
        
        for (int i=0; i<len; i++) {
            
            [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
        }
       
        return randomString;
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }
   
}

@end