//
//  GetClassListAPI.h
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
#import "ConfigManager.h"
#import "ClassList.h"
#import "NetConnection.h"


@interface GetClassListAPI : NSObject {
    
    BOOL classListSuccess;
    BOOL reportingPeriod;
    NSArray *userClassList;
    NSString *exceptionMessage;
    
    NSURLConnection *getClassUrlConnection;
    NSMutableData *getClassResponseData;
    NSDictionary *resultDictionary;
    
}

@property (retain, nonatomic) NSDictionary *resultDictionary;

- (void) getClassList :(NSString *)userID;
- (void)netConnectionFinished;
- (void)connectionDidFailWithError:(NSError *)error;


@end
