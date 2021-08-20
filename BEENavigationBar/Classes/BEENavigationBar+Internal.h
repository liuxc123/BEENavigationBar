//
//  BEENavigationBar+Internal.h
//  BEENavigationBar
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEENavigationBar.h"
#import "BEEConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEENavigationBar ()

@property (nonatomic, assign) UIBarStyle superBarStyle;

@property (nonatomic, assign) CGFloat barMinY;

- (void)applyWithConfiguration:(BEEConfiguration *)configuration;

- (void)updateAppearance:(UINavigationBarAppearance *)appearance API_AVAILABLE(ios(13.0));

- (void)adjustsLayout;

@end

NS_ASSUME_NONNULL_END
