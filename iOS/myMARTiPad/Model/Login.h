//
//  Login.h
//  MyMart
//


@protocol LoginDelegate
- (void) loginFinished;
- (void) loginDidFailWithError;
@end

#import <Foundation/Foundation.h>
#import "AuthenticateAPI.h"
#import "ConfigManager.h"
#import "LogManager.h"


@interface Login : NSObject  <APICallBackDelegate> {
    
    BOOL authenticated;
    BOOL isDeviceAlreadyRegistered;
    NSString *exceptionMessage;
    NSString *userID;
    NSString *errorMessage;
    
    id <LoginDelegate> delegate;
    id <InterfaceAuthenticateAPI> authenticateAPI;
    
}

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, assign) BOOL isDeviceAlreadyRegistered;
@property (nonatomic, retain) NSString *errorMessage;

@property (nonatomic, retain) id <LoginDelegate> delegate;


- (void)loginWithUsernameAndPassword:(NSString *)username :(NSString *)password;
+ (Login *)sharedInstance;
- (id)init:(id <InterfaceAuthenticateAPI>)api;

@end


