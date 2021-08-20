//
//  BEENavigationItem.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/20.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEENavigationItem.h"

@interface BEENavigationItem ()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation BEENavigationItem

- (instancetype)initWithController:(UIViewController *)viewController;
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    self.viewController.navigationItem.title = title;
}

- (void)setLargeTitleDisplayMode:(UINavigationItemLargeTitleDisplayMode)largeTitleDisplayMode {
    [super setLargeTitleDisplayMode:largeTitleDisplayMode];
    
    self.viewController.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode;
}

@end
