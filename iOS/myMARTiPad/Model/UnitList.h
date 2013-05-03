//
//  UnitList.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetUnitListAPI.h"

@interface UnitList : NSObject {
    
    BOOL unitListSuccess;
    BOOL isUserHasOnlyOneUnit;
    NSArray *userUnitList;
    NSString *exceptionMessage;
    NSString *errorMessage;
   
    
}

@property (nonatomic, assign) BOOL unitListSuccess;
@property (nonatomic, retain) NSArray *userUnitList;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, assign) BOOL isUserHasOnlyOneUnit;
@property (nonatomic, retain) NSString *errorMessage;

- (void)getUnitList :(NSString *)userID :(NSString *)classID;
+ (UnitList *)sharedInstance;
- (void)getUnitListAPIFinished;
- (void)getUnitListAPIDidFailWithError;



@end
