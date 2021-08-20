//
//  BEENavigationBar.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEENavigationBar.h"
#import "BEENavigationBar+Internal.h"
#import "UIViewController+BEENavigationBar.h"

@interface BEENavigationBar ()

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, strong) UINavigationBar *superNavigationBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isLargeTitleShown;
@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, strong) UINavigationBarAppearance *appearance API_AVAILABLE(ios(13.0));

@end

@implementation BEENavigationBar

#pragma mark - initial

- (instancetype)initWithController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsPosition = YES;
        self.additionalHeight = 0.0f;
        self.isShadowHidden = NO;
        self.statusBarStyle = UIStatusBarStyleDefault;
        
        if (@available(iOS 11.0, *)) {
            self.layoutPaddings = UIEdgeInsetsMake(0, 16, 0, 16);
        }
        
        self.shadow = [BEEShadow none];

        self.viewController = viewController;
        [self setItems: @[viewController.navigation_item]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _layoutSubviews];
}

#pragma mark - public

- (void)setAdditionalHeight:(CGFloat)additionalHeight {
    _additionalHeight = additionalHeight;
    
    CGRect frame = self.frame;
    frame.size.height = self.barHeight + _additionalHeight;
    self.frame = frame;
    [self.viewController adjustsSafeAreaInsetsAfterIOS11];
}

- (void)setIsShadowHidden:(BOOL)isShadowHidden {
    _isShadowHidden = isShadowHidden;
    
    UIView *background = self.subviews.firstObject;
    background.clipsToBounds = _isShadowHidden;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    self.superNavigationBar.barStyle = self.superBarStyle;
}

- (void)setAdditionalView:(UIView *)additionalView {
    [_additionalView removeFromSuperview];
    _additionalView = additionalView;
    [self setupAdditionalView:_additionalView];
}

- (void)setShadow:(BEEShadow *)shadow {
    _shadow = shadow;
    
    self.layer.shadowColor = shadow.color;
    self.layer.shadowOpacity = shadow.opacity;
    self.layer.shadowOffset = shadow.offset;
    self.layer.shadowRadius = shadow.radius;
    self.layer.shadowPath = shadow.path;
}

- (void)setBackBarButtonItem:(BEEBackBarButtonItem *)backBarButtonItem {
    _backBarButtonItem = backBarButtonItem;
    
    _backBarButtonItem.navigationController = self.viewController.navigationController;
    self.viewController.navigation_item.leftBarButtonItem = _backBarButtonItem;
}

#pragma mark - override

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    [self.viewController adjustsSafeAreaInsetsAfterIOS11];
}

- (void)setTranslucent:(BOOL)translucent {
    [super setTranslucent:translucent];
    
    if (@available(iOS 13.0, *)) {
        if (translucent) { return; }
        self.appearance.backgroundEffect = nil;
        [self updateAppearance:self.appearance];
    }
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];

    self.layer.shadowOpacity = alpha < 1 ? 0 : self.shadow.opacity;
    
    UIView *background = self.subviews.firstObject;
    background.alpha = alpha;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    [super setBarTintColor:barTintColor];
    
    if (@available(iOS 13.0, *)) {
        self.appearance.backgroundColor = barTintColor;
        [self updateAppearance:self.appearance];
    }
}

/// map to barTintColor
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.barTintColor = backgroundColor;
}

- (void)setShadowImage:(UIImage *)shadowImage {
    [super setShadowImage:shadowImage];
    
    if (@available(iOS 13.0, *)) {
        self.appearance.shadowImage = shadowImage;
        [self updateAppearance:self.appearance];
    }
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes {
    [super setTitleTextAttributes:titleTextAttributes];
    
    if (@available(iOS 13.0, *)) {
        self.appearance.titleTextAttributes = titleTextAttributes;
        [self updateAppearance:self.appearance];
    }
}

- (void)setPrefersLargeTitles:(BOOL)prefersLargeTitles {
    [super setPrefersLargeTitles:prefersLargeTitles];
    
    self.superNavigationBar.prefersLargeTitles = prefersLargeTitles;
    
    if (@available(iOS 13.0, *)) {
        [self updateAppearance:self.appearance];
    }
}

- (void)setLargeTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)largeTitleTextAttributes {
    [super setLargeTitleTextAttributes:largeTitleTextAttributes];
    
    self.viewController.navigationItem.title = self.viewController.navigation_item.title;
    self.superNavigationBar.largeTitleTextAttributes = largeTitleTextAttributes;
 
    if (@available(iOS 13.0, *)) {
        self.appearance.largeTitleTextAttributes = largeTitleTextAttributes;
        [self updateAppearance:self.appearance];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if ([super pointInside:point withEvent:event]) {
        return YES;
    }
    return CGRectContainsPoint(self.additionalView.frame, point);
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
    
    if (@available(iOS 13.0, *)) {
        self.appearance.backgroundImage = backgroundImage;
        [self updateAppearance:self.appearance];
    }
}

#pragma mark - internal

- (void)applyWithConfiguration:(BEEConfiguration *)configuration {
    
    self.alpha = configuration.alpha;
    self.tintColor = configuration.tintColor;

    [self setHidden:configuration.isHidden];
    [self setTranslucent:configuration.isTranslucent];
    [self setBarTintColor:configuration.barTintColor];
    
    self.titleTextAttributes = configuration.titleTextAttributes;
    self.shadowImage = configuration.shadowImage;
    [self setBackgroundImage:configuration.background.image
              forBarPosition:configuration.background.barPosition
                  barMetrics:configuration.background.barMetrics];

    self.barStyle = configuration.barStyle;
    self.statusBarStyle = configuration.statusBarStyle;
    
    self.additionalHeight = configuration.additionalHeight;
    self.isShadowHidden = configuration.isShadowHidden;
    
    BEEShadow *shadow = configuration.shadow;
    if (shadow) { self.shadow = shadow; }
    
    if (@available(iOS 11.0, *)) {
        self.layoutPaddings = configuration.layoutPaddings;
        self.prefersLargeTitles = configuration.prefersLargeTitles;
        self.largeTitleTextAttributes = configuration.largeTitle.textAttributes;
    }

}

- (CGFloat)statusBarMaxY {
    if (@available(iOS 13, *)) {
        return CGRectGetMaxY([UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame);
    }
    return CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame]);
}

