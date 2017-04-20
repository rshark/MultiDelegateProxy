//
//  MultiDelegateProxy.m
//  iListen
//
//  Created by 冯波 on 2017/4/19.
//  Copyright © 2017年 idaddy.cn. All rights reserved.
//

#import "MultiDelegateProxy.h"

@implementation MultiDelegateProxy {
    NSPointerArray  *_pointerArray;
}

- (instancetype)initWithMultiDelegates:(id)firstObject, ... {
    self = [super init];
    if (self) {
        _pointerArray = [NSPointerArray weakObjectsPointerArray];
        
        va_list params;
        va_start(params, firstObject);
        id arg;
        
        if (firstObject) {
            [_pointerArray addPointer:(__bridge void *)firstObject];
            arg = va_arg(params, id);
            while (arg) {
                [_pointerArray addPointer:(__bridge void *)arg];
                arg = va_arg(params, id);
            }
        }
        
        va_end(params);
    }
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    
    for (id delegateObject in _pointerArray) {
        if (delegateObject && [delegateObject respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegateObject];
        }
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        for (id delegateObject in _pointerArray) {
            if ((sig = [delegateObject methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    
    return sig;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    for (id delegateObject in _pointerArray) {
        if (delegateObject && [delegateObject respondsToSelector:aSelector]) {
            return YES;
        }
    }
    
    return NO;
}

@end
