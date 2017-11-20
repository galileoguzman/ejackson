//
//  CardCell.m
//  Siete Dias
//
//  Created by Galileo Guzman on 8/28/16.
//  Copyright © 2016 Galileo Guzman. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.vContent.layer.masksToBounds = NO;
    self.vContent.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.vContent.layer.shadowOffset = CGSizeMake(0, 5);
    self.vContent.layer.shadowOpacity = 0.5;
    self.vContent.layer.shadowRadius = 5.0;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellOnTableView:(UITableView*)tableView didScrollOnView:(UIView*)view{
    CGRect rectInSuperView = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = (CGRectGetHeight(view.frame) + 80) - (CGRectGetMinY(rectInSuperView) - 40);
    float difference = CGRectGetHeight(self.imgNew.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.imgNew.frame;
    
    imageRect.origin.y = -(difference/2)+ (move-10);
    self.imgNew.frame = imageRect;
}

@end
