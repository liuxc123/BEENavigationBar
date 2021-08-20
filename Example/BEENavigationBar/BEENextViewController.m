//
//  BEENextViewController.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/19.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEENextViewController.h"
#import <BEENavigationBar/BEENavigationBarHeader.h>

@interface BEENextViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation BEENextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tipLabel];
    
    
    self.navigation_item.title = @"Next";
    self.navigation_bar.tintColor = nil;

    UITextField *titleView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 100, 30)];
    titleView.backgroundColor = UIColor.lightGrayColor;
    titleView.layer.cornerRadius = 15;
    titleView.layer.masksToBounds = YES;
    self.navigation_item.titleView = titleView;
    
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.prefersLargeTitles = NO;
    } 
    
    __weak typeof(self) weakSelf = self;
    self.navigation_bar.backBarButtonItem.shouldBack = ^BOOL(BEEBackBarButtonItem * _Nonnull item) {
        NSLog(@"shouldBack");
        __strong typeof(self) strongSelf = weakSelf;

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            item.goBack();
        }]];
        [strongSelf presentViewController:alert animated:YES completion:nil];
        return NO;
    };
    
    self.navigation_bar.backBarButtonItem.willBack = ^{
        NSLog(@"willBack");
    };
    
    self.navigation_bar.backBarButtonItem.didBack = ^{
        NSLog(@"didBack");
    };
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = 1 - (scrollView.contentOffset.y) / (scrollView.contentSize.height - self.view.bounds.size.height);
    self.navigation_bar.alpha = alpha;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        _tipLabel.center = self.view.center;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"上下滑动试试";
    }
    return _tipLabel;
}

@end
