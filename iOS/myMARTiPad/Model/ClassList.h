//
//  ClassList.h
//  MyMart
//


@protocol ClassListDelegate
- (void) classListFinished;
- (void) classListDidFailWithError;
@end

#import <Foundation/Foundation.h>
#import "GetClassListAPI.h"
#import "ConfigManager.h"
#import "LogManager.h"

@interface ClassList : NSObject <APICallBackDelegate>{
    
    BOOL classListSuccess;
    BOOL reportingPeriod;
    BOOL isUserHasOnlyOneClass;
    NSArray *userClassList;
    NSString *exceptionMessage;
    NSString *errorMessage;
    
    id <ClassListDelegate> delegate;
    id <InterfaceGetClassListAPI> getClassListAPI;

}

@property (nonatomic, assign) BOOL classListSuccess;
@property (nonatomic, assign) BOOL reportingPeriod;
@property (nonatomic, retain) NSArray *userClassList;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, assign) BOOL isUserHasOnlyOneClass;
@property (nonatomic, retain) NSString *errorMessage;

@property (nonatomic, retain) id <ClassListDelegate> delegate;

- (void) getClassList :(NSString *)userID;
+ (ClassList *)sharedInstance ;
- (id)init:(id <InterfaceGetClassListAPI>)api;


@end
