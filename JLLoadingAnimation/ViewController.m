//
//  ViewController.m
//  JLLoadingAnimation
//
//  Created by job on 16/9/2.
//  Copyright © 2016年 job. All rights reserved.
//

#import "ViewController.h"

#define image_width  117
#define image_height  157
#define image_edg    ([UIScreen mainScreen].bounds.size.width - image_width*2)/2
#define centerPosition  CGPointMake(self.view.center.x, self.view.center.y-90)
@interface ViewController ()
@property (strong, nonatomic) UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *subImageView0;
@property (strong, nonatomic) UIImageView *subImageView1;
@property (strong, nonatomic) UIImageView *subImageView2;
@property (strong, nonatomic) UIImageView *subImageView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _bgImageView.image = [UIImage imageNamed:@"bg.jpg"];
     [self.view addSubview:_bgImageView];
    
    _subImageView0 =  [self creatSubImageWithLayerPostion:CGPointMake(centerPosition.x -image_width/2-image_edg/2,centerPosition.y) andImage:@"0.png"];
    _subImageView2 =  [self creatSubImageWithLayerPostion:CGPointMake(centerPosition.x+image_width/2+image_edg/2,centerPosition.y) andImage:@"2.png"];
    _subImageView1 =  [self creatSubImageWithLayerPostion:CGPointMake(centerPosition.x, centerPosition.y - image_width/2-image_edg/2) andImage:@"1.png"];
    _subImageView3 =  [self creatSubImageWithLayerPostion:CGPointMake(centerPosition.x, centerPosition.y + image_width/2+image_edg/2) andImage:@"3.png"];
    [self animationByAlpha];
     [self otherLine];
    
}

-(UIImageView *)creatSubImageWithLayerPostion:(CGPoint )position andImage:(NSString *)imageName {
   UIImageView *imageView =    [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image_width, image_height)];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.layer.cornerRadius = 5;
    imageView.layer.borderColor  = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth  = 1;
    imageView.layer.masksToBounds = YES;
    imageView.layer.hidden     = YES;
    imageView.layer.position   = position;
    [self.view addSubview:imageView];
    return imageView;
}

-(void)animationByAlpha {
    NSArray *imageViewArray = @[_subImageView0,_subImageView2,_subImageView1,_subImageView3];
    for (int i = 0; i< imageViewArray.count; i++) {
        [self setAnimationByVivew:imageViewArray[i] andFlag:i];
    }
    
  
}


-(void)setAnimationByVivew:(UIImageView *)imageView andFlag:(NSInteger )index {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1];
    animation.duration = 1.5f;
    animation.delegate = self;
    [animation setValue:[NSString stringWithFormat:@"opacityAnimation%d",(int)index] forKey:@"animType"];
    animation.beginTime = CACurrentMediaTime() + index*1.5;
    [imageView.layer addAnimation:animation forKey:nil];
}




-(void)otherLine {
   
//   [self keyFrameAnimationWithView:_subImageView0 startAngle:-M_PI endAngle:-M_PI_2 andIndex:0];
//   [self keyFrameAnimationWithView:_subImageView1 startAngle:-M_PI_2 endAngle:0 andIndex:0];
//
//    [self keyFrameAnimationWithView:_subImageView2 startAngle:0 endAngle:M_PI_2 andIndex:0];
//    [self keyFrameAnimationWithView:_subImageView3 startAngle:M_PI_2 endAngle:M_PI andIndex:0];
    [self keyFrameAnimationWithView:_subImageView0 startAngle:-M_PI endAngle:M_PI andIndex:0];
    [self keyFrameAnimationWithView:_subImageView1 startAngle:-M_PI_2 endAngle:M_PI*3/2 andIndex:0];
    
    [self keyFrameAnimationWithView:_subImageView2 startAngle:0 endAngle:M_PI*2 andIndex:0];
    [self keyFrameAnimationWithView:_subImageView3 startAngle:M_PI_2 endAngle:M_PI*2+M_PI_2 andIndex:0];
}

-(void)keyFrameAnimationWithView:(UIImageView *)imageView startAngle:(CGFloat)startAngle endAngle:(CGFloat) endAngle andIndex:(int)index {
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    CGPoint center = centerPosition;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:image_width/2+image_edg/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    keyFrame.path =path.CGPath;
    keyFrame.repeatCount = HUGE_VAL;
    keyFrame.duration =4;
    keyFrame.beginTime = CACurrentMediaTime()+ 6;
    //添加到layer上
    [imageView.layer addAnimation:keyFrame forKey:nil];
}










-(void)animationDidStart:(CAAnimation *)anim {
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
//        CABasicAnimation *basiceAnimation = (CABasicAnimation *)anim;
//        [basiceAnimation setValue:basiceAnimation.toValue forKey:@"opacityAniamtion"];
        
    }
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation0"]) {
        
        _subImageView0.layer.hidden = NO;
        
    }
    
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation1"]) {
        
        _subImageView2.layer.hidden = NO;
        
    }
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation2"]) {
        
        _subImageView1.layer.hidden = NO;
        
    }
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation3"]) {
        
        _subImageView3.layer.hidden = NO;
        
    }
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

  
    
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation0"]) {
        
        _subImageView0.layer.opacity = 1;
        
    }
    
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation1"]) {
        
        _subImageView2.layer.opacity = 1;
        
    }
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation2"]) {
        
        _subImageView1.layer.opacity = 1;
        
    }
    if([[anim valueForKey:@"animType"] isEqualToString:@"opacityAnimation3"]) {
        
        _subImageView3.layer.opacity = 1;
        
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
