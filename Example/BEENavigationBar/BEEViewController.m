//
//  BEEViewController.m
//  BEENavigationBar
//
//  Created by liuxc123 on 08/18/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

#import "BEEViewController.h"
#import "BEENextViewController.h"
#import "BEEHomeViewController.h"
#import "BEETableViewController.h"
#import "BEECollectionViewController.h"
#import <BEENavigationBar/BEENavigationBarHeader.h>

@interface BEEViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation BEEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation_item.title = @"Main";
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithTitle:@"Collection" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];

    UIBarButtonItem *tableItem = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction2)];
    self.navigation_item.rightBarButtonItems = @[collectionItem, tableItem];
    
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.prefersLargeTitles = NO;
    }
    
    [self.view addSubview:self.button];

   

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.button sizeToFit];
    self.button.center = self.view.center;
}

- (void)rightBarButtonAction {
    UIViewController *vc = [[BEECollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarButtonAction2 {
    UIViewController *vc = [[BEETableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buttonAction {
    [self.navigationController pushViewController:[BEEHomeViewController new] animated:YES];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"Next" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
