//
//  FriendsMessageCell.h
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FriendsMessageModel.h"
@class FriendsMessageModel;
@interface FriendsMessageCell : UITableViewCell

@property(nonatomic,strong) FriendsMessageModel *model;
@property(nonatomic,assign) NSIndexPath *indexPath;
@end
