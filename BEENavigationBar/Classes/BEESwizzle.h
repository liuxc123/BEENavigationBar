//
//  BEESwizzle.h
//  BEENavigationBar_Example
//
//  Created by mac on 2021/8/18.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void BEESwizzleMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector);

