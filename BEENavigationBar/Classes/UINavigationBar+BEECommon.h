//
//  UINavigationBar+BEECommon.h
//  BEENavigationBar
//
//  Created by mac on 2021/8/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (BEECommon)

- (void)setTitleAlpha:(CGFloat)alpha;

- (void)setLargeTitleAlpha:(CGFloat)alpha API_AVAILABLE(ios(11.0));

- (void)setTintAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
