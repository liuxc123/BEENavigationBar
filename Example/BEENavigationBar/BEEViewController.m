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

@property (nonatomic, assign) BOOL isStatusBarHidden;
@property (weak, nonatomic) IBOutlet UISlider *setLargeTitleAlphaSlider;

@end

@implementation BEEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation_item.title = @"BEENavigationBar";
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithTitle:@"Collection" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];

    UIBarButtonItem *tableItem = [[UIBarButtonItem alloc] initWithTitle:@"Table" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction2)];
    self.navigation_item.rightBarButtonItems = @[collectionItem, tableItem];
    
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonAction)];
    self.navigation_item.leftBarButtonItem = nextItem;
    
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.prefersLargeTitles = NO;
    }
}

#pragma mark - event response

- (void)rightBarButtonAction {
    UIViewController *vc = [[BEECollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarButtonAction2 {
    UIViewController *vc = [[BEETableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)nextButtonAction {
    [self.navigationController pushViewController:[BEEHomeViewController new] animated:YES];
}

- (IBAction)isHiddenAction:(UISwitch *)sender {
    [self.navigation_bar setHidden:sender.isOn];
}

- (IBAction)setAlphaAction:(UISlider *)sender {
    self.navigation_bar.alpha = sender.value;
}

- (IBAction)setTitleAlphaAction:(UISlider *)sender {
    [self.navigation_bar setTitleAlpha:sender.value];
}

- (IBAction)isShadowHiddenAction:(UISwitch *)sender {
    self.navigation_bar.isShadowHidden = sender.isOn;
}

- (IBAction)extraHeightAction:(UISlider *)sender {
    self.navigation_bar.additionalHeight = sender.value * 100;
}

- (IBAction)prefersLargetTitleAction:(UISwitch *)sender {
    if (@available(iOS 11.0, *)) {
        self.navigation_bar.prefersLargeTitles = sender.isOn;
        self.navigation_item.largeTitleDisplayMode = sender.isOn ? UINavigationItemLargeTitleDisplayModeAlways : UINavigationItemLargeTitleDisplayModeNever;
        [self.setLargeTitleAlphaSlider setEnabled:sender.isOn];
    }
}

- (IBAction)setLargeTitleAlphaAction:(UISlider *)sender {
    if (@available(iOS 11.0, *)) {
        [self.navigation_bar setLargeTitleAlpha:sender.value];
    }
}

- (IBAction)changeStatusBarStyle:(UISwitch *)sender {
    self.navigation_bar.statusBarStyle = sender.isOn ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (IBAction)isStatusBarHiddenAction:(UISwitch *)sender {
    self.isStatusBarHidden = sender.isOn;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.isStatusBarHidden;
}

@end
