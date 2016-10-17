//
//  IllegalHeaderView.m
//
//

#import "UIImageLabelHeaderView.h"

@interface UIImageLabelHeaderView (){
    @private
    UIImageView *_imageView;
    UILabel *_textLabel;
    UILabel *_line;
}

@end

@implementation UIImageLabelHeaderView

- (id)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:CGRectMake(0, 0, frame.size.width, 54.0f)];
    if (self) {
        
        self.backgroundColor  = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(92.5f, 15.0f, 25.0f, 25.0f)];
        _imageView.image = [UIImage imageNamed:@"wz_year"];
        [self addSubview:_imageView];
        
        _textLabel  = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right+5.0f, 15.0f, 100.0f, 25.0f)];
        _textLabel.textColor  = [UIColor appTextColor];
        _textLabel.font  = [UIFont systemFontOfSize:13.0f];
        [self addSubview:_textLabel];
        
        UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(70.0f, _imageView.bottom, 1.0f, 14.0f)];
        _imageView.centerX = line.centerX;
        _textLabel.left = _imageView.right +5.0f;
        line.backgroundColor  = [UIColor appLineColor];
        [self addSubview:line];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    _textLabel.text = text;
}

@end
