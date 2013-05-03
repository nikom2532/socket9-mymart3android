//
//  Login.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenticateAPI.h"

@interface Login : NSObject  {
    
    BOOL authenticated;
    BOOL isDeviceAlreadyRegistered;
    NSString *exceptionMessage;
    NSString *userID;
    NSString *errorMessage;
    
}

@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, assign) BOOL isDeviceAlreadyRegistered;
@property (nonatomic, retain) NSString *errorMessage;

- (void)loginWithUsernameAndPassword:(NSString *)username :(NSString *)password;
+ (Login *)sharedInstance ;
- (void) authenticateAPIFinished;
- (void)authenticateAPIDidFailWithError;


@end


