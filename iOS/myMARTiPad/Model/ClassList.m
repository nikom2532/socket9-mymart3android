//
//  ClassList.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "ClassList.h"

@implementation ClassList
@synthesize classListSuccess;
@synthesize reportingPeriod;
@synthesize userClassList;
@synthesize exceptionMessage;
@synthesize isUserHasOnlyOneClass;
@synthesize errorMessage;

static ClassList *sharedInstance = nil;


+ (ClassList *)sharedInstance
{
    if (sharedInstance == nil) {
        
        sharedInstance =[[super allocWithZone:NULL]init];
        
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Call WebAPIs ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getClassList
 * Description: For Calling GetClassList API
 * Parameters: userID
 */

- (void)getClassList:(NSString *)userID{
    
    GetClassListAPI *getClassListAPI = [[GetClassListAPI alloc]init];
    [getClassListAPI getClassList:userID];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getClassListAPIFinished
 * Description: Sent when GetClassListAPI has finished calling successfully. 
 * Parameters: -
 */

- (void)getClassListAPIFinished{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"classList"
                                                       object:nil];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: authenticateAPIFinished
 * Description: Sent when GetClassListAPI fails to load successfully.
 * Parameters: -
 */

- (void)getClassListAPIDidFailWithError{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"classListError"
                                                       object:nil];
}




@end
