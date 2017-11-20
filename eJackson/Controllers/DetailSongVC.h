//
//  DetailSongVC.h
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtistModel.h"

@interface DetailSongVC : UIViewController
@property (nonatomic, strong)ArtistModel* song;
@property (weak, nonatomic) IBOutlet UIImageView *imgSong;
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;
@property (weak, nonatomic) IBOutlet UILabel *lblSong;


@end
