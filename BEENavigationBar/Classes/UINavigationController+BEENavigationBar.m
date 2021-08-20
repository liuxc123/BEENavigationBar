//
//  UINavigationController+BEENavigationBar.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UINavigationController+BEENavigationBar.h"
#import "UIViewController+BEENavigationBar.h"
#import "BEENavigationBar.h"
#import "BEENavigationBar+Internal.h"
#import <objc/runtime.h>

@implementation UINavigationController (BEENavigationBar)

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (!self.navigation_configuration.isEnabled) {
        return;
    }
    
    [self sendNavigationBarToBack];
    
    BEENavigationBar *bar = self.topViewController.navigation_bar;
    if (!bar) { return; }
    
    [self setNavigationBarHidden:NO];
    [self.navigationBar setHidden:bar.isHidden];
 
    [bar adjustsLayout];
    
    [self.topViewController adjustsSafeAreaInsetsAfterIOS11];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        if (!self.navigation_configuration.isEnabled) {
            return;
        }
        [self.topViewController.navigation_bar adjustsLayout];
    }
}

- (void)sendNavigationBarToBack {
    self.navigationBar.tintColor = UIColor.clearColor;
    if (!self.navigationBar.shadowImage) {
        UIImage *image = [UIImage new];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = image;
        self.navigationBar.backIndicatorImage = image;
        self.navigationBar.backIndicatorTransitionMaskImage = image;
    }
    [self.view sendSubviewToBack:self.navigationBar];
}

#pragma mark - getters and setters

- (void)setNavigation_configuration:(BEEConfiguration *)navigation_configuration {
    objc_setAssociatedObject(self, @selector(navigation_configuration), navigation_configuration, OBJC_ASSOCIATION_RETAIN);
}

- (BEEConfiguration *)navigation_configuration {
    BEEConfiguration *_configuration = objc_getAssociatedObject(self, @selector(navigation_configuration));
    if (!_configuration) {
        _configuration = [[BEEConfiguration alloc] init];
        objc_setAssociatedObject(self, @selector(navigation_configuration), _configuration, OBJC_ASSOCIATION_RETAIN);
    }
    return _configuration;
}

@end
