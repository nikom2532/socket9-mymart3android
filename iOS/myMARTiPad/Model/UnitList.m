//
//  UnitList.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "UnitList.h"

@implementation UnitList
@synthesize unitListSuccess;
@synthesize userUnitList;
@synthesize exceptionMessage;
@synthesize isUserHasOnlyOneUnit;
@synthesize errorMessage;

static UnitList *sharedInstance = nil;

+ (UnitList *)sharedInstance
{
    if (sharedInstance==nil) {
        
        sharedInstance =[[super allocWithZone:NULL]init];
        
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Call WebAPIs ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getUnitList
 * Description: For Calling GetUnitList API
 * Parameters: userID, classID
 */

- (void)getUnitList:(NSString *)userID :(NSString *)classID{
    
    GetUnitListAPI *getUnitListAPI = [[GetUnitListAPI alloc]init];
    [getUnitListAPI getUnitList:userID :classID];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getUnitListAPIFinished
 * Description: Sent when GetUnitListAPI has finished calling successfully.
 * Parameters: -
 */

- (void)getUnitListAPIFinished
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"unitList"
                                                       object:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent when GetUnitListAPI fails to load successfully.
 * Parameters: -
 */

- (void)getUnitListAPIDidFailWithError{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"unitListError"
                                                       object:nil];
}


@end
