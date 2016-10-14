//
//  FriendsMessageCell.m
//  MACProject
//
//  Created by MacKun on 16/9/21.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "FriendsMessageCell.h"
#import "YYText.h"
#import "MACImageGroupView.h"
#import "CommentCell.h"
//#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
@interface FriendsMessageCell()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic,strong) UIImageView  *avactorImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) YYLabel *contentLabel;
@property (nonatomic,strong) MACImageGroupView *gridView;//图片
@property (nonatomic,strong) UILabel *browserNumLabel;//浏览次数
@property (nonatomic,strong) UIButton *addGoodBtn;//点赞
@property (nonatomic,strong) UIButton *addCommentBtn;//评论
@property (nonatomic,strong) UILabel *goodNumLabel;//点赞数量
@property (nonatomic,strong) UITableView *commentTableView;//评论列表
@end

@implementation FriendsMessageCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        //头像
        _avactorImageView             = [[UIImageView alloc] init];
        _avactorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avactorImageView.image       = [UIImage imageNamed:@"placeholder_dropbox"];
        [self.contentView addSubview:_avactorImageView];
        [_avactorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(8);
            make.width.height.mas_equalTo(44);
        }];
        //姓名
        _nameLabel                 = [[UILabel alloc]init];
        _nameLabel.numberOfLines   = 1;
        _nameLabel.text            = @"麦克坤";
      //  _nameLabel.backgroundColor = [UIColor RandomColor];
        _nameLabel.font            = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avactorImageView.mas_right).offset(8);
            make.top.equalTo(_avactorImageView.mas_top);
            make.height.mas_equalTo(21.f);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        //时间
        _timeLabel                 = [[UILabel alloc]init];
        _timeLabel.numberOfLines   = 1;
        //_timeLabel.backgroundColor = [UIColor RandomColor];
        
        _timeLabel.font            = [UIFont systemFontOfSize:15.0f];
        _timeLabel.text            = @"2016.09.28 10:30";
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_left);
            make.top.equalTo(_nameLabel.mas_bottom).offset(2);
            make.height.mas_equalTo(21.f);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];

        //内容
        _contentLabel                 = [[YYLabel alloc]init];
        _contentLabel.numberOfLines   = 0;
        _contentLabel.preferredMaxLayoutWidth = self.contentView.width-16;
      //  _contentLabel.backgroundColor = [UIColor RandomColor];
        _contentLabel.font            = [UIFont systemFontOfSize:17.0f];
        _contentLabel.text            = @"简单测试一下";
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avactorImageView.mas_bottom);
            make.left.mas_equalTo(8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        
        //图片
        _gridView = [[MACImageGroupView alloc] init];
       // _gridView.backgroundColor = [UIColor RandomColor];
        [self.contentView addSubview:_gridView];
        [_gridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom);
            make.left.mas_equalTo(8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];

      
        //评论
        _addCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCommentBtn setTitle:@"评论" forState:UIControlStateNormal];
        //_addCommentBtn.tintColor = [UIColor RandomColor];
        _addCommentBtn.backgroundColor = [UIColor RandomColor];
        [self.contentView addSubview:_addCommentBtn];
        [_addCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_gridView.mas_bottom).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.height.width.mas_equalTo(44);
        }];

        //点赞
        _addGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodBtn setTitle:@"点赞" forState:UIControlStateNormal];
       // _addGoodBtn.tintColor = [UIColor RandomColor];
        _addGoodBtn.backgroundColor = [UIColor RandomColor];

        [self.contentView addSubview:_addGoodBtn];
        [_addGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_addCommentBtn.mas_top);
            make.right.equalTo(_addCommentBtn.mas_left).offset(-8);
            make.height.width.mas_equalTo(44);
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

       //点赞数量
        _goodNumLabel                 = [[UILabel alloc]init];
        _goodNumLabel.numberOfLines   = 1;
       // _goodNumLabel.backgroundColor = [UIColor RandomColor];
        _goodNumLabel.text            = @"66人点赞";
        _goodNumLabel.font            = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_goodNumLabel];
        [_goodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_browserNumLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(8.0);
            make.height.mas_equalTo(21.0);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
           // make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);

        }];
        //评论列表
        _commentTableView = [[UITableView alloc]init];
        _commentTableView.scrollEnabled = NO;

        _commentTableView.tableFooterView = [UIView new];
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_commentTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        [self.contentView addSubview:_commentTableView];
        [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_goodNumLabel.mas_bottom);
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)setModel:(FriendsMessageModel *)model{
    _model                = model;
    _browserNumLabel.text = @"66次浏览";
    _contentLabel.text    = @"张三回复王五： 这是使用 Objective-C 整理的一套 iOS 轻量级框架，内部包含大量或自己整理或修改自网络的 Category 、Utils、DataManager、Macros & UIComponents 旨在快速构建中小型 iOS App，并尝试用其整理了个 MACProject 样例以来抛砖引玉，愿与大犇们相互学习交流，不足之处望批评指正， 更欢迎 Star。";
    _goodNumLabel.text    = @"66人点赞";
    _gridView.dataSource  = @[@"http://f1.diyitui.com/91/b2/f2/a3/5c/6d/5a/0a/97/bb/1a/09/90/d2/ff/cc.jpg",
                             @"http://news.mydrivers.com/Img/20101001/11525723.jpg",
                             @"http://pic1.882668.com.160cha.com/882668/2016/09/18/121526458.jpg"];
    CGFloat height = 0;
    //[_commentTableView reloadData];

//    for (NSInteger i =0;i< 3; i++) {
//        height += [_commentTableView fd_heightForCellWithIdentifier:@"CommentCell" configuration:^(id cell) {
//            [self configureCell:cell atIndexPath:nil];
//        }];
//    }
     for (NSInteger i = 0;i< 3; i++) {
//         height += [CommentCell hyb_heightForTableView:_commentTableView config:^(UITableViewCell *sourceCell) {
//             CommentCell *cell = (CommentCell *)sourceCell;
//             [self configureCell:cell atIndexPath:nil];
//
//         }];
         height += [CommentCell hyb_heightForTableView:_commentTableView config:^(UITableViewCell *sourceCell) {
             CommentCell *cell = (CommentCell *)sourceCell;
             [self configureCell:cell atIndexPath:_indexPath];
         } cache:^NSDictionary *{
             NSDictionary *cache = @{kHYBCacheUniqueKey : @(_indexPath.row),
                                     kHYBCacheStateKey : @"",
                                     kHYBRecalculateForStateKey : @(NO)};
             //        model.shouldUpdateCache = NO;
             return cache;
         }];

    }

    [_commentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
#pragma  mark tableView datasource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    if (cell) {
    //        cell=[[FriendsMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendsCell"];
    //    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat cell_height = [CommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CommentCell *cell = (CommentCell *)sourceCell;
       [self configureCell:cell atIndexPath:indexPath];
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : @(indexPath.row),
                                kHYBCacheStateKey : @"",
                                kHYBRecalculateForStateKey : @(NO)};
        //        model.shouldUpdateCache = NO;
        return cache;
    }];
    return cell_height;
    
//    return [tableView fd_heightForCellWithIdentifier:@"CommentCell" cacheByIndexPath:indexPath configuration:^(id cell) {
//        // configurations
//        [self configureCell:cell atIndexPath:indexPath];
//
//    }];
}
#pragma  mark  configureCell
- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
   // cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
