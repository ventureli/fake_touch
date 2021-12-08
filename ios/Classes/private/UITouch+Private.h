//
//  UITouch+My.h
//  testSendTap
//
//  Created by fatboyli on 2021/3/5.
//

#import <UIKit/UIKit.h>
#import "IOHIDEvent+KIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITouch (Private)
- (void)setWindow:(UIWindow *)window;
- (void)setView:(UIView *)view;
- (void)setTapCount:(NSUInteger)tapcount;
- (void)setPhase:(UITouchPhase)phase;
- (void)_setLocationInWindow:( CGPoint)point resetPrevious:(BOOL)previous;
- (instancetype)initWithLocation:(CGPoint)point window:(UIWindow *)window;
- (void)setTimestamp:(NSTimeInterval)time;
- (void)_setHidEvent:(IOHIDEventRef)event;

- (void)setLocation:(CGPoint)point;
- (void)udpateTimestamp;
@end

NS_ASSUME_NONNULL_END
//
