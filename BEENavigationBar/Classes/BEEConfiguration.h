//
//  BEEConfiguration.h
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BEEBackground;
@class BEELargeTitle;
@class BEEBackItem;
@class BEEShadow;

NS_SWIFT_NAME(Configuration)
@interface BEEConfiguration : NSObject

@property (nonatomic, assign) BOOL isEnabled;

@property (nonatomic, assign) BOOL isHidden;

@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, retain) UIColor *barTintColor;

@property (nonatomic, retain) UIColor *tintColor;

@property (nonatomic, retain) UIImage *shadowImage;

@property (nonatomic, assign) BOOL isShadowHidden;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;

@property (nonatomic, assign) BOOL isTranslucent;

@property (nonatomic, assign) UIBarStyle barStyle;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, assign) CGFloat additionalHeight;

@property (nonatomic, assign) UIEdgeInsets layoutPaddings;

@property (nonatomic, assign) BOOL prefersLargeTitles;

@property (nonatomic, copy) BEEBackground *background;

@property (nonatomic, copy) BEELargeTitle *largeTitle;

@property (nonatomic, copy) BEEShadow *shadow;

@property (nonatomic, copy) BEEBackItem *backItem;

@end

NS_SWIFT_NAME(Background)
@interface BEEBackground: NSObject <NSCopying>

@property (nonatomic, retain, nullable) UIImage *image;

@property (nonatomic, assign) UIBarPosition barPosition;

@property (nonatomic, assign) UIBarMetrics barMetrics;

- (instancetype)initWithImage:(nullable UIImage *)image
                  barPosition:(UIBarPosition)barPosition
                   barMetrics:(UIBarMetrics)barMetrics;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_SWIFT_NAME(LargeTitle)
@interface BEELargeTitle: NSObject <NSCopying>

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *textAttributes;

@property (nonatomic, assign) UINavigationItemLargeTitleDisplayMode displayMode;

- (instancetype)initWithTitleAttributes:(NSDictionary<NSAttributedStringKey, id> *)textAttributes
                  displayMode:(UINavigationItemLargeTitleDisplayMode)displayMode;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_SWIFT_NAME(BackItem)
@interface BEEBackItem: NSObject <NSCopying>

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) UIImage *image;
@property (nonatomic, copy, nullable) UIColor *tintColor;

- (instancetype)initWithTitle:(NSString *)title tintColor:(nullable UIColor *)tintColor;
- (instancetype)initWithImage:(UIImage *)image tintColor:(nullable UIColor *)tintColor;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_SWIFT_NAME(Shadow)
@interface BEEShadow: NSObject <NSCopying>

@property (nonatomic, assign) CGColorRef color;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, assign) CGSize offset;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGPathRef path;

+ (instancetype)none;

- (instancetype)initWithColor:(nullable CGColorRef)color
                      opacity:(CGFloat)opacity
                       offset:(CGSize)offset
                       radius:(CGFloat)radius
                         path:(nullable CGPathRef)path;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
