//
//  UIApplication+Private.h
//  testSendTap
//
//  Created by fatboyli on 2021/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Private)
- (UIEvent *)_touchesEvent;
@end

NS_ASSUME_NONNULL_END
