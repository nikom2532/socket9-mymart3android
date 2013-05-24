//
//  LogManager.m
//  myMARTiPad
//

#import "LogManager.h"

@implementation LogManager


/**
 * Method name: writeToLogFile:
 * Description: Write exception message to file
 * Parameters: logMessage
 */

- (void)writeToLogFile :(NSException *)logMessage{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy_MM_dd"];
    NSDate *nowDate = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:nowDate];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",documentsDirectory,dateString];
    NSFileHandle *outputFile = [NSFileHandle fileHandleForWritingAtPath:fileName];
    NSData *dataToWrite = [[[logMessage callStackSymbols]objectAtIndex:0] dataUsingEncoding:NSUTF8StringEncoding];
    
    [outputFile seekToEndOfFile];
    [outputFile writeData:dataToWrite];
}

@end
