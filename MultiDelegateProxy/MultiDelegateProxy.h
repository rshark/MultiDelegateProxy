//
//  MultiDelegateProxy.h
//  iListen
//
//  Created by Owen on 2017/4/19.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiDelegateProxy : NSObject

- (instancetype)initWithMultiDelegates:(id)firstObject,...;

@end