- (CGFloat)navigationBarHeight {
    return 44.f;
}

- (UIBarStyle)superBarStyle {
    return self.statusBarStyle == UIStatusBarStyleLightContent ? UIBarStyleBlack : UIBarStyleDefault;
}

- (CGFloat)barMinY {
    if (self.superNavigationBar) {
        return CGRectGetMinY(self.superNavigationBar.frame);
    }
    return [self statusBarMaxY];
}

- (void)adjustsLayout {
    UINavigationBar *navigationBar = self.superNavigationBar;
    if (!navigationBar) { return; }
    
    CGRect frame = self.frame;
    
    if (self.automaticallyAdjustsPosition) {
        frame = navigationBar.frame;
        frame.origin.y = self.barMinY;
    } else {
        frame.size = navigationBar.frame.size;
    }
    
    frame.size.height = navigationBar.frame.size.height + self.additionalHeight;
    self.frame = frame;
}


#pragma mark private

- (UINavigationBar *)superNavigationBar {
    return self.viewController.navigationController.navigationBar;
}

- (UIView *)contentView {
    if (!_contentView) {
        for (UIView *view in self.subviews) {
            if ([NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarContentView"]) {
                _contentView = view;
                break;
            }
        }
    }
    return _contentView;
}

- (BOOL)isLargeTitleShown {
    if (@available(iOS 11.0, *)) {
        return self.prefersLargeTitles && self.viewController.navigation_item.largeTitleDisplayMode != UINavigationItemLargeTitleDisplayModeNever;
    } else {
        return NO;
    }
}

- (CGFloat)barHeight {
    if (self.superNavigationBar) {
        return self.superNavigationBar.frame.size.height;
    }
    return [self navigationBarHeight];
}

- (void)_layoutSubviews {
    UIView *background = [self.subviews firstObject];
    if (!background) {
        return;
    }
    background.alpha = self.alpha;
    background.clipsToBounds = self.isShadowHidden;
    background.frame = CGRectMake(0,
                                  -self.barMinY,
                                  self.bounds.size.width,
                                  self.bounds.size.height + self.barMinY);
    
    [self adjustsLayoutMarginsAfterIOS11];
}

- (void)adjustsLayoutMarginsAfterIOS11 {
    if (@available(iOS 11.0, *)) {
        
        self.layoutMargins = UIEdgeInsetsMake(8, 16, 8, 16);
        
        if (!self.contentView) { return; }
        
        if (@available(iOS 13.0, *)) {
            self.contentView.frame = CGRectMake(self.layoutPaddings.left - self.layoutMargins.left,
                                                self.isLargeTitleShown ? 0 : self.additionalHeight,
                                                self.layoutMargins.left
                                                + self.layoutMargins.right
                                                - self.layoutPaddings.left
                                                - self.layoutPaddings.right
                                                + self.contentView.frame.size.width,
                                                self.contentView.frame.size.height);
        } else {
            CGRect frame = self.contentView.frame;
            frame.origin.y = self.isLargeTitleShown ? 0 : self.additionalHeight;
            self.contentView.frame = frame;
            self.contentView.layoutMargins = self.layoutPaddings;
        }
    }
}

- (void)setupAdditionalView:(UIView *)additionalView {
    [self addSubview:additionalView];
    additionalView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [additionalView.topAnchor constraintEqualToAnchor:self.bottomAnchor],
        [additionalView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [additionalView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [additionalView.heightAnchor constraintEqualToConstant:additionalView.frame.size.height]
    ]];
}

- (UINavigationBarAppearance *)appearance {
    if (!_appearance) {
        _appearance = [[UINavigationBarAppearance alloc] init];
        _appearance.backgroundColor = self.barTintColor;
        _appearance.titleTextAttributes = self.titleTextAttributes ?: @{};
        _appearance.largeTitleTextAttributes = self.largeTitleTextAttributes ?: @{};
    }
    return _appearance;
}

- (void)updateAppearance:(UINavigationBarAppearance *)appearance API_AVAILABLE(ios(13.0)) {
    self.standardAppearance = appearance;
    self.compactAppearance = appearance;
    self.scrollEdgeAppearance = appearance;
}

@end
