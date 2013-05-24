//
//  NetConnection.h
//  myMARTiPad
//


@protocol NetConnectionDelegate
- (void) netConnectionFinished :(NSDictionary *)dictionary;
- (void) netConnectionDidFailWithError :(NSError *)error;
@end

#import <Foundation/Foundation.h>
#import "AuthenticateAPI.h"
#import "AuthenticateDeviceQuickPinAPI.h"
#import "RegisterDeviceQuickPinAPI.h"
#import "GetClassListAPI.h"
#import "GetUnitListAPI.h"
#import "LogManager.h"

@interface NetConnection : NSObject <NSURLConnectionDelegate> {
    
    NSURLConnection *urlConnection;
    NSMutableData *responseData;
    NSDictionary *resultDictionary;
    
    id <NetConnectionDelegate> delegate;
}

@property (nonatomic, retain) id <NetConnectionDelegate> delegate;

- (id)initWithRequest:(NSURLRequest *)request;
- (void)start;

@end
