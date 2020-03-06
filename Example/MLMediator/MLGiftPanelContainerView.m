//
//  MLGiftPanelContainerView.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/3.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLGiftPanelContainerView.h"
#import "MLGift.h"
#import "MLGiftCell.h"

@interface MLGiftPanelContainerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MLGift *> *dataSource;

@end

@implementation MLGiftPanelContainerView


#pragma mark - 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
    
}

- (void)commonInit {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - 代理、数据源

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MLGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MLGiftCell class]) forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    MLGift *gift = [self.dataSource objectAtIndex:indexPath.row];
    cell.gift = gift;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MLGift *gift = [self.dataSource objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(giftPanelContainerView:didSelectItemWithGift:)]) {
        [self.delegate giftPanelContainerView:self didSelectItemWithGift:gift];
    }
    
}

#pragma mark - getter

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 36; i++) {
            MLGift *gift = [[MLGift alloc] init];
            gift.name = [NSString stringWithFormat:@"礼物%d", i];
            gift.price = (arc4random() % 1000);
            gift.ID = [NSString stringWithFormat:@"%d", i];
            gift.icon = @"";
            [_dataSource addObject:gift];
        }
    }
    return _dataSource;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / 4.0;
        CGFloat itemHeight = ([UIScreen mainScreen].bounds.size.height * 0.3) * 0.5;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.pagingEnabled = YES;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(MLGiftCell.class)
                                                    bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([MLGiftCell class])];
    }
    return _collectionView;
}


@end
