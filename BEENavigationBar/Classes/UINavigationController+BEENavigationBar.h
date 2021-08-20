//
//  UINavigationController+BEENavigationBar.h
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEEConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (BEENavigationBar)

@property (nonatomic, retain) BEEConfiguration *navigation_configuration;

- (void)sendNavigationBarToBack;

@end

NS_ASSUME_NONNULL_END
