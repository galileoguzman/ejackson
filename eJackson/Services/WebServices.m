//
//  WebServices.m
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import "WebServices.h"

#define URLGetJackson     @"https://itunes.apple.com/search?term=Michael+jackson"


@implementation WebServices


+ (void)getJacksonWithCompletionHandler:(void (^)(NSMutableArray *response)) handler{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible   = YES;
    
    
    NSURLSession *session = [self getSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setURL:[NSURL URLWithString:URLGetJackson]];
    [request setHTTPMethod:@"GET"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"ERROR %@", error.description);
            handler(nil);
        }else{
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            //NSLog(@"RESPONSE\n %@", jsonResponse);
            if(jsonResponse!=nil){
                
                NSError* err = nil;
                NSMutableArray *responseObjects = [ArtistModel arrayOfModelsFromDictionaries:[jsonResponse objectForKey:@"results"] error:&err];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler((NSMutableArray*)responseObjects);
                });
            }
            else{
                handler(nil);
            }
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible   = NO;
        
    }] resume];
    
}

//--------------------------------------------------------------------------------------------
+(NSURLSession *)getSession{
    
    // Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Configure Session Configuration
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPMaximumConnectionsPerHost:20];
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Accept" : @"application/json"}];
    
    return [NSURLSession sessionWithConfiguration:sessionConfiguration];
}
//*********************************************************************************************
#pragma mark                                alloc
//*********************************************************************************************
+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'WebServices' cannot be instantiated!"];
    return nil;
}


@end
