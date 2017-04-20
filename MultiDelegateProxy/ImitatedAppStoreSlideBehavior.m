//
//  ImitatedAppStoreSlideBehavior.m
//  iListen
//
//  Created by Owen on 2017/4/19.
//  Copyright © 2017年 Owen. All rights reserved.
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

//模拟App Store首页icon的滑动效果
//参考：http://stackoverflow.com/questions/15961099/how-to-make-a-uiscrollview-snap-to-icons-like-app-store-feature
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
