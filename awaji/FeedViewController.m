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
#import "UINavigationBar+Awesome.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *feedTableView;
@property (nonatomic, strong) NSMutableArray *cafeDataArray;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _cafeDataArray = [[NSMutableArray alloc]init];
    
    CafeObject *cafeObject = [[CafeObject alloc]init];
    cafeObject.name = @"スターバックスコーヒー 安土桃山駅前店@がんばらない";
    cafeObject.username = @"TestUserテストんああああああ";
    cafeObject.place = @"滋賀・サターン";
    cafeObject.likeCount = @1000;
    cafeObject.createDate = [NSDate date];
    
    [_cafeDataArray addObject:cafeObject];
    [_cafeDataArray addObject:cafeObject];
    [_cafeDataArray addObject:cafeObject];
    [_cafeDataArray addObject:cafeObject];
    
    [self configNavigationBar];
    [self configBackgroundImageView];
    [self configTableView];
    
//    [self saveCafeInfo];
//    [self saveCafeInfo];
//    [self saveCafeInfo];
//    [self saveCafeInfo];
    [self findWithOffset:20];
//    [self plusLike];
//    [self remove];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _feedTableView.delegate = self;
    [self scrollViewDidScroll:_feedTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _feedTableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self updateFrame];
}

- (void)configNavigationBar {
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)configBackgroundImageView {
    
    _backgroundImageView = [[UIImageView alloc]init];
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.image = [UIImage imageNamed:kImageFeedBackground];
    [self.view addSubview:_backgroundImageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.bounds;
    visualEffectView.alpha = 0.94;
    [self.view addSubview:visualEffectView];
}

- (void)configTableView {
    
    _feedTableView = [[UITableView alloc]init];
    _feedTableView.backgroundColor = [UIColor clearColor];
    _feedTableView.dataSource = self;
    _feedTableView.delegate = self;
    [_feedTableView registerClass:[CafeInfoCell class] forCellReuseIdentifier:cafeInfoCellIdetifier];
    _feedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _feedTableView.showsVerticalScrollIndicator = NO;
    _feedTableView.contentInset = UIEdgeInsetsMake(kNavigationBarHeight, 0, 0, 0);
    [self.view addSubview:_feedTableView];
}

- (void)updateFrame {
    
    _backgroundImageView.frame = self.view.bounds;
    _feedTableView.frame = self.view.bounds;
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
    
    if (_cafeDataArray.count > 0) {
        CafeObject *cafeObject = (CafeObject *)_cafeDataArray[indexPath.row];
        [cell setCellData:cafeObject withParentWidth:_feedTableView.width];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _feedTableView.width*2/3 + 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithCSS:kColorCodeBlack];
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(0.9, 0.9 - (- offsetY / kNavigationBarHeight));
    
    if (alpha<0) {
        alpha = 0;
    }
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
}

#pragma mark - ReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Dealloc

- (void)dealloc {
}

@end
