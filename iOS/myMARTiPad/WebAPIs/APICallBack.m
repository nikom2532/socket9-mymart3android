//
//  APICallBack.m
//  myMARTiPad
//


#import "APICallBack.h"

@implementation APICallBack
@synthesize delegate;


- (void)setAPICallBackDelegate:(id<APICallBackDelegate>)apiCallBackDelegate {
    
    self.delegate = apiCallBackDelegate;
    
}

/**
 * Method name: netConnectionFinished
 * Description: Sent when a NetConnection has finished loading successfully. (required)
 * Parameters: dictionary
 */

- (void)netConnectionFinished:(NSDictionary *)dictionary {
    
    [self.delegate onAPIFinished:dictionary];
}

/**
 * Method name: connectionDidFailWithError:
 * Description: Sent when a NetConnection fails to load its request successfully.
 * Parameters: error
 */

- (void)netConnectionDidFailWithError:(NSError *)error {
    
    [self.delegate onAPIDidFailWithError:error];
}

@end
