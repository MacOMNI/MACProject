//
//  MessageHeadView.m
//  MACProject
//
//  Created by MacKun on 16/9/23.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MessageHeadView.h"
#import "YYLabel.h"
#import "MACImageGroupView.h"
@interface MessageHeadView(){
    
}
@property (nonatomic,strong) UIView  *headView;
@property (nonatomic,strong) UIImageView  *avactorImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) YYLabel *contentLabel;
@property (nonatomic,strong) MACImageGroupView *gridView;//图片
@property (nonatomic,strong) UILabel *browserNumLabel;//浏览次数
@property (nonatomic,strong) UIButton *addGoodBtn;//点赞
@property (nonatomic,strong) UIButton *addCommentBtn;//评论
@property (nonatomic,strong) UILabel *goodNumLabel;//点赞数量
@end

@implementation MessageHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor          = [UIColor whiteColor];
        //headView
//        _headView                     = [UIView new];
//        _headView.backgroundColor     = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1] ;
//        [self.contentView addSubview:_headView];
//        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.width.mas_equalTo(self.contentView);
//            make.height.mas_equalTo(15.0f);
//        }];
        //头像
        _avactorImageView             = [[UIImageView alloc] init];
        _avactorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avactorImageView.image       = [UIImage imageNamed:@"placeholder_dropbox"];
        [self.contentView addSubview:_avactorImageView];
        [_avactorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).offset(10.0f);
            make.width.height.mas_equalTo(44.0f);
        }];
        //姓名
        _nameLabel                 = [[UILabel alloc]init];
        _nameLabel.numberOfLines   = 1;
        _nameLabel.text            = @"麦克坤";
        _nameLabel.font            = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avactorImageView.mas_right).offset(10);
            make.top.equalTo(_avactorImageView.mas_top);
            make.height.mas_equalTo(21.f);
            make.right.equalTo(self.contentView.mas_right);
        }];
        //时间
        _timeLabel                 = [[UILabel alloc]init];
        _timeLabel.numberOfLines   = 1;
        _timeLabel.font            = [UIFont systemFontOfSize:15.0f];
        _timeLabel.text            = @"2016.09.28 10:30";
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_left);
            make.top.equalTo(_nameLabel.mas_bottom).offset(2);
            make.height.mas_equalTo(21.f);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        //内容
        _contentLabel                         = [[YYLabel alloc]init];
        _contentLabel.numberOfLines           = 0;
        _contentLabel.preferredMaxLayoutWidth = self.contentView.width-20;
        _contentLabel.backgroundColor         = [UIColor RandomColor];
        _contentLabel.font                    = [UIFont systemFontOfSize:17.0f];
        _contentLabel.text                    = @"简单测试一下";
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avactorImageView.mas_bottom).offset(10.0f);
            make.left.equalTo(self.contentView).offset(10.0f);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        //图片
        _gridView = [[MACImageGroupView alloc] init];
        // _gridView.backgroundColor = [UIColor RandomColor];
        [self.contentView addSubview:_gridView];
        [_gridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom);
            make.left.equalTo(self.contentView).offset(10.0f);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        
        
        //评论
        _addCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCommentBtn setImage:[UIImage imageNamed:@"friends_pingjia"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_addCommentBtn];
        [_addCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_gridView.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.height.width.mas_equalTo(44);
        }];
        [_addCommentBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
        }];
        //点赞
        _addGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodBtn setImage:[UIImage imageNamed:@"friends_unGood"] forState:UIControlStateNormal];
        [_addGoodBtn setImage:[UIImage imageNamed:@"friends_setGood"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_addGoodBtn];
        [_addGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_addCommentBtn.mas_top);
            make.right.equalTo(_addCommentBtn.mas_left);
            make.height.width.mas_equalTo(40);
        }];
        [_addGoodBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
        }];
        //浏览量
        _browserNumLabel                 = [[UILabel alloc]init];
        _browserNumLabel.numberOfLines   = 1;
        //_browserNumLabel.backgroundColor = [UIColor RandomColor];
        _browserNumLabel.text            = @"66次浏览";
        _browserNumLabel.font            = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_browserNumLabel];
        [_browserNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_addCommentBtn.mas_top);
            make.left.mas_equalTo(8.0);
            make.height.mas_equalTo(44.0);
            make.right.mas_equalTo(_addGoodBtn.mas_left).offset(-8);
        }];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor appLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_browserNumLabel.mas_bottom);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.3f);
        }];
        //点赞数量
        _goodNumLabel                 = [[UILabel alloc]init];
        _goodNumLabel.numberOfLines   = 1;
        // _goodNumLabel.backgroundColor = [UIColor RandomColor];
        _goodNumLabel.text            = @"66人点赞";
        _goodNumLabel.font            = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_goodNumLabel];
        [_goodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(5);
            make.left.mas_equalTo(8.0);
            make.height.mas_equalTo(21.0);
            make.right.equalTo(self.contentView).offset(-8);
            make.bottom.equalTo(self.contentView).offset(-8);
        }];
    }
    
    return self;
}
-(void)setModel:(FriendsMessageModel *)model{
    _model                = model;
    _browserNumLabel.text = @"66次浏览";
    _contentLabel.text    = @"这是使用 Objective-C 整理的一套 iOS 轻量级框架，内部包含大量或自己整理或修改自网络的 Category 、Utils、DataManager、Macros & UIComponents 旨在快速构建中小型 iOS App，并尝试用其整理了个 MACProject 样例以来抛砖引玉，愿与大犇们相互学习交流，不足之处望批评指正， 更欢迎 Star。";
    _goodNumLabel.text    = @"66人点赞";
    _gridView.dataSource  = @[@"http://f1.diyitui.com/91/b2/f2/a3/5c/6d/5a/0a/97/bb/1a/09/90/d2/ff/cc.jpg",
                              @"http://news.mydrivers.com/Img/20101001/11525723.jpg",
                              @"http://pic1.882668.com.160cha.com/882668/2016/09/18/121526458.jpg"];
}

@end
