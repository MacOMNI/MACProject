//
//  ContactsVC.h
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/14.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;


- (IBAction)openClassAction:(id)sender;
- (IBAction)qrScanAction:(id)sender;

@end
