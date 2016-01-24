//
//  CafeInfoCell.m
//  awaji
//
//  Created by Keisuke_Tatsumi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "CafeInfoCell.h"
#import "CafeObject.h"

@interface CafeInfoCell ()

@property (nonatomic, strong) UIImageView *thumbnailPlaceholderImageView;
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIImageView *gradientShadowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *favoriteIconImageView;
@property (nonatomic, strong) UIImageView *likeIconImageView;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, assign) CGFloat parentWidth;

@end

@implementation CafeInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // cell config
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        // Init Subviews
        [self configThumbnailPlaceholderImageView];
        [self configThumbnailImageView];
        [self configGradientShadowImageView];
        [self configFavoriteIconImageView];
        [self configTitleLabel];
        [self configLikeIconImageView];
        [self configLikeCountLabel];
        [self configUsernameLabel];
        [self configDateLabel];
        
        // Set Frame
        [self updateFrame];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self initializeCell];
}

- (void)configThumbnailPlaceholderImageView {
    
    _thumbnailPlaceholderImageView = [[UIImageView alloc]init];
    _thumbnailPlaceholderImageView.backgroundColor = [UIColor colorWithCSS:kColorCodeWarmGray];
    _thumbnailPlaceholderImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailPlaceholderImageView.image = [UIImage imageNamed:kImageDefaultThumbnail];
    [self addSubview:_thumbnailPlaceholderImageView];
}

- (void)configThumbnailImageView {
    
    _thumbnailImageView = [[UIImageView alloc]init];
    _thumbnailImageView.backgroundColor = [UIColor clearColor];
    _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_thumbnailImageView];
}

- (void)configGradientShadowImageView {
    
    _gradientShadowImageView = [[UIImageView alloc]init];
    _gradientShadowImageView.backgroundColor = [UIColor clearColor];
    _gradientShadowImageView.contentMode = UIViewContentModeScaleToFill;
    _gradientShadowImageView.image = [UIImage imageNamed:kImageGradientShadow];
    [self addSubview:_gradientShadowImageView];
}

- (void)configTitleLabel {
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor colorWithCSS:kColorCodeWhite];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = DEFAULT_FONT_BOLD(15);
    [self addSubview:_titleLabel];
}

- (void)configFavoriteIconImageView {
    
    _favoriteIconImageView = [[UIImageView alloc]init];
    _favoriteIconImageView.backgroundColor = [UIColor clearColor];
    _favoriteIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_favoriteIconImageView];
}

- (void)configLikeIconImageView {
    
    _likeIconImageView = [[UIImageView alloc]init];
    _likeIconImageView.backgroundColor = [UIColor clearColor];
    _likeIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    _likeIconImageView.image = [UIImage imageNamed:kImageHaertIcon];
    [self addSubview:_likeIconImageView];
}

- (void)configLikeCountLabel {
    
    _likeCountLabel = [[UILabel alloc]init];
    _likeCountLabel.textColor = [UIColor colorWithCSS:kColorCodeHeartPink];
    _likeCountLabel.numberOfLines = 1;
    _likeCountLabel.textAlignment = NSTextAlignmentLeft;
    _likeCountLabel.font = DEFAULT_FONT_BOLD(25);
    [self addSubview:_likeCountLabel];
}

- (void)configUsernameLabel {
    
    _usernameLabel = [[UILabel alloc]init];
    _usernameLabel.textColor = [UIColor colorWithCSS:kColorCodeWarmBrown];
    _usernameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _usernameLabel.numberOfLines = 1;
    _usernameLabel.textAlignment = NSTextAlignmentLeft;
    _usernameLabel.font = DEFAULT_FONT(12);
    [self addSubview:_usernameLabel];
}

- (void)configDateLabel {
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.textColor = [UIColor colorWithCSS:kColorCodeWarmBrown];
    _dateLabel.numberOfLines = 1;
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    _dateLabel.font = DEFAULT_FONT(11);
    [self addSubview:_dateLabel];
}

- (void)updateFrame {
    
    _thumbnailPlaceholderImageView.frame = CGRectMake(0, 0, _parentWidth, _parentWidth*2/3);
    _thumbnailImageView.frame = _thumbnailPlaceholderImageView.frame;
    _gradientShadowImageView.frame = CGRectMake(0, _thumbnailImageView.height/2, _thumbnailImageView.width, _thumbnailImageView.height/2);
    _titleLabel.frame = CGRectMake(kDefaultMargin, _thumbnailImageView.bottom - 60, _thumbnailImageView.width - kDefaultMargin*2, 25);
    
    _likeIconImageView.frame = CGRectMake(kDefaultMargin, _titleLabel.bottom, 30, 30);
    _likeCountLabel.frame = CGRectMake(_likeIconImageView.right + kDefaultMargin - 2, _titleLabel.bottom, _parentWidth - _likeIconImageView.right - kDefaultMargin*2, 30);
    
    _usernameLabel.frame = CGRectMake(kDefaultMargin, _thumbnailImageView.bottom + 2, _thumbnailImageView.width - kDefaultMargin*2 - 150, 20);
}

- (void)setCellData:(CafeObject *)cafeObject withParentWidth:(CGFloat)parentWidth{
    
    _parentWidth = parentWidth;
    
    _titleLabel.text = cafeObject.name;
    _usernameLabel.text = [NSString stringWithFormat:@"Posted by %@", cafeObject.username];
    _likeCountLabel.text = [cafeObject.likeCount stringValue];
    
    //TODO: サムネイル画像を設定する
    
    [self updateFrame];
}

- (void)initializeCell {
    
    _thumbnailImageView.image = nil;
    _titleLabel.text = @"";
    _likeCountLabel.text = @"";
    _usernameLabel.text = @"";
    _dateLabel.text = @"";
}

@end
