//
//  Loadingwave.h
//  Loadingwave
//
//  Created by Antelis on 24/08/2017.
//  Copyright © 2017 shion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingwaveView : UIView
- (instancetype)initWithTitle:(NSString *)title countdown:(CGFloat)countdown waveColor:(UIColor *)waveColor;
- (instancetype)initWithTitle:(NSString *)title waveColor:(UIColor *)waveColor;
- (void)pause;
- (void)start;
- (void)dismiss;
@end
