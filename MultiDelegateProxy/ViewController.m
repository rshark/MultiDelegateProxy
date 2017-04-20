//
//  ViewController.m
//  MultiDelegateProxy
//
//  Created by 冯波 on 2017/4/20.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "ViewController.h"
#import "ImitatedAppStoreSlideBehavior.h"
#import "MultiDelegateProxy.h"

static const NSInteger   kTitleLabelTag = 1000;

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController {
    ImitatedAppStoreSlideBehavior *_imitatedSlideBehavior;
    MultiDelegateProxy  *_delegateProxy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat itemsPerRow = 4;
    CGFloat itemSpacing = 10;
    CGFloat itemWidth = (self.view.bounds.size.width - itemSpacing * itemsPerRow) / itemsPerRow;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowlayout.minimumInteritemSpacing = itemSpacing;
    flowlayout.sectionInset = UIEdgeInsetsMake(0, itemSpacing / 2.0, 0, itemSpacing / 2.0);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    UICollectionView  *slideView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100) collectionViewLayout:flowlayout];
    slideView.showsHorizontalScrollIndicator = NO;
    slideView.decelerationRate = UIScrollViewDecelerationRateFast;
    slideView.backgroundColor = [UIColor whiteColor];
    [slideView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    slideView.dataSource = self;
    
    _imitatedSlideBehavior = [[ImitatedAppStoreSlideBehavior alloc] init];
    _imitatedSlideBehavior.stepUnit = flowlayout.itemSize.width + flowlayout.minimumInteritemSpacing;
    _delegateProxy = [[MultiDelegateProxy alloc] initWithMultiDelegates:_imitatedSlideBehavior,self,nil];
    slideView.delegate = (id<UICollectionViewDelegate>)_delegateProxy;
    
    [self.view addSubview:slideView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];

    UILabel *titleLabel = [cell viewWithTag:kTitleLabelTag];
    if (titleLabel == nil) {
        UICollectionViewFlowLayout *flowlayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, flowlayout.itemSize.width, flowlayout.itemSize.height)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font =  [UIFont boldSystemFontOfSize:22];
        titleLabel.layer.borderWidth = 1.0;
        titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        titleLabel.tag = kTitleLabelTag;
        [cell addSubview:titleLabel];
    }
    
    titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"vc delegate call back");
}


@end
