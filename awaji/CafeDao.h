//
//  CafeDao.h
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CafeObject.h"

@interface CafeDao : NSObject


typedef void (^BooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^QueryArrayResultsBlock)(NSArray *data, NSError *error);
+ (void)save:(CafeObject *)cafe block:(BooleanResultBlock)block;
+ (void)incrementLikeCount:(NSString *)objectId block:(BooleanResultBlock)block;
+ (void)remove:(NSString *)objectId block:(BooleanResultBlock)block;
+ (void)findWithOffset:(NSInteger)offset count:(NSInteger)count block:(QueryArrayResultsBlock)block;

@end
