//
//  UIEvent+Private.m
//  testSendTap
//
//  Created by fatboyli on 2021/3/5.
//

#import "UIEvent+Private.h"
#import "UITouch+Private.h"

@implementation UIEvent (Private)

+ (void)send:(NSArray<UITouch *> *)touchs{
    UIEvent *event = [[UIApplication sharedApplication] _touchesEvent];
    [event _clearTouches];
    for(int i = 0 ;i < [touchs count];i++)
    {
        [event _addTouch:touchs[i] forDelayedDelivery:NO];
    }

    [[UIApplication sharedApplication] sendEvent:event];

    for(int i = 0 ;i < [touchs count];i++)
    {
       if(touchs[i].phase == UITouchPhaseBegan || touchs[i].phase == UITouchPhaseMoved)
       {
           [touchs[i] setPhase:UITouchPhaseStationary];
           [touchs[i] udpateTimestamp];
       }
           
    }
    
}
@end
