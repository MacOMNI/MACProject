//
//  CommentCell.m
//  MACProject
//
//  Created by MacKun on 16/9/22.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "CommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "YYImage.h"
#import "NSDictionary+JKBlock.h"

@interface CommentCell(){
    
}

@end

@implementation CommentCell

-(void)setParser:(YYTextSimpleEmoticonParser *)parser{
    if (!_parser) {
        _parser = parser;
        _commentLabel.textParser  = parser;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _commentLabel = [[YYLabel alloc] init];
        [self.contentView addSubview:self.commentLabel];
       // _commentLabel.backgroundColor  = [UIColor RandomColor];
        _commentLabel.preferredMaxLayoutWidth = appWidth - 20;
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10.0f);
            make.right.equalTo(self.contentView).offset(-10.0f);
            make.bottom.equalTo(self.contentView).offset(-3.0f);
        }];

    }
    return self;
}

- (UIImage *)imageWithName:(NSString *)name {
    YYImage *image = [YYImage imageWithData:UIImagePNGRepresentation(name.macImage)];
    //YYImage *image = [YYImage imageWithCGImage:[UIImage imageNamed:name].CGImage];
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}

-(void)setModel:(CommentModel *)model{
    _model = [CommentModel mj_objectWithKeyValues: model];
    NSString *str = [NSString stringWithFormat:@"%@回复%@：%@",_model.userName,_model.toUserName,_model.contentMessage];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, _model.userName.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(_model.userName.length+2, _model.toUserName.length)];

    _commentLabel.attributedText = text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
