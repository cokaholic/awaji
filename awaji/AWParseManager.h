//
//  AWParseManager.h
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWParseManager : NSObject

+ (PFObject *)makePFObject:(NSString *)className;
+ (PFQuery *)makePFQuery:(NSString *)className;

@end
