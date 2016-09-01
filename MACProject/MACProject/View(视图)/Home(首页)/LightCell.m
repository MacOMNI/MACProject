

#import "LightCell.h"

@implementation LightCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2.0-17.5, 5.0f, 35.0f, 35.0f)];
        self.imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.bottom+5.0f, self.width, 20.0f)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor appTitleColor];
        self.textLabel.font = [UIFont systemFontOfSize:14.0f];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.textLabel];
    }
    return self;
}


@end
