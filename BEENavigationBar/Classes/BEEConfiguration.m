//
//  BEEConfiguration.m
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEEConfiguration.h"

@implementation BEEConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isEnabled = NO;
        self.isHidden = NO;
        self.alpha = 1.0f;
        self.isShadowHidden = NO;
        self.isTranslucent = YES;
        self.barStyle = UIBarStyleDefault;
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.additionalHeight = 0.0f;
        self.background = [[BEEBackground alloc] initWithImage:nil barPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.layoutPaddings = UIEdgeInsetsMake(0, 16, 0, 16);
        self.prefersLargeTitles = NO;
    }
    return self;
}

@end

@implementation BEEBackground

- (instancetype)initWithImage:(UIImage *)image
                  barPosition:(UIBarPosition)barPosition
                   barMetrics:(UIBarMetrics)barMetrics
{
    self = [super init];
    if (self) {
        self.image = image;
        self.barPosition = barPosition;
        self.barMetrics = barMetrics;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    BEEBackground *background = [[BEEBackground alloc] init];
    background.image = self.image;
    background.barPosition = self.barPosition;
    background.barMetrics = self.barMetrics;
    return background;
}

@end

@implementation BEELargeTitle

- (instancetype)initWithTitleAttributes:(NSDictionary<NSAttributedStringKey, id> *)textAttributes
                            displayMode:(UINavigationItemLargeTitleDisplayMode)displayMode;
{
    self = [super init];
    if (self) {
        self.textAttributes = textAttributes;
        self.displayMode = displayMode;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    BEELargeTitle *largeTitle = [[BEELargeTitle alloc] init];
    largeTitle.textAttributes = self.textAttributes;
    largeTitle.displayMode = self.displayMode;
    return largeTitle;
}

@end

@implementation BEEBackItem

- (instancetype)initWithTitle:(NSString *)title tintColor:(UIColor *)tintColor
{
    self = [super init];
    if (self) {
        self.title = title;
        self.tintColor = tintColor;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image tintColor:(UIColor *)tintColor
{
    self = [super init];
    if (self) {
        self.image = image;
        self.tintColor = tintColor;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    BEEBackItem *backItem = [[BEEBackItem alloc] init];
    backItem.title = self.title;
    backItem.image = self.image;
    backItem.tintColor = self.tintColor;
    return backItem;
}

@end


@implementation BEEShadow

+ (instancetype)none {
    return [[self alloc] initWithColor:nil opacity:0 offset:CGSizeMake(0, -3) radius:3 path:nil];
}

- (instancetype)initWithColor:(CGColorRef)color
                      opacity:(CGFloat)opacity
                       offset:(CGSize)offset
                       radius:(CGFloat)radius
                         path:(CGPathRef)path {
    self = [super init];
    if (self) {
        self.color = color;
        self.opacity = opacity;
        self.offset = offset;
        self.radius = radius;
        self.path = path;

    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    BEEShadow *shadow = [[BEEShadow alloc] init];
    shadow.color = self.color;
    shadow.opacity = self.opacity;
    shadow.offset = self.offset;
    shadow.radius = self.radius;
    shadow.path = self.path;
    return shadow;
}

@end
