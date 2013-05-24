//
//  NSString+HexToByteConverter.h
//  myMARTiPad
//

#import <Foundation/Foundation.h>
#import "LogManager.h"

@interface NSString (HexToByteConverter)

- (NSData *)convertHexToBytes;

@end
