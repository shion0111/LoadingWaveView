//
//  Loadingwave.m
//  Loadingwave
//
//  Created by Antelis on 24/08/2017.
//  Copyright © 2017 shion. All rights reserved.
//

#import "LoadingwaveView.h"
#import <QuartzCore/QuartzCore.h>


typedef CGFloat (^waveFunctionBlock)(CGFloat,CGFloat,CGFloat);

@interface WaveLayer : CAShapeLayer<CAAnimationDelegate>
@property(nonatomic) CGFloat wduration;
@property(strong,nonatomic) CADisplayLink *displaylink;
@property(nonatomic) CFTimeInterval elapsedTime;
@property(nonatomic) CFTimeInterval lastTick;
@property(nonatomic) waveFunctionBlock functionBlock;
@end

@implementation WaveLayer
- (instancetype)initWithWaveDuration:(CGFloat)wduration withWaveFunctionBlock:(waveFunctionBlock) block
{
    if ((self = [self init])) {
        self.wduration =  wduration;
        _elapsedTime = 0.0f;
        _lastTick = 0.0f;
        self.functionBlock = block;
        self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveUpdate)];
        [self.displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [self stopRunloop];
    }
    return self;
}
- (void) waveUpdate {
    

    if (_lastTick != 0.0f)
        _elapsedTime += _displaylink.timestamp - _lastTick;
    _lastTick = _displaylink.timestamp;
    
    UIBezierPath *p = [[UIBezierPath alloc] init];
    CGFloat ef = 0,ef2=_elapsedTime/_wduration;
    CGFloat x= 0, y= 0;
    
    if (self.functionBlock){
        for (CGFloat i = 0.0; i < 1.0f; i+= 0.005f){
            ef = sinf(M_PI*i);
            x = self.frame.size.width*i;
            y = self.functionBlock(i,ef,ef2);
            
            if (i <= 0.0f)
                [p moveToPoint:CGPointMake(x,y)];
            else
                [p addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    self.path = p.CGPath;
    
}
- (void)startRunloop {
    self.displaylink.paused = NO;
}
- (void)stopRunloop {
    self.displaylink.paused = YES;
}
- (void)destroyRunloop {
    if(_displaylink != nil) {
        [_displaylink invalidate];
        _displaylink = nil;
    }
    
}
@end


@interface LoadingwaveView()
//  Wave color for three waveforms
@property (nonatomic, strong) UIColor *waveColor;
//  Message showed when displaying loadingview
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *countdownLabel;
@property (nonatomic) WaveLayer *pathLayer;
@property (nonatomic) WaveLayer *pathLayer1;
@property (nonatomic) WaveLayer *pathLayer2;
// if countdown > 0, LoadingwaveView will be dismissed after [countdown] seconds.
@property (nonatomic) CGFloat countdown;
@end


@implementation LoadingwaveView

- (instancetype)initWithTitle:(NSString *)title waveColor:(UIColor *)waveColor {
    
    return [self initWithTitle:title countdown:-1 waveColor:waveColor];
}
- (instancetype)initWithTitle:(NSString *)title countdown:(CGFloat)countdown waveColor:(UIColor *)waveColor
{
    self = [super initWithFrame:CGRectMake(0, 0, 240, countdown>0?100:86)];
    _countdown = -1;
    if (self) {
        _countdown = countdown;
        
        if (waveColor)
            self.waveColor = waveColor;
        else
            self.waveColor = UIColor.blueColor;
        
        [self setupTitle:title];
        [self setupWavebase];
        
    }
    return self;
}
-(void) layoutSubviews {
    self.center = self.superview.center;
}
- (void)setupTitle:(NSString *)title {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53,55, 136, 21)];
    self.titleLabel.textColor = UIColor.grayColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    _titleLabel.text = title;
    
    if (_countdown > 0){
        self.countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(53,78, 136, 21)];
        self.countdownLabel.textColor = UIColor.lightGrayColor;
        self.countdownLabel.textAlignment = NSTextAlignmentCenter;
        self.countdownLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_countdownLabel];
    }
}
- (void)setupWavebase {
    if (_pathLayer) return;
    
    self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin   |
                             UIViewAutoresizingFlexibleRightMargin  |
                             UIViewAutoresizingFlexibleTopMargin    |
                             UIViewAutoresizingFlexibleBottomMargin);
    self.backgroundColor = UIColor.whiteColor;
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 8.5f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOpacity = 0.35f;
    self.layer.shadowOffset = CGSizeMake(3, 5);
    
    
    UIView *wavebase = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    wavebase.backgroundColor = UIColor.clearColor;
    wavebase.layer.masksToBounds = YES;
    [self addSubview:wavebase];
    
    self.pathLayer = [[WaveLayer alloc] initWithWaveDuration:2.5 withWaveFunctionBlock:^CGFloat(CGFloat i, CGFloat ef, CGFloat ef2) {
        return (15.0f*sinf(3.5*M_PI*i-ef2*M_PI)+10.0f)*ef;
    }];
    
    _pathLayer.frame = CGRectMake(0, 20, self.bounds.size.width, 30);
    _pathLayer.strokeColor = self.waveColor.CGColor;
    _pathLayer.fillColor = UIColor.clearColor.CGColor;
    _pathLayer.lineWidth = 1.0f;
    [wavebase.layer addSublayer:_pathLayer];
    
    self.pathLayer1 = [[WaveLayer alloc] initWithWaveDuration:1.5 withWaveFunctionBlock:^CGFloat(CGFloat i, CGFloat ef, CGFloat ef2) {
        
        return (17.0f*sinf(5.5*M_PI*i-ef2*M_PI)+11.0f)*ef;
        
    }];
    _pathLayer1.frame = CGRectMake(0, 18, self.bounds.size.width, 30);
    _pathLayer1.strokeColor = self.waveColor.CGColor;
    _pathLayer1.fillColor = UIColor.clearColor.CGColor;
    _pathLayer1.lineWidth = 0.75f;
    _pathLayer1.opacity = 0.5f;
    [wavebase.layer addSublayer:_pathLayer1];
    
    self.pathLayer2 = [[WaveLayer alloc] initWithWaveDuration:0.75f withWaveFunctionBlock:^CGFloat(CGFloat i, CGFloat ef, CGFloat ef2) {
        return (13.0f*sinf(7.5*M_PI*i-ef2*M_PI)+9.0f)*ef;
    }];
    
    _pathLayer2.frame = CGRectMake(0, 15, self.bounds.size.width, 30);
    
    _pathLayer2.strokeColor = self.waveColor.CGColor;
    _pathLayer2.fillColor = UIColor.clearColor.CGColor;
    _pathLayer2.lineWidth = 0.75f;
    _pathLayer2.opacity = 0.25f;
    
    [wavebase.layer addSublayer:_pathLayer2];
    
    self.alpha = 0.0f;
}
- (void)pause {
    [_pathLayer stopRunloop];
    [_pathLayer1 stopRunloop];
    [_pathLayer2 stopRunloop];
}
- (void)start {
    [_pathLayer startRunloop];
    [_pathLayer1 startRunloop];
    [_pathLayer2 startRunloop];
    
    if (_countdown > 0){
        self.countdownLabel.text = [NSString stringWithFormat:@"%d", (int)_countdown];
        __weak LoadingwaveView *weakSelf = self;
        [NSTimer scheduledTimerWithTimeInterval:_countdown repeats:NO block:^(NSTimer * _Nonnull timer) {
            LoadingwaveView *strongSelf = weakSelf;
            [strongSelf dismiss];
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            LoadingwaveView *strongSelf = weakSelf;
            int i = [strongSelf.countdownLabel.text intValue];
            if (i > 0)
                strongSelf.countdownLabel.text = [NSString stringWithFormat:@"%d", i-1];
        }];
        
        
    }
}
- (void)stop {
    _countdown = -1;
    [_pathLayer destroyRunloop];
    [_pathLayer1 destroyRunloop];
    [_pathLayer2 destroyRunloop];
    
    [_pathLayer removeFromSuperlayer];
    _pathLayer = nil;
    [_pathLayer1 removeFromSuperlayer];
    _pathLayer1 = nil;
    [_pathLayer2 removeFromSuperlayer];
    _pathLayer2 = nil;
}
- (void)dealloc{
    [self stop];
}
- (void)dismiss{
    
    __weak LoadingwaveView *weakSelf = self;
    [UIView animateWithDuration:1.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         LoadingwaveView *strongSelf = weakSelf;
                         strongSelf.alpha = 0.0f;
                         
                     } completion:^(BOOL finished) {
                         LoadingwaveView *strongSelf = weakSelf;
                         [strongSelf stop];
                         [strongSelf removeFromSuperview];
                         
                     }];
    
}
- (void)didMoveToSuperview{
    
    __weak LoadingwaveView *weakSelf = self;
    [UIView animateWithDuration:1.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         LoadingwaveView *strongSelf = weakSelf;
                         strongSelf.alpha = 1.0f;
                         [strongSelf start];
                     } completion:^(BOOL finished) {
                         
                     }];
}
@end
