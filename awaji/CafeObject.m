//
//  CafeObject.m
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "CafeObject.h"

@implementation CafeObject

NSString *kNameKey = @"name";
NSString *kPlaceKey = @"place";
NSString *kCommentKey = @"comment";
NSString *kImageKey = @"image";
NSString *kUserNameKey = @"username";
NSString *kLikeCountKey = @"likeCount";

- (void)save {
    PFObject *object = [PFObject objectWithClassName:NSStringFromClass(self.class)];
    object[kNameKey] = CHECK_NULL_STRING(self.name);
    object[kPlaceKey] = CHECK_NULL_STRING(self.place);
    object[kCommentKey] = CHECK_NULL_STRING(self.comment);
//    object[kImageKey] = CHECK_NULL_STRING(self.image);
    object[kUserNameKey] = CHECK_NULL_STRING(self.username);
    object[kLikeCountKey] = CHECK_NULL_NUMBER(self.likeCount);
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (error) {
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                       message:nil
                                      delegate:self
                             cancelButtonTitle:nil
                             otherButtonTitles:@"OK", nil];
            [alertView show];
            return;
        }
        if (succeeded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"save"
                                                                    object:nil];
            });
        }else {
            NSLog(@"保存に失敗しました");
        }
    }];
}

@end
