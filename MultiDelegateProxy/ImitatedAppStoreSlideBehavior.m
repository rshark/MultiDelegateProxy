//
//  ImitatedAppStoreSlideBehavior.m
//  iListen
//
//  Created by 冯波 on 2017/4/19.
//  Copyright © 2017年 idaddy.cn. All rights reserved.
//

#import "ImitatedAppStoreSlideBehavior.h"


static const CGFloat  kDefaultStepUnit = 70.0f;

@implementation ImitatedAppStoreSlideBehavior

- (instancetype)init {
    self = [super init];
    if (self) {
        _stepUnit = kDefaultStepUnit;
    }
    return self;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat maxOffset = scrollView.contentSize.width - scrollView.bounds.size.width;
    CGFloat minOffset = 0;
    
    CGFloat targetX = MAX(minOffset, MIN(maxOffset, targetContentOffset->x));

    if (targetX != maxOffset && targetX != minOffset) {

        targetX = (ceilf(targetX / self.stepUnit) - targetX / self.stepUnit) > 0.5 ? self.stepUnit * floorf(targetX / self.stepUnit) : self.stepUnit * ceilf(targetX / self.stepUnit);
    }
    
    targetContentOffset->x = targetX;

}

@end
