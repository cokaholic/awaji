//
//  CafeDao.m
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "CafeDao.h"

@implementation CafeDao
NSString *kObjectIdKey = @"objectId";
NSString *kNameKey = @"name";
NSString *kPlaceKey = @"place";
NSString *kCommentKey = @"comment";
NSString *kImageKey = @"image";
NSString *kUserNameKey = @"username";
NSString *kLikeCountKey = @"likeCount";
NSString *kCreatedDateKey = @"createdAt";

+ (void)save:(CafeObject *)cafe block:(BooleanResultBlock)block {
    PFObject *object = [PFObject objectWithClassName:NSStringFromClass([CafeObjectDto class])];
    object[kNameKey] = CHECK_NULL_STRING(cafe.name);
    object[kPlaceKey] = CHECK_NULL_STRING(cafe.place);
    object[kCommentKey] = CHECK_NULL_STRING(cafe.comment);
    if (NOT_NULL(cafe.image)){
        NSData *data = UIImageJPEGRepresentation(cafe.image, 1.0f);
        object[kImageKey] = [PFFile fileWithData:data];
    }
    object[kUserNameKey] = CHECK_NULL_STRING(cafe.username);
    object[kLikeCountKey] = CHECK_NULL_NUMBER(cafe.likeCount);
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        block(succeeded, error);
    }];
}

+ (void)incrementLikeCount:(NSString *)objectId block:(BooleanResultBlock)block {
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([CafeObjectDto class])];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *cafeInfo, NSError *error){
        [cafeInfo incrementKey:kLikeCountKey];
        [cafeInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            block(succeeded, error);
        }];
    }];
}

+ (void)remove:(NSString *)objectId block:(BooleanResultBlock)block{
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([CafeObjectDto class])];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *cafeInfo, NSError *error){
        [cafeInfo deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            block(succeeded, error);
        }];
    }];
}

+ (void)find:(QueryArrayResultsBlock)block {
    PFQuery *query = [PFQuery queryWithClassName:NSStringFromClass([CafeObjectDto class])];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *infoList = [NSMutableArray array];
        for (PFObject *object in objects) {
            UIImage *image = [UIImage imageWithData:[object[kImageKey] getData]];
            CafeObject *c = [[CafeObject alloc] init];
            c.objectId = object.objectId;
            c.name = object[kNameKey];
            c.place = object[kPlaceKey];
            c.comment = object[kCommentKey];
            c.image = image;
            c.username = object[kUserNameKey];
            c.likeCount = object[kLikeCountKey];
            [infoList addObject:c];
        }
        block(infoList, error);
    }];
}
@end