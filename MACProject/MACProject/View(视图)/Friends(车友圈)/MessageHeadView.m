//
//  MessageHeadView.m
//  MACProject
//
//  Created by MacKun on 16/9/23.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MessageHeadView.h"
#import "MACImageGroupView.h"
#import "NSAttributedString+YYText.h"
#import "YYImage.h"
#import "NSDictionary+JKBlock.h"
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
        self.contentView.backgroundColor = [UIColor whiteColor];
        //头像
        _avactorImageView             = [[UIImageView alloc] init];
       // _avactorImageView.contentMode = UIViewContentModeScaleAspectFill;
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
        
        //点赞数量
        _goodNumLabel                 = [[UILabel alloc]init];
        _goodNumLabel.numberOfLines   = 1;
        // _goodNumLabel.backgroundColor = [UIColor RandomColor];
        _goodNumLabel.text            = @"66人点赞";
        _goodNumLabel.font            = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_goodNumLabel];
        [_goodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8.0);
            make.height.mas_equalTo(21.0);
            make.right.equalTo(self.contentView).offset(-8);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        //画线
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor appLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_goodNumLabel.mas_top).offset(-2);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.3f);
        }];
        
        //评论
        _addCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCommentBtn setImage:[UIImage imageNamed:@"friends_pingjia"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_addCommentBtn];
        [_addCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(line.mas_top).offset(3.0);
            make.right.equalTo(self.contentView.mas_right).offset(-8.0f);
            make.height.width.mas_equalTo(40);
        }];
        [_addCommentBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
        }];
        //点赞
        _addGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodBtn setImage:[UIImage imageNamed:@"friends_unGood"] forState:UIControlStateNormal];
        [_addGoodBtn setImage:[UIImage imageNamed:@"friends_setGood"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_addGoodBtn];
        [_addGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_addCommentBtn).offset(-2.0f);
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
            make.bottom.equalTo(_addCommentBtn);
            make.left.mas_equalTo(8.0);
            make.height.mas_equalTo(44.0);
            make.right.mas_equalTo(_addGoodBtn.mas_left).offset(-8);
        }];

        //图片
        _gridView = [[MACImageGroupView alloc] init];
        // _gridView.backgroundColor = [UIColor RandomColor];
        [self.contentView addSubview:_gridView];
        
 
        [_gridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_addCommentBtn.mas_top);
            make.left.equalTo(self.contentView).offset(10.0f);
            make.right.equalTo(self.contentView).offset(-8.0f);
            make.height.mas_equalTo(CGFLOAT_MIN);
        }];
        
        //内容
        _contentLabel                         = [[YYLabel alloc]init];
        _contentLabel.numberOfLines           = 0;
        _contentLabel.preferredMaxLayoutWidth = self.contentView.width-20;
       // _contentLabel.backgroundColor         = [UIColor RandomColor];
        _contentLabel.font                    = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_avactorImageView.mas_bottom).offset(3.0f);
            make.left.equalTo(self.contentView).offset(10.0f);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.mas_equalTo(_gridView.mas_top);
           // make.height.mas_equalTo(20);
        }];
        _contentLabel.textParser  = self.parser;


    }
    
    return self;
}
-(void)setModel:(FriendsMessageModel *)model{
    _model                               = model;
    _nameLabel.text                      = _model.userName;
    _timeLabel.text                      = _model.time;
    _browserNumLabel.text                = [NSString stringWithFormat:@"%ld次浏览",_model.browseNum];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_model.contentMessage];
    attributedString.yy_font             = [UIFont systemFontOfSize:17.0f];
    _contentLabel.attributedText         = attributedString;
    _goodNumLabel.text                   = [NSString stringWithFormat:@"%ld人点赞",_model.goodNum];
    _gridView.dataSource                 = _model.picArray;
    [_avactorImageView mac_setImageWithURL:_model.avactor.macUrl placeholderImage:[UIImage imageNamed:@"placeholder_dropbox"]];


}
+(CGFloat)caculateHeight:(FriendsMessageModel *)model{
    CGFloat height       = 62.0f + 70.0f + ((model.picArray.count+2)/3)*(appWidth/3.0);
    NSMutableAttributedString *text =[[NSMutableAttributedString alloc] initWithString:model.contentMessage];
    text.yy_font         = [UIFont systemFontOfSize:17.0f];

    CGSize size          = CGSizeMake(appWidth - 20, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    CGSize sizeText      = layout.textBoundingSize;
    height               += sizeText.height;
    return height;
}
-(void)setParser:(YYTextSimpleEmoticonParser *)parser{
    if (!_parser) {
        _parser = parser;
        _contentLabel.textParser  = parser;
    }
}
@end
