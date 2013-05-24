//
//  APICallBack.h
//  myMARTiPad
//


@protocol APICallBackDelegate
- (void) onAPIFinished :(NSDictionary *)dictionary;
- (void) onAPIDidFailWithError :(NSError *)error;
@end

#import <Foundation/Foundation.h>

@interface APICallBack : NSObject  {
    
    id <APICallBackDelegate> delegate;
    
}

@property (retain, nonatomic) id <APICallBackDelegate> delegate;

- (void)setAPICallBackDelegate:(id <APICallBackDelegate>)apiCallBackDelegate;

- (void)netConnectionFinished:(NSDictionary *)dictionary;
- (void)netConnectionDidFailWithError:(NSError *)error;

@end
