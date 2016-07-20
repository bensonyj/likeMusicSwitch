//
//  ViewController.m
//  likeMusicSwitch
//
//  Created by 应剑 on 16/7/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInteger currentIndex;
}

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addLayer];
}

- (void)addLayer
{
    for (NSInteger i = 0, count = [self.imageArray count]; i < count; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = self.contentView.bounds;
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:self.imageArray[i]].CGImage);
        layer.contentsScale = [UIScreen mainScreen].scale;
        layer.contentsGravity = kCAGravityResizeAspect;
        [self.contentView.layer addSublayer:layer];
    }
}

- (IBAction)beforeClick:(id)sender {
    if (currentIndex == 1) {
        return;
    }
    
    //当前图层右移动旋转，上一张图层左移动旋转
//    CALayer *currentLayer = [self.contentView.layer ]
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"";
//    animation.toValue = @"";
//    animation.duration = 0.5;
    
}

- (IBAction)afterClick:(id)sender {
    if (currentIndex == [self.imageArray count]) {
        return;
    }
}

- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"1",@"2",@"3"];
    }
    
    return _imageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
