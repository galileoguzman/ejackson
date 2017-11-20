//
//  ListJacksonVC.h
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebServices.h"

#import "ArtistModel.h"
#import "CardCell.h"
#import "DetailSongVC.h"

@interface ListJacksonVC : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblContent;

@end
