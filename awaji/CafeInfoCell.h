//
//  CafeInfoCell.h
//  awaji
//
//  Created by Keisuke_Tatsumi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CafeObject;

static NSString *cafeInfoCellIdetifier = @"CafeInfoCell";

@interface CafeInfoCell : UITableViewCell

- (void)setCellData:(CafeObject *)cafeObject withParentWidth:(CGFloat)parentWidth;

@end
