//
//  BEENavigationBar.h
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEBackBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@class BEEShadow;

@interface BEENavigationBar : UINavigationBar

/// automatically adjusts position when view layout
@property (nonatomic, assign) BOOL automaticallyAdjustsPosition;

/// Additional height for the navigation bar.
@property (nonatomic, assign) CGFloat additionalHeight;

/// Hides shadow image
@property (nonatomic, assign) BOOL isShadowHidden;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, strong) BEEBackBarButtonItem *backBarButtonItem;

/// Padding of navigation bar content view.
@property (nonatomic, assign) UIEdgeInsets layoutPaddings API_AVAILABLE(ios(11.0));

/// Additional view at the bottom of the navigation bar
@property (nonatomic, strong) UIView *additionalView;

@property (nonatomic, copy) BEEShadow *shadow;

- (instancetype)initWithController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
