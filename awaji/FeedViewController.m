//
//  FeedViewController.m
//  awaji
//
//  Created by Keisuke_Tatsumi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *feedTableView;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)createTableView {
    
    _feedTableView = [[UITableView alloc]initWithFrame:APPFRAME_RECT];
    [self.view addSubview:_feedTableView];
}

@end
