//
//  ClassList.h
//  MyMart
//
//  Created by Komsan Noipitak on 4/24/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetClassListAPI.h"

@interface ClassList : NSObject {
    
    BOOL classListSuccess;
    BOOL reportingPeriod;
    BOOL isUserHasOnlyOneClass;
    NSArray *userClassList;
    NSString *exceptionMessage;
    NSString *errorMessage;
    
  
}

@property (nonatomic, assign) BOOL classListSuccess;
@property (nonatomic, assign) BOOL reportingPeriod;
@property (nonatomic, retain) NSArray *userClassList;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, assign) BOOL isUserHasOnlyOneClass;
@property (nonatomic, retain) NSString *errorMessage;


- (void) getClassList :(NSString *)userID;
+ (ClassList *)sharedInstance ;
- (void)getClassListAPIFinished;
- (void)getClassListAPIDidFailWithError;


@end
