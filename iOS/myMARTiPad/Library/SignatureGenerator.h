//
//  SignatureGenerator.h
//  MyMart
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "NSString+HexToByteConverter.h"
#import "NSData+Base64Converter.h"
#import "LogManager.h"

@interface SignatureGenerator : NSObject

+ (NSString *)getSignature :(NSString *)inputString :(NSString *)privateSignatureKey;

@end
