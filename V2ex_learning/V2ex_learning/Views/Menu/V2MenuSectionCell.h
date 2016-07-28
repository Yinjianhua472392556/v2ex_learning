//
//  V2MenuSectionCell.h
//  V2ex_learning
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V2MenuSectionCell : UITableViewCell

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *badge;

+ (CGFloat)getCellHeight;

@end
