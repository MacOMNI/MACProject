//
//  MACBaseCell.h
//  MACProject
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "MACBaseCell.h"
#import "POP.h"
@interface MACBaseCell()

@property (nonatomic, strong) UIView   *line;

@end
@implementation MACBaseCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupCell];
        [self buildSubview];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
        [self buildSubview];
    }
    return self;
}

- (void)setupCell {
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
        //DLog(@"appLine");
//        self.line                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 0.5f)];
//        self.line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
//        //self.line.tag=1;
//        [self.contentView addSubview:self.line];
}

- (void)loadContent {
}

- (void)selectedEvent {
    
}

+ (CGFloat)cellHeightWithData:(id)data {
    
    return 0.f;
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.99, 0.99)];
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
    } else {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
        scaleAnimation.springBounciness    = 10.f;
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }

}


- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdapter data:(id)data
                                  indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    _dataAdapter = dataAdapter;
    _data        = data;
    _indexPath   = indexPath;
    _tableView   = tableView;
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data
                                             cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type {
    
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) : reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellWidth:cellWidth cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:0];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data {
    
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 cellType:0];
}

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated {
    
    if (_tableView && _dataAdapter) {
        
        if (animated) {
            
            _dataAdapter.cellHeight = height;
            [_tableView beginUpdates];
            [_tableView endUpdates];
            
        } else {
            
            _dataAdapter.cellHeight = height;
            [_tableView reloadData];
        }
    }
}

@end
