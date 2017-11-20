//
//  CardCell.h
//  Siete Dias
//
//  Created by Galileo Guzman on 8/28/16.
//  Copyright © 2016 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgNew;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSummary;
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblPublishDate;


-(void)cellOnTableView:(UITableView*)tableView didScrollOnView:(UIView*)view;
@end
