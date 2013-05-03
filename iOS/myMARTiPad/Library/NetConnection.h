//
//  NetConnection.h
//  myMARTiPad
//
//  Created by Komsan Noipitak on 5/3/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthenticateAPI.h"
#import "AuthenticateDeviceQuickPinAPI.h"
#import "RegisterDeviceQuickPinAPI.h"
#import "GetClassListAPI.h"
#import "GetUnitListAPI.h"

@interface NetConnection : NSObject <NSURLConnectionDelegate> {
    
    NSURLConnection *urlConnection;
    NSMutableData *responseData;
    NSDictionary *resultDictionary;
    NSString *tag;
}


- (id)initWithRequest:(NSURLRequest *)request tag:(NSString *)tag;
- (void)start;

@end
