//
//  LogManager.h
//  myMARTiPad
//


#import <Foundation/Foundation.h>

@interface LogManager : NSObject {
    
}

- (void)writeToLogFile :(NSException *)logMessage;

@end
