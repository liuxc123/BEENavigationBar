//
//  UIViewController+BEENavigationBar.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UIViewController+BEENavigationBar.h"
#import "UINavigationController+BEENavigationBar.h"
#import "UITableViewController+BEENavigationBar.h"
#import "BEENavigationBar+Internal.h"
#import "BEEBackBarButtonItem.h"
#import "BEENavigationItem.h"
#import "BEESwizzle.h"
#import <objc/runtime.h>

@implementation UIViewController (BEENavigationBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BEESwizzleMethod([self class],
                         @selector(viewDidLoad),
                         [self class],
                         @selector(navigation_viewDidLoad));
        
        BEESwizzleMethod([self class],
                         @selector(viewWillAppear:),
                         [self class],
                         @selector(navigation_viewWillAppear:));
        
        BEESwizzleMethod([self class],
                         @selector(setNeedsStatusBarAppearanceUpdate),
                         [self class],
                         @selector(navigation_setNeedsStatusBarAppearanceUpdate));
        
        BEESwizzleMethod([self class],
                         @selector(viewDidLayoutSubviews),
                         [self class],
                         @selector(navigation_viewDidLayoutSubviews));
    });
}

#pragma mark - Swizzle Methods

- (BOOL)isNavigationBarEnabled {
    if (!self.navigationController) {
        return NO;
    }
    if (!self.navigationController.navigation_configuration.isEnabled) {
        return NO;
    }
    return YES;
}

- (void)navigation_viewDidLoad {
    [self navigation_viewDidLoad];
    
    if (![self isNavigationBarEnabled]) {
        return;
    }
    
    [self setupNavigationBarWhenViewDidLoad];
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        [(UITableViewController *)self observeContentOffset];
    }
}

- (void)navigation_viewDidAppear:(BOOL)animated {
    [self navigation_viewDidAppear:animated];
    
    if (![self isNavigationBarEnabled]) {
        return;
    }
    
    [self updateNavigationBarWhenViewWillAppear];
}

- (void)navigation_viewWillAppear:(BOOL)animated {
    [self navigation_viewWillAppear:animated];
    
    if (![self isNavigationBarEnabled]) {
        return;
    }
    
    [self updateNavigationBarWhenViewWillAppear];
}

- (void)navigation_setNeedsStatusBarAppearanceUpdate {
    [self navigation_setNeedsStatusBarAppearanceUpdate];
    
    [self adjustsNavigationBarLayout];
}

- (void)navigation_viewDidLayoutSubviews {
    [self navigation_viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.navigation_bar];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)setupNavigationBarWhenViewDidLoad {
    if (!self.navigationController) { return; }
    
    [self.navigationController sendNavigationBarToBack];
    [self.view addSubview:self.navigation_bar];
    
    if (@available(iOS 11.0, *)) {
        self.navigation_item.largeTitleDisplayMode = self.navigationController.navigation_configuration.largeTitle.displayMode;
    }
    
    [self.navigation_bar applyWithConfiguration:self.navigationController.navigation_configuration];
    
    if (self.navigationController.viewControllers.count <= 1) { return; }
    
    BEEBackItem *backItem = self.navigationController.navigation_configuration.backItem;
    if (!backItem) {
        self.navigation_bar.backBarButtonItem = [self buildBackBarButtonItem:self.navigationController.viewControllers];
        return;
    }
    self.navigation_bar.backBarButtonItem = [BEEBackBarButtonItem initWithBackItem:backItem];
}

- (void)updateNavigationBarWhenViewWillAppear {
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (!navigationBar) { return; }
    
    navigationBar.barStyle = self.navigation_bar.superBarStyle;
    [navigationBar setHidden:self.navigation_bar.isHidden];
    if (@available(iOS 11.0, *)) {
        [self adjustsSafeAreaInsetsAfterIOS11];
        self.navigationItem.title = self.navigation_item.title;
        self.navigationItem.largeTitleDisplayMode = self.navigation_item.largeTitleDisplayMode;
        navigationBar.prefersLargeTitles = self.navigation_bar.prefersLargeTitles;
        navigationBar.largeTitleTextAttributes = self.navigation_bar.largeTitleTextAttributes;
    }
    [self.view bringSubviewToFront:self.navigation_bar];
}

- (void)adjustsSafeAreaInsetsAfterIOS11 {
    if (@available(iOS 11.0, *)) {
        CGFloat height = self.navigation_bar.additionalView.frame.size.height;
        UIEdgeInsets additionalSafeAreaInsets = self.additionalSafeAreaInsets;
        additionalSafeAreaInsets.top = self.navigation_bar.isHidden ? -self.view.safeAreaInsets.top : self.navigation_bar.additionalHeight + height;
        self.additionalSafeAreaInsets = additionalSafeAreaInsets;
    }
}

- (void)adjustsNavigationBarLayout {
    [self.navigation_bar adjustsLayout];
    [self.navigation_bar setNeedsLayout];
}

- (BEEBackBarButtonItem *)buildBackBarButtonItem:(NSArray<UIViewController *> *)viewControllers {
    NSInteger count = viewControllers.count;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    NSBundle *currentBundle = [NSBundle bundleForClass:[BEENavigationBar class]];
    UIImage *backImage = [UIImage imageNamed:@"navigation_back_default" inBundle:currentBundle compatibleWithTraitCollection:nil];
    [backButton setImage:backImage forState:UIControlStateNormal];
    
    NSString *title = viewControllers[count - 2].navigation_item.title;
    if (title) {
        CGFloat maxWidth = MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) / 3;
        CGFloat width = [title boundingRectWithSize:CGSizeMake(maxWidth, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} context:nil].size.width;
        [backButton setTitle:width < maxWidth ? title : @"Back" forState:UIControlStateNormal];
    } else {
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
    }
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 8);
    [backButton sizeToFit];
    
    return [[BEEBackBarButtonItem alloc] initWithButton:backButton tintColor: nil];
}


#pragma mark - getters and setters

- (void)setNavigation_bar:(BEENavigationBar *)navigation_bar {
    objc_setAssociatedObject(self, @selector(navigation_bar), navigation_bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BEENavigationBar *)navigation_bar {
    BEENavigationBar *_navigation_bar = objc_getAssociatedObject(self, @selector(navigation_bar));
    if (!_navigation_bar) {
        _navigation_bar = [[BEENavigationBar alloc] initWithController:self];
        objc_setAssociatedObject(self, @selector(navigation_bar), _navigation_bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _navigation_bar;
}

- (void)setNavigation_item:(UINavigationItem *)navigation_item {
    objc_setAssociatedObject(self, @selector(navigation_item), navigation_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationItem *)navigation_item {
    UINavigationItem *_navigation_item = objc_getAssociatedObject(self, @selector(navigation_item));
    if (!_navigation_item) {
        _navigation_item = [[BEENavigationItem alloc] initWithController:self];
        _navigation_item.title = self.navigationItem.title;
        _navigation_item.prompt = self.navigationItem.prompt;
        objc_setAssociatedObject(self, @selector(navigation_item), _navigation_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _navigation_item;
}

@end
