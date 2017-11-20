//
//  DetailSongVC.m
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import "DetailSongVC.h"

@interface DetailSongVC ()

@end

@implementation DetailSongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initController{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:self.song.artworkUrl100]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // assign cell image on main thread
            self.imgSong.image = img;
            self.lblSong.text = self.song.trackCensoredName;
            self.lblArtist.text = self.song.artistName;
        });
    });
}

@end
