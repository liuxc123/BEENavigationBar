//
//  BEEBackBarButtonItem.h
//  BEENavigationBar
//
//  Created by mac on 2021/8/19.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BEEBackItem;

NS_SWIFT_NAME(BackBarButtonItem)
@interface BEEBackBarButtonItem : UIBarButtonItem

@property (nonatomic, copy) BOOL (^shouldBack)(BEEBackBarButtonItem *item);
@property (nonatomic, copy) void (^willBack)(void);
@property (nonatomic, copy) void (^goBack)(void);
@property (nonatomic, copy) void (^didBack)(void);
@property (nonatomic, weak) UINavigationController *navigationController;

+ (instancetype)initWithBackItem:(BEEBackItem *)backItem;

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIBarButtonItemStyle)style
                    tintColor:(nullable UIColor *)tintColor;

- (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                    tintColor:(nullable UIColor *)tintColor;

- (instancetype)initWithButton:(UIButton *)button
                     tintColor:(nullable UIColor *)tintColor;

- (instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action NS_UNAVAILABLE;
- (instancetype)initWithImage:(nullable UIImage *)image landscapeImagePhone:(nullable UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action NS_UNAVAILABLE;
- (instancetype)initWithTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action NS_UNAVAILABLE;
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action NS_UNAVAILABLE;
- (instancetype)initWithCustomView:(UIView *)customView NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
