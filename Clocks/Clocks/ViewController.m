//
//  ViewController.m
//  Clocks
//
//  Created by 朝阳 on 2017/10/18.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "ViewController.h"
// 时钟宽的一半
#define COLOCKW self.clockV.bounds.size.width * 0.5
// 时钟高的一半
#define COLOCKH self.clockV.bounds.size.height * 0.5
// 每一秒走多少度
#define everySecondAngle 6
// 每一分走多少度
#define everyMinuteAngle 6
// 每时走多少度
#define everyHourAngle 30
// 每一分钟时针走多少度
#define everMinHourAngle 0.5
// 角度转弧度
#define angle2Rad(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockV;

@property (weak, nonatomic) IBOutlet UIView *blackV;

@property (nonatomic, weak) CALayer *secLayer;

@property (nonatomic, weak) CALayer *minLayer;

@property (nonatomic, weak) CALayer *hourLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self setHour];
    //    [self setMinute];
    //    [self setSecond];
    
    // 添加时针
    self.hourLayer = [self createTimeLayer:CGRectMake(0, 0, 4, 50) color:[UIColor blackColor]];
    
    // 添加分针
    self.minLayer = [self createTimeLayer:CGRectMake(0, 0, 4, 70) color:[UIColor blackColor]];
    
    // 添加秒针
    self.secLayer = [self createTimeLayer:CGRectMake(0, 0, 2, 80) color:[UIColor redColor]];
    
    // 添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    // 因为上面的定时器方法隔一秒才会调用,所以先调用一次
    [self timeChange];
    
    self.blackV.layer.cornerRadius = self.blackV.bounds.size.width * 0.5;
    
}

- (void)timeChange
{
    // 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    // 获取当前多少秒
    NSInteger curSec = cmp.second;
    // 获取当前分
    NSInteger curMin = cmp.minute;
    // 获取当前时
    NSInteger curHour = cmp.hour;
    
    // 秒针开始旋转
    // 计算秒针的角度 = 当前秒 * 每秒转的角度
    self.secLayer.transform = [self setTimeAngle:(curSec * everySecondAngle)];
    
    // 分针开始旋转
    // 计算分针角度 = 当前分 * 每分钟转的角度
    self.minLayer.transform = [self setTimeAngle:(curMin * everyMinuteAngle)];
    
    // 时针针开始旋转
    // 计算时针的角度 = 当前时 * 每小时转的角度 + 当前分 * 每一分时针转的角度
    self.hourLayer.transform = [self setTimeAngle:(curHour * everyHourAngle + curMin * everMinHourAngle)];
    
}

/**
 设置针角度
 
 @param angle 角度
 @return CATransform3D
 */
- (CATransform3D)setTimeAngle:(CGFloat)angle
{
    return CATransform3DMakeRotation(angle2Rad(angle), 0, 0, 1);
}

/**
 创建三个针
 
 @param frame 大小
 @param backgroundColor 背景颜色
 @return CALayer
 */
- (CALayer *)createTimeLayer:(CGRect)frame color:(UIColor *)backgroundColor
{
    CALayer *timpLayer = [CALayer layer];
    timpLayer.frame = frame;
    timpLayer.backgroundColor = backgroundColor.CGColor;
    timpLayer.anchorPoint = CGPointMake(0.5, 1);
    timpLayer.position = CGPointMake(COLOCKW, COLOCKH);
    [self.clockV.layer addSublayer:timpLayer];
    
    return timpLayer;
}

/*
 - (void)setSecond
 {
 CALayer *secLayer = [CALayer layer];
 secLayer.frame = CGRectMake(0, 0, 2, 80);
 secLayer.backgroundColor = [UIColor redColor].CGColor;
 
 secLayer.anchorPoint = CGPointMake(0.5, 1);
 secLayer.position = CGPointMake(COLOCKW, COLOCKH);
 
 self.secLayer = secLayer;
 [self.clockV.layer addSublayer:secLayer];
 
 }
 
 - (void)setMinute
 {
 CALayer *minLayer = [CALayer layer];
 minLayer.frame = CGRectMake(0, 0, 4, 70);
 minLayer.backgroundColor = [UIColor blackColor].CGColor;
 
 minLayer.anchorPoint = CGPointMake(0.5, 1);
 minLayer.position = CGPointMake(COLOCKW, COLOCKH);
 
 self.minLayer = minLayer;
 [self.clockV.layer addSublayer:minLayer];
 
 }
 
 - (void)setHour
 {
 CALayer *hourLayer = [CALayer layer];
 hourLayer.frame = CGRectMake(0, 0, 4, 50);
 hourLayer.backgroundColor = [UIColor blackColor].CGColor;
 
 hourLayer.anchorPoint = CGPointMake(0.5, 1);
 hourLayer.position = CGPointMake(COLOCKW, COLOCKH);
 
 self.hourLayer = hourLayer;
 [self.clockV.layer addSublayer:hourLayer];
 
 }
 */

@end
