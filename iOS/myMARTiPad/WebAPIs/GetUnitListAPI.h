//
//  GetUnitListAPI.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/23/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaSecurity.h"
#import "Common.h"
#import "RandomGenerator.h"
#import "SignatureGenerator.h"
#import "NSString+HexToByteConverter.h"
#import "Login.h"
#import "ConfigManager.h"
#import "UnitList.h"
#import "NetConnection.h"

@interface GetUnitListAPI : NSObject {
    
    BOOL unitListSuccess;
    NSArray *userUnitList;
    NSString *exceptionMessage;
    
    NSURLConnection *getUnitUrlConnection;
    NSMutableData   *getUnitResponseData;
    NSDictionary *resultDictionary;

}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void) getUnitList :(NSString *)userID :(NSString *)classID;
- (void)netConnectionFinished;
- (void)connectionDidFailWithError:(NSError *)error;


@end
