//
//  UICollectionViewController+BEENavigationBar.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/20.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UICollectionViewController+BEENavigationBar.h"
#import "UIViewController+BEENavigationBar.h"
#import "BEENavigationBar+Internal.h"

@implementation UICollectionViewController (BEENavigationBar)

- (void)observeContentOffset {
    self.navigation_bar.automaticallyAdjustsPosition = NO;
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self.view bringSubviewToFront:self.navigation_bar];
        CGRect frame = self.navigation_bar.frame;
        frame.origin.y = self.collectionView.contentOffset.y + self.navigation_bar.barMinY;
        self.navigation_bar.frame = frame;
    }
}

@end
