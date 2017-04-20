//
//  MultiDelegateProxy.h
//  iListen
//
//  Created by 冯波 on 2017/4/19.
//  Copyright © 2017年 idaddy.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiDelegateProxy : NSObject

- (instancetype)initWithMultiDelegates:(id)firstObject,...;

@end
