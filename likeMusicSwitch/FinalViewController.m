//
//  FinalViewController.m
//  likeMusicSwitch
//
//  Created by yingjian on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FinalViewController.h"
#import "UIButton+Extension.h"

@interface FinalViewController ()
@property (weak, nonatomic) IBOutlet UIView *beforeAfterView;
@property (weak, nonatomic) IBOutlet UIView *currentView;

@property (weak, nonatomic) IBOutlet UIButton *beforeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) NSArray *imageNameArray;

@end

@implementation FinalViewController{
    NSInteger currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewLayer];
}

- (void)setViewLayer
{
    if ([self.imageNameArray count] == 0) {
        NSLog(@"没有图片");
        return;
    }
    _currentView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[0]].CGImage;
    _currentView.layer.contentsScale = [UIScreen mainScreen].scale;
    _currentView.layer.contentsGravity = kCAGravityResize;
    _currentView.layer.zPosition = 1;

    if ([self.imageNameArray count] == 1) {
        NSLog(@"只有一张图片");
        return;
    }
    
    _beforeAfterView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[1]].CGImage;
    _beforeAfterView.layer.contentsScale = [UIScreen mainScreen].scale;
    _beforeAfterView.layer.contentsGravity = kCAGravityResize;
    _beforeAfterView.layer.zPosition = -1;
    
    _nextButton.enabled = YES;
    currentIndex = 1;
}

- (void)showAnmitionWithLayer:(CALayer *)layer toRight:(BOOL)isRight tozPosition:(BOOL)isZ forKey:(NSString *)key{
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = isZ ? @(-1) : @(1);
    zPosition.toValue = isZ ? @(1) : @(-1);
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = isRight ? @[@0,@0.14,@0] : @[@0,@-0.14,@0];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    NSValue *value = isRight ? [NSValue valueWithCGPoint:CGPointMake(50, -10)] : [NSValue valueWithCGPoint:CGPointMake(-50, -10)];
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],value,[NSValue valueWithCGPoint:CGPointZero]];
    position.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    position.duration = 1.2;
    position.additive = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[zPosition , rotation , position];
    group.duration = 1.2;
    group.beginTime = CACurrentMediaTime();
    
    [layer addAnimation:group forKey:key];
    layer.zPosition = isZ ? 1 : -1;
}

- (IBAction)beforeClick:(id)sender {
    if (currentIndex == 1) {
        return ;
    }
    
    _currentView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[currentIndex - 1]].CGImage;
    [self showAnmitionWithLayer:_currentView.layer toRight:YES tozPosition:NO forKey:@"beforeCurrentLayer"];
    
    _beforeAfterView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[currentIndex - 2]].CGImage;
    [self showAnmitionWithLayer:_beforeAfterView.layer toRight:NO tozPosition:YES forKey:@"beforeLayer"];
    
    currentIndex -= 1;
    _nextButton.enabled = YES;
    if (currentIndex == 1) {
        _beforeButton.enabled = NO;
    }
}

- (IBAction)nextClick:(id)sender {
    if (currentIndex == [self.imageNameArray count]) {
        return ;
    }
    
    _currentView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[currentIndex - 1]].CGImage;
    [self showAnmitionWithLayer:_currentView.layer toRight:NO tozPosition:NO forKey:@"nextCurrentLayer"];
    
    _beforeAfterView.layer.contents = (__bridge id)[UIImage imageNamed:_imageNameArray[currentIndex]].CGImage;
    [self showAnmitionWithLayer:_beforeAfterView.layer toRight:YES tozPosition:YES forKey:@"nextLayer"];
    
    currentIndex += 1;
    _beforeButton.enabled = YES;

    if (currentIndex == [self.imageNameArray count]) {
        _nextButton.enabled = NO;
    }
}

- (NSArray *)imageNameArray{
    if (!_imageNameArray) {
        _imageNameArray = @[@"1",@"2",@"3"];
    }
    
    return _imageNameArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
