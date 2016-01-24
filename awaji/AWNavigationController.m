//
//  AWNavigationController.m
//  awaji
//
//  Created by Keisuke_Tatsumi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "AWNavigationController.h"

@interface AWNavigationController ()

@end

@implementation AWNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        [self configNavigationBar];
    }
    
    return self;
}

- (void)configNavigationBar {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
