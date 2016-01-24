//
//  UIImage+Util.m
//  awaji
//
//  Created by Genki Ishibashi on 2016/01/24.
//  Copyright © 2016年 Keisuke Tatsumi. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage(Util)

- (NSData *)convertToBase64 {
    return [[NSData alloc] initWithData:UIImageJPEGRepresentation(self, 1.0f)];
}

@end
