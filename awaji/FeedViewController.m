//
//  FeedViewController.m
//  awaji
//
//  Created by Keisuke_Tatsumi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "FeedViewController.h"
#import "CafeInfoCell.h"
#import "CafeObject.h"
#import <Parse/Parse.h>

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *feedTableView;
@property (nonatomic, strong) NSMutableArray *cafeDataArray;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cafeDataArray = [[NSMutableArray alloc]init];
    
    [self createTableView];
    
//    CafeObject *cafeObject = [[CafeObject alloc] init];
//    cafeObject.name = @"カフェTK";
//
//    PFObject *testObject = [PFObject objectWithClassName:NSStringFromClass(CafeObject.class)];
//    testObject[@"foo"] = [[CafeObject alloc] init];
//    [testObject saveInBackground];
}

- (void)createTableView {
    
    _feedTableView = [[UITableView alloc]initWithFrame:APPFRAME_RECT];
    _feedTableView.backgroundColor = BACKGROUND_COLOR;
    _feedTableView.dataSource = self;
    _feedTableView.delegate = self;
    [_feedTableView registerClass:[CafeInfoCell class] forCellReuseIdentifier:cafeInfoCellIdetifier];
    [self.view addSubview:_feedTableView];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cafeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CafeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cafeInfoCellIdetifier
                                                         forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[CafeInfoCell alloc]initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cafeInfoCellIdetifier];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Dealloc

- (void)dealloc {
}

@end
