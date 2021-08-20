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

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[BEEHomeViewController new] animated:YES];
}

@end
