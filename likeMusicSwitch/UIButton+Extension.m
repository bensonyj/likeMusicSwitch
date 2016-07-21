//
//  UIButton+Extension.m
//  likeMusicSwitch
//
//  Created by yingjian on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIButton+Extension.h"
#import <UIKit/UIKit.h>

@implementation UIButton (Extension)
@dynamic normalColor,hightedColor,disableColor;

- (void)setNormalColor:(UIColor *)normalColor
{
    [self setBackgroundImage:[self imageColor:normalColor] forState:UIControlStateNormal];
}

- (void)setHightedColor:(UIColor *)hightedColor
{
    [self setBackgroundImage:[self imageColor:hightedColor] forState:UIControlStateHighlighted];
}

- (void)setDisableColor:(UIColor *)disableColor
{
    [self setBackgroundImage:[self imageColor:disableColor] forState:UIControlStateDisabled];
}

- (UIImage *)imageColor:(UIColor *)color
{
    CGRect rect = self.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
