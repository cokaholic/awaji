//
//  CafeObject.h
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface CafeObject : NSObject

@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSNumber *likeCount;
@property (nonatomic, retain) NSDate *createDate;

@end

@interface CafeObjectDto : NSObject

@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) PFFile *image;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSNumber *likeCount;
@property (nonatomic, retain) NSDate *createDate;

@end