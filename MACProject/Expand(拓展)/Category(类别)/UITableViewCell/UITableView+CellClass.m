//
//  MACBaseCell.h
//  MACProject
//
//  Created by MacKun on 15/12/18.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UITableView+CellClass.h"
#import "CellDataAdapter.h"
#import "MACBaseCell.h"

@implementation UITableView (CellClass)

- (void)registerCellsClass:(NSArray <CellClassType *> *)cellClasses {

    for (int i = 0; i < cellClasses.count; i++) {
        CellClassType *cellClass = cellClasses[i];
        [self registerClass:NSClassFromString(cellClass.classString) forCellReuseIdentifier:cellClass.reuseIdentifier];
    }
}

- (MACBaseCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath {

    MACBaseCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    
    return cell;
}

- (MACBaseCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller {

    MACBaseCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.controller  = controller;
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    
    return cell;
}

@end

@implementation CellClassType

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString reuseIdentifier:(NSString *)reuseIdentifier {
    
    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = reuseIdentifier;
    
    return type;
}

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString {

    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = classString;
    
    return type;
}

@end