//
//  UITouch+My.m
//  testSendTap
//
//  Created by fatboyli on 2021/3/5.
//

#import "UITouch+Private.h"
#import "IOHIDEvent+KIF.h"

@implementation UITouch (Private)


- (NSString *)id{
    return [NSString stringWithFormat:@"%ld",(long)self];
//    return [NSString Stringwi](format: "%p", unsafeBitCast(self, to: Int.self))
}

// MARK: - Initialize UITouch


- (instancetype)initWithLocation:(CGPoint)point window:(UIWindow *)window{
    self =  [super init];
    UIView *view = [window hitTest:point withEvent:nil];
    [self setWindow:window];
    [self setView:view];
    [self setTapCount:1];
    [self setPhase:UITouchPhaseBegan];
    //setiStap
    //setISFristTouch
    [self _setLocationInWindow:point resetPrevious:YES];
    [self setTimestamp:NSProcessInfo.processInfo.systemUptime];
    if([self respondsToSelector:@selector(setGestureView:)])
    {
        [self performSelector:@selector(setGestureView:) withObject:view];
    }
    IOHIDEventRef event = kif_IOHIDEventWithTouches(@[self]);
    [self _setHidEvent:event];
    
    return self;
    
    
    
}

- (void)setLocation:(CGPoint)point{
    [self _setLocationInWindow:point resetPrevious:YES];
}

- (void)udpateTimestamp{
    [self setTimestamp:NSProcessInfo.processInfo.systemUptime];
}

 
@end
