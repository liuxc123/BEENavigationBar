//
//  UITableViewController+BEENavigationBar.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/20.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UITableViewController+BEENavigationBar.h"
#import "UIViewController+BEENavigationBar.h"
#import "BEENavigationBar+Internal.h"

@implementation UITableViewController (BEENavigationBar)

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath: @"contentOffset"];
}

- (void)observeContentOffset {
    self.navigation_bar.automaticallyAdjustsPosition = NO;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self.view bringSubviewToFront:self.navigation_bar];
        CGRect frame = self.navigation_bar.frame;
        frame.origin.y = self.tableView.contentOffset.y + self.navigation_bar.barMinY;
        self.navigation_bar.frame = frame;
    }
}

@end
