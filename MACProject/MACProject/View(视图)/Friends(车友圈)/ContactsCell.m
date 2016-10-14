//
//  ContactsCell.m
//  WeSchoolStudent
//
//  Created by MacKun on 15/10/9.
//  Copyright © 2015年 safiri. All rights reserved.
//

#import "ContactsCell.h"





@implementation ContactsCell


-(void)setContactStatus:(GroupModel*)contactStatus
{
    _contactStatus=[GroupModel mj_objectWithKeyValues: contactStatus];
    [_avctar mac_setImageWithURL:[NSURL URLWithString:_contactStatus.ZP] placeholderImage:[UIImage imageNamed:@"user_default_icon"]];
    _nameLabel.text=_contactStatus.XM;
    UITapGestureRecognizer *Gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
    _avctar.userInteractionEnabled = YES;
    [_avctar addGestureRecognizer:Gesture];
    switch ([_contactStatus.YHSF intValue]) {
        case 1:
            [_imgType setImage:[UIImage imageNamed:@"contact_studentType_icon"]];
            break;
        case 3:
            [_imgType setImage:[UIImage imageNamed:@"contact_teachType_icon"]];

            break;
        case 2:
            [_imgType setImage:[UIImage imageNamed:@"contact_parentType_icon"]];
            
            break;
        default:
            //[_imgType setImage:[UIImage imageNamed:@"studentType"]];
            
            break;
    }

}
-(void)TapAction:(UITapGestureRecognizer *)reg
{
    if (_contactDelegate && [_contactDelegate respondsToSelector:@selector(clickCellAcatvor:)]) {
        [_contactDelegate clickCellAcatvor:self];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//}
@end
