//
//  UnitList.h
//  MyMart
//


@protocol UnitListDelegate
- (void) unitListFinished;
- (void) unitListDidFailWithError;
@end

#import <Foundation/Foundation.h>
#import "GetUnitListAPI.h"
#import "ConfigManager.h"
#import "LogManager.h"

@interface UnitList : NSObject <APICallBackDelegate> {
    
    BOOL unitListSuccess;
    BOOL isUserHasOnlyOneUnit;
    NSArray *userUnitList;
    NSString *exceptionMessage;
    NSString *errorMessage;
   
    id <UnitListDelegate> delegate;
    id <InterfaceGetUnitListAPI> getUnitListAPI;
}

@property (nonatomic, assign) BOOL unitListSuccess;
@property (nonatomic, retain) NSArray *userUnitList;
@property (nonatomic, retain) NSString *exceptionMessage;
@property (nonatomic, assign) BOOL isUserHasOnlyOneUnit;
@property (nonatomic, retain) NSString *errorMessage;

@property (nonatomic, retain) id <UnitListDelegate> delegate;

- (void)getUnitList :(NSString *)userID :(NSString *)classID;
+ (UnitList *)sharedInstance;
- (id)init:(id <InterfaceGetUnitListAPI>)api;


@end
