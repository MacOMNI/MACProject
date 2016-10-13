//
//  CommentCell.h
//  MACProject
//
//  Created by MacKun on 16/9/22.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "YYLabel.h"

@interface CommentCell : UITableViewCell

@property (nonatomic,strong) CommentModel *model;
@property (nonatomic,strong) YYLabel *commentLabel;


@end
