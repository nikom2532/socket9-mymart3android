//
//  myMARTiPadTestConfig.m
//  myMARTiPad

#import "myMARTiPadTestConfig.h"

@implementation myMARTiPadTestConfig

/*
 * Method name: waitAsyncTaskForSeconds
 * Description: Will run the loop for specified seconds in order to make delay from getting callback response
 * Parameters: waitForSeconds (int)
 */

+(void)waitAsyncTaskForSeconds : (int) waitForSeconds{
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:waitForSeconds];
    
    while ([loopUntil timeIntervalSinceNow] > 0){
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
}
 
@end
