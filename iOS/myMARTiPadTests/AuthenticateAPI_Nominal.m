//
//  AuthenticateAPI_Nominal.m
//  myMARTiPad

#import "AuthenticateAPI_Nominal.h"

@implementation AuthenticateAPI_Nominal
@synthesize resultDictionary;

/**
 * Method name: authenticate
 * Description: Create URL for calling AutheticateAPI
 * Parameters: username, password
 */

- (void)authenticate : (NSString *)username : (NSString *)password
{
    NSArray *value = [NSArray arrayWithObjects:@"true",@"MockedAPI",@"bc9ce5ff-1731-457f-bee3-336a99165c22", nil];
    
    NSArray *key = [NSArray arrayWithObjects:@"Authenticated",@"ExceptionMessage",@"UserID", nil];
    
    NSMutableDictionary *authJSON = [NSMutableDictionary dictionaryWithObjects:value forKeys:key];
    
    resultDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:authJSON,@"AuthenticateJsonResult",nil];
    
    NSLog(@"Hello, I am from Mocked API");
    
    [self.delegate onAPIFinished:resultDictionary]; /// force callback to model with mocked result
}

@end