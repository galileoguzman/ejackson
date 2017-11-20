//
//  WebServices.h
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ArtistModel.h"

@interface WebServices : NSObject
+ (void)getJacksonWithCompletionHandler:(void (^)(NSMutableArray *response)) handler;
@end
