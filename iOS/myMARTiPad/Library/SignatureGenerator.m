//
//  SignatureGenerator.m
//  MyMart
//


#import "SignatureGenerator.h"

@implementation SignatureGenerator

/**
 * Method name: getSignature
 * Description: Generate signatuse by using SHMAC-256 algorithm
 * Parameters: inputString, privateSignatureKey
 * Return: hashString
 */

+ (NSString *)getSignature :(NSString *)inputString :(NSString *)privateSignatureKey
{

    @try {
        
        if ([inputString length] != 0 && [privateSignatureKey length] != 0) {
            
            CocoaSecurityResult *hmacsha256Result = [CocoaSecurity hmacSha256:inputString hmacKey:privateSignatureKey];
            NSString *hashString = [[[hmacsha256Result hexLower]convertHexToBytes]convertToBase64];
        
            return hashString;
            
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
