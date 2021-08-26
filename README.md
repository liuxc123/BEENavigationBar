# BEENavigationBar

## 示例

要运行示例项目，首先克隆 repo 并在 Example 目录运行   `pod install`。

## 版本要求

* iOS 9.0

## 安装

BEENavigationBar 可通过 CocoaPods 或者 Carthage 安装, 简单的添加下面一行到你的 Podfile:

### Podfile

```
pod 'BEENavigationBar'
```

## 用法

### 导入

```
#import <BEENavigationBar/BEENavigationBarHeader.h>
```

### 开启

给当前导航栈的 viewControllers 添加一个独立的导航栏。

只对当前导航栈有效，不影响其他导航栈。

```
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];

nav.navigation_configuration.isEnabled = YES;

```

### 设置

#### 导航栈全局配置

```
nav.navigation_configuration.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blueColor};

nav.navigation_configuration.barTintColor = UIColor.yellowColor;

nav.navigation_configuration.shadowImage = [UIImage imageNamed:@"shadow"];

nav.navigation_configuration.background = [[BEEBackground alloc] initWithImage:[UIImage imageNamed:@"back"] barPosition:UIBarPositionAny barMetrics: UIBarMetricsDefault];

nav.navigation_configuration.backItem = [[BEEBackItem alloc] initWithImage:[UIImage imageNamed:@"back"] tintColor:UIColor.blackColor];

nav.navigation_configuration.prefersLargeTitles = YES;

nav.navigation_configuration.largeTitle.displayMode = UINavigationItemLargeTitleDisplayModeNever;
```

### 每个控制器设置

#### 普通设置

```
// 一般用法同系统组件
navigation_bar  -> EachNavigationBar -> UINavigationBar
navigation_item -> UINavigationItem

// 隐藏导航栏
self.navigation_bar.isHidden = YES;

// 设置导航栏透明度
self.navigation_bar.alpha = 0.5;

// 设置标题透明度
[self.navigation_bar setTitleAlpha:0.5];

// 设置 barButtonItem 透明度
[self.navigation_bar setTintAlpha:0.5];
// 如果 barButtonItem 是自定义视图
self.navigation_item.leftBarButtonItem.customView.alpha = 0.5;
// 如果 barButtonItem 自定义了 tintColor
self.navigation_item.leftBarButtonItem.tintColor = [self.navigation_item.leftBarButtonItem.tintColor colorWithAlphaComponent:0.5];

// 移除毛玻璃效果
[self.navigation_bar setTranslucent:NO];

// 隐藏底部阴影
self.navigation_bar.isShadowHidden = YES;

// 设置状态栏样式
self.navigation_bar.statusBarStyle = UIStatusBarStyleDefault;

// 设置返回按钮
self.navigation_bar.backBarButtonItem = [[BEEBackBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain tintColor:nil];

// 允许返回事件
    self.navigation_bar.backBarButtonItem.shouldBack = ^BOOL(BEEBackBarButtonItem * _Nonnull item) {
        // do something
        return NO;
    };

// 返回事件之前回调
self.navigation_bar.backBarButtonItem.willBack = ^{
    // do something
};

// 返回事件之后回调
self.navigation_bar.backBarButtonItem.didBack = ^{
    // do something
};

// 如果想自定义导航栏位置，请将下面属性设为 false
self.navigation_bar.automaticallyAdjustsPosition = NO;

// 导航栏附加高度
self.navigation_bar.additionalHeight = 14;

// 导航栏附加视图
self.navigation_bar.additionalView = [UIView new];

// 导航栏阴影
self.navigation_bar.shadow = [[BEEShadow alloc] initWithColor:UIColor.blackColor.CGColor opacity:0.5 offset:CGSizeMake(0, 3) radius:0 path:nil];

```

#### 大标题设置(iOS 11.0+)

···
// 开启大标题
self.navigation_bar.prefersLargeTitles = NO;

// 显示模式
self.navigation_item.largeTitle.displayMode = UINavigationItemLargeTitleDisplayModeAlways;

// 设置大标题透明度
[self.navigation_bar setLargeTitleAlpha:0.5];
···

#### 关于约束

```
和使用系统导航栏完全一致。
```

- 请注意 iOS 11 以上和以下的区别。
- 

## 作者

liuxc123, lxc_work@126.com

## License

BEENavigationBar 可在 MIT 许可证下使用。有关更多信息，请参阅许可证文件。
