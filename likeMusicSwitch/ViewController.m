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

//    self.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:self.imageArray[0]].CGImage);
//    self.contentView.layer.contentsScale = [UIScreen mainScreen].scale;
//    self.contentView.layer.contentsGravity = kCAGravityResizeAspect;

    currentIndex = 1;
    [self addLayer];
}

- (void)addLayer
{
//    for (NSInteger count = [self.imageArray count], i = count - 1 ; i >= 0; i--) {
    for (NSInteger count = [self.imageArray count], i = 0 ; i < count; i++) {
        CALayer *layer = [CALayer layer];
        layer.frame = self.contentView.bounds;
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:self.imageArray[i]].CGImage);
        layer.contentsScale = [UIScreen mainScreen].scale;
        layer.contentsGravity = kCAGravityResizeAspect;
        [self.contentView.layer addSublayer:layer];
        if (i == 0) {
            layer.zPosition = 1;
        }else{
            layer.zPosition = -1;
        }
    }
}

- (void)showNext:(BOOL)isNext Layer:(CALayer *)layer forKey:(NSString *)key zPosition:(BOOL)isShow
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"zPosition";
    animation.fromValue = isShow ? @(-1) : @(1);
    animation.toValue = isShow ? @(1) : @(-1);
    animation.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = isNext ? @[@0,@0.14,@0] :@[@0,@(-0.14),@0];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    NSValue *value = isNext ? [NSValue valueWithCGPoint:CGPointMake(50, -20)] : [NSValue valueWithCGPoint:CGPointMake(-50, -20)];
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],value,[NSValue valueWithCGPoint:CGPointZero]];
    position.duration = 1.2;
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position.additive = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,rotation,position];
    group.duration = 1.2;
//    group.beginTime = CACurrentMediaTime() + 0.5;
    
    [layer addAnimation:group forKey:key];
    layer.zPosition = isShow ? 1 : -1;
}

- (IBAction)beforeClick:(id)sender {
    if (currentIndex == 1) {
        return;
    }
    
    //当前图层右移动旋转，上一张图层左移动旋转
    CALayer *currentLayer = self.contentView.layer.sublayers[currentIndex - 1];
    [self showNext:YES Layer:currentLayer forKey:@"current" zPosition:NO];
    
    CALayer *lastLayer = self.contentView.layer.sublayers[currentIndex - 2];
    [self showNext:NO Layer:lastLayer forKey:@"last" zPosition:YES];
    currentIndex -= 1;
}

- (IBAction)afterClick:(id)sender {
    if (currentIndex >= [self.imageArray count]) {
        return;
    }
    
    CALayer *currentLayer = self.contentView.layer.sublayers[currentIndex - 1];
    [self showNext:NO Layer:currentLayer forKey:@"current" zPosition:NO];
    
    CALayer *nextLayer = self.contentView.layer.sublayers[currentIndex];
    [self showNext:YES Layer:nextLayer forKey:@"next" zPosition:YES];
    currentIndex += 1;
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
