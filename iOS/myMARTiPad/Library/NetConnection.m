//
//  NetConnection.m
//  myMARTiPad
//


#import "NetConnection.h"

@implementation NetConnection
@synthesize delegate;


/**
 * Method name: start
 * Description: Initialize a new object (the receiver) immediately after memory for it has been allocated.
 * Parameters: request
 */

- (id)initWithRequest:(NSURLRequest *)request{
    
	if (self = [super init]) {

        urlConnection      = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        responseData       = [NSMutableData data];
        
    }
    return self;
}


/**
 * Method name: start
 * Description: Start loding a connection 
 * Parameters: -
 */

- (void)start {
    
    [urlConnection start];
}

/**
 * Method name: connectionDidFinishLoading:
 * Description: Sent as a connection loads data incrementally. (required)
 * Parameters: connection
 */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    @try {
        
        [responseData appendData:data];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }

}


/**
 * Method name: connectionDidFinishLoading:
 * Description: Sent when a connection has finished loading successfully. (required)
 * Parameters: connection
 */

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    @try {
        
        // Convert AuthenticateJsonResult to NSDictionary
        NSError *error;
        resultDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                           options:kNilOptions
                                                             error:&error];
        responseData = nil;
        urlConnection = nil;
        
        [self.delegate netConnectionFinished:resultDictionary];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }

}

/**
 * Method name: connection:didFailWithError:
 * Description: Sent when a connection fails to load its request successfully.
 * Parameters: connection, error
 */

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    @try {
    
        [self.delegate netConnectionDidFailWithError:error];
    }
    @catch (NSException *exception) {
        
        LogManager *logManager = [[LogManager alloc]init];
        [logManager writeToLogFile:exception];
    }
    
}


@end
