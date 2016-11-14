//
//  MessageCell.m
//  
//
//

#import "MessageCell.h"
#import "UIPaopaoView.h"

@interface MessageCell (){
@private
    UILabel *_dateLabel;
    UILabel *_timeLabel;
    UIPaopaoView *_paopaoView;
    
    UIView *_lineView;
    UIImageView *_redPointView;
}

@end

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor  = [UIColor appBackGroundColor];
        self.contentView.backgroundColor  = [UIColor appBackGroundColor];
        
        _paopaoView  = [[UIPaopaoView alloc] initWithFrame:CGRectZero];
        [self addSubview:_paopaoView];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.textColor = [UIColor appTextColor];
        _dateLabel.font = [UIFont systemFontOfSize:10.0f];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor appTextColor];
        _timeLabel.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:_timeLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor  = [UIColor appLineColor];
        [self.contentView addSubview:_lineView];
        
        _redPointView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _redPointView.image  = [UIImage imageNamed:@"wz_small_light"];
        [self.contentView addSubview:_redPointView];
        
    }
    return self;
}


- (void)setMessage:(id)message{
    _message = message;
    
    _paopaoView.text = @"北园高架两辆车在马路上发生小摩擦，司机开始装逼";
    _dateLabel.text = @"10-09";
    _timeLabel.text = @"2小时前";
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_paopaoView setFrame:CGRectMake(80.0f, 0, self.width-95.0f, self.height-30.0f)];
    
    [_dateLabel setFrame:CGRectMake(5.0f, 0, 60.0f, 24.0f)];
    [_timeLabel setFrame:CGRectMake(95.0f, _paopaoView.bottom, 60.0f, 30.0f)];
    
    [_lineView setFrame:CGRectMake(70.0f, 0, 1.0f, self.height)];
    [_redPointView setFrame:CGRectMake(66.5f, 8.0f, 8.0f, 8.0f)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
