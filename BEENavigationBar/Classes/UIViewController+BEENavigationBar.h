//
//  UIViewController+BEENavigationBar.h
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEENavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@class BEENavigationItem;

@interface UIViewController (BEENavigationBar)

@property (nonatomic, retain) BEENavigationBar *navigation_bar;

@property (nonatomic, retain) UINavigationItem *navigation_item;

- (void)adjustsSafeAreaInsetsAfterIOS11;

@end

NS_ASSUME_NONNULL_END
