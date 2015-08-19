//
//  AppearanceExtensions.m
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

#import "AppearanceExtensions.h"

@implementation UIView (AppearanceExtensions)

+ (instancetype)appearanceWhenContainedInClass:(Class)aClass {
    return [self appearanceWhenContainedIn:aClass, nil];
}

@end
