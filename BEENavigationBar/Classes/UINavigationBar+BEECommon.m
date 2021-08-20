//
//  UINavigationBar+BEECommon.m
//  BEENavigationBar
//
//  Created by mac on 2021/8/20.
//

#import "UINavigationBar+BEECommon.h"

@implementation UINavigationBar (BEECommon)

- (void)setTitleAlpha:(CGFloat)alpha {
    UIColor *color = self.titleTextAttributes[NSForegroundColorAttributeName] ?: [self defaultTitleColor];
    [self setTitleColor:[color colorWithAlphaComponent:alpha]];
}

- (void)setLargeTitleAlpha:(CGFloat)alpha {
    UIColor *color = self.largeTitleTextAttributes[NSForegroundColorAttributeName] ?: [self defaultTitleColor];
    [self setLargeTitleColor:[color colorWithAlphaComponent:alpha]];
}

- (void)setTintAlpha:(CGFloat)alpha {
    self.tintColor = [self.tintColor colorWithAlphaComponent:alpha];
}

- (UIColor *)defaultTitleColor {
    return self.barStyle == UIBarStyleDefault ? UIColor.blackColor : UIColor.whiteColor;
}

- (void)setTitleColor:(UIColor *)color {
    if (self.titleTextAttributes) {
        NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [self.titleTextAttributes mutableCopy];
        titleTextAttributes[NSForegroundColorAttributeName] = color;
        self.titleTextAttributes = titleTextAttributes;
    } else {
        self.titleTextAttributes = @{NSForegroundColorAttributeName: color};
    }
}

- (void)setLargeTitleColor:(UIColor *)color API_AVAILABLE(ios(11.0)) {
    if (self.largeTitleTextAttributes) {
        NSMutableDictionary<NSAttributedStringKey, id> *largeTitleTextAttributes = [self.largeTitleTextAttributes mutableCopy];
        largeTitleTextAttributes[NSForegroundColorAttributeName] = color;
        self.largeTitleTextAttributes = largeTitleTextAttributes;
    } else {
        self.largeTitleTextAttributes = @{NSForegroundColorAttributeName: color};
    }
}

@end
