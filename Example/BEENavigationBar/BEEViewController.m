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
#import <BEENavigationBar/BEENavigationBarHeader.h>

@interface BEEViewController ()

@end

@implementation BEEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation_item.title = @"Main";
    self.navigation_item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.prefersLargeTitles = NO;
    } 
}

- (void)rightBarButtonAction {
    [self.navigationController pushViewController:[BEEHomeViewController new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[BEETableViewController new] animated:YES];
}

@end
