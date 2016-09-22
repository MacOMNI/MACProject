//
//  CommentCell.m
//  MACProject
//
//  Created by MacKun on 16/9/22.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "CommentCell.h"
#import "YYLabel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
@interface CommentCell(){
    
}

@property (nonatomic,strong) YYLabel *commentLabel;

@end

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _commentLabel = [[YYLabel alloc] init];
        [self.contentView addSubview:self.commentLabel];
       // _commentLabel.backgroundColor  = [UIColor RandomColor];
        _commentLabel.preferredMaxLayoutWidth = appWidth - 16;
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
        }];
        
        self.hyb_lastViewInCell = _commentLabel;
        self.hyb_bottomOffsetToCell = 3.0;//cell底部距离为3.0个间隙
       // self.commentLabel.constraints.
    }
    return self;
}
-(void)setModel:(CommentModel *)model{
    _model = model;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString: @"张三回复王五： 这是使用 Objective-C 整理的一套 iOS 轻量级框架，内部包含大量或自己整理或修改自网络的 Category 、Utils、DataManager、Macros & UIComponents 旨在快速构建中小型 iOS App，并尝试用其整理了个 MACProject 样例以来抛砖引玉，愿与大犇们相互学习交流，不足之处望批评指正， 更欢迎 Star。"];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, 2)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(4, 2)];
//    _commentLabel.attributedText = text;
   // self.textLabel.numberOfLines = 0;
    //self.textLabel.preferredMaxLayoutWidth = appWidth-16;
    self.commentLabel.attributedText = text;
  //  self.textLabel.font = [UIFont systemFontOfSize:15];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
