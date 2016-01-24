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
#import "CafeDao.h"
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
    
//    [self saveCafeInfo];
//    [self saveCafeInfo];
//    [self saveCafeInfo];
//    [self saveCafeInfo];
    [self findWithOffset:20];
//    [self plusLike];
//    [self remove];
    
}

- (void)createTableView {
    
    _feedTableView = [[UITableView alloc]initWithFrame:APPFRAME_RECT];
    _feedTableView.backgroundColor = [UIColor colorWithCSS:kColorCodeWarmGray];
    _feedTableView.dataSource = self;
    _feedTableView.delegate = self;
    [_feedTableView registerClass:[CafeInfoCell class] forCellReuseIdentifier:cafeInfoCellIdetifier];
    [self.view addSubview:_feedTableView];
}

#pragma mark - データいじるサンプル

/**
 * データの取得
 */
- (void)findWithOffset:(NSInteger)offset {
    [CafeDao findWithOffset:20 count:kCafeInfoPageCount block:^(NSArray *cafeInfoList, NSError *error){
        for (CafeObject *cafeInfo in cafeInfoList) {
            NSLog(@"name: %@", cafeInfo.createDate);
        }
    }];
}

// 保存
- (void)saveCafeInfo {
    // dto作製
    CafeObject *cafeInfo = [[CafeObject alloc] init];
    cafeInfo.name = @"カフェTK";
    cafeInfo.place = @"代々木体育館";
    cafeInfo.comment = @"つまんなくなくはない";
    cafeInfo.image = [UIImage imageNamed:@"sample_image"];
    cafeInfo.username = @"たつみん";
    
    // 保存処理
    [CafeDao save:(cafeInfo) block:^(BOOL succeeded, NSError *error){
        if (error) {
            NSLog(@"error: %@", error);
            return;
        }
        if (succeeded) {
            NSLog(@"保存に成功しました");
        }else {
            NSLog(@"保存に失敗しました");
        }
    }];
}

// イイねを増やす
- (void)plusLike {
    [CafeDao incrementLikeCount:@"JjwujEOroJ" block: ^(BOOL succeeded, NSError *error){
        if (succeeded) {
            NSLog(@"success");
        }
    }];
}

// 削除
- (void)remove {
    [CafeDao remove:@"JjwujEOroJ" block:^(BOOL succeeded, NSError *error){
        if (succeeded) {
            NSLog(@"success");
        }
    }];
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
