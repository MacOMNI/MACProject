//
//  UITextFieldView.m
//
//
//  Created by MacKun on 15/7/15.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//

#import "UITextFieldView.h"

@interface UITextFieldView (){
    @private
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

@end

@implementation UITextFieldView

- (id)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        self.textField  = [[UITextField alloc] initWithFrame:CGRectZero];
        self.textField.font  = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.textField];
        
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font  = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor  = [UIColor appNavigationBarColor];
        _titleLabel.textAlignment =NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title{
    _title  = title;
    _titleLabel.text  = title;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor appTextColor]}];
    self.textField.tintColor = [UIColor appTextColor];
    
    if (_image) {
        _titleLabel.hidden = YES;
        _imageView.hidden = NO;
        
        [_imageView setFrame:CGRectMake(8, 8, self.height-16, self.height-16)];
        [self.textField setFrame:CGRectMake(_imageView.right+8, 0, self.width-_imageView.width, self.height)];
    }else if (_title){
        _titleLabel.hidden = NO;
        _imageView.hidden = YES;
        
        [_titleLabel sizeToFit];
        _titleLabel.centerY = self.height/2.0f;
        _titleLabel.width +=10.0f;
        [self.textField setFrame:CGRectMake(_titleLabel.right, 0, self.width-_titleLabel.width, self.height)];
        
    }else{
        
        _titleLabel.hidden = YES;
        _imageView.hidden = YES;
        [self.textField setFrame:CGRectMake(10.0f, 0, self.width-20.0f, self.height)];
    }
    
    

}

@end
