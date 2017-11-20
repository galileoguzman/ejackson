//
//  ArtistModel.h
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ArtistModel
@end

@interface ArtistModel : JSONModel
@property (nonatomic, strong) NSString* kind;
@property (nonatomic, strong) NSString* artistName;
//@property (nonatomic, strong) NSString* collectionName;
//@property (nonatomic, strong) NSString* collectionCensoredName;
@property (nonatomic, strong) NSString* trackCensoredName;
//@property (nonatomic, strong) NSString* artistViewUrl;
@property (nonatomic, strong) NSString* artworkUrl30;
@property (nonatomic, strong) NSString* artworkUrl60;
@property (nonatomic, strong) NSString* artworkUrl100;
@property (nonatomic, strong) NSNumber* trackPrice;
@end
