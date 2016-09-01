//
//  TableViewCell.m
//  MACProject
//
//  Created by MacKun on 16/8/5.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)loadContent{
    self.stringLabel.text = self.dataAdapter.data;
}
+(CGFloat)cellHeightWithData:(id)data{
    NSString *str = data;
    return [str stringHeightWithFont:[UIFont systemFontOfSize:17] width:appWidth-20]+20;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
