//
//  UIPaopaoView.m
//

#import "UIPaopaoView.h"

@interface UIPaopaoView (){
    @private
    UIImageView *_paopaoImageView;
    UILabel *_textLabel;
}

@end

@implementation UIPaopaoView

- (id)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        
        _paopaoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_paopaoImageView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.textColor  = [UIColor appTitleColor];
        _textLabel.font  = [UIFont systemFontOfSize:14.0f];
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    _textLabel.text = text;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_paopaoImageView setFrame: CGRectMake(0, 0, self.width, self.height)];
    [_paopaoImageView setImage:[[UIImage imageNamed:@"xx_qipao"] stretchableImageWithLeftCapWidth:20.0f topCapHeight:17.0f]];
    
    [_textLabel setFrame:CGRectMake(20.0f, 5.0f, self.width-20.0f, self.height - 10.0f)];
}

@end
