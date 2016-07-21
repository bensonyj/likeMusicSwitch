//
//  UIButton+Extension.h
//  likeMusicSwitch
//
//  Created by yingjian on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIButton (Extension)

@property (nonatomic, strong) IBInspectable UIColor *normalColor;

@property (nonatomic, strong) IBInspectable UIColor *hightedColor;

@property (nonatomic, strong) IBInspectable UIColor *disableColor;

@end
