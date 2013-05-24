//
//  NSString+HexToByteConverter.m
//  myMARTiPad
//


#import "NSString+HexToByteConverter.h"

@implementation NSString (HexToByteConverter)


/**
 * Method name: convertHexToBytes
 * Description: Converting hex to array of byte
 * Parameters: -
 * Return: data
 */

- (NSData *)convertHexToBytes
{
    @try
    {
        if ([self length] != 0) {
            
            NSMutableData* data = [NSMutableData data];
            int idx;
            for (idx = 0; idx+2 <= self.length; idx+=2) {
                
                NSRange range = NSMakeRange(idx, 2);
                NSString *hexStr = [self substringWithRange:range];
                NSScanner *scanner = [NSScanner scannerWithString:hexStr];
                unsigned int intValue;
                [scanner scanHexInt:&intValue];
                [data appendBytes:&intValue length:1];
                
            }
  
            return data;
            
        }else{
            
            return nil;
        }
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
        
    }
}


@end
