//
//  UIEvent+Private.h
//  testSendTap
//
//  Created by fatboyli on 2021/3/5.
//

#import <UIKit/UIKit.h>
#import "UIApplication+Private.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIEvent (Private)
- (void)_addTouch:(UITouch *)touch forDelayedDelivery:(BOOL)delayed;
+ (void)send:(NSArray<UITouch *> *)touchs;
- (void)_clearTouches;
@end

NS_ASSUME_NONNULL_END
