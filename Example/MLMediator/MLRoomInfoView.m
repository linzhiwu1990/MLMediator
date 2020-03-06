//
//  MLRoomInfoView.m
//  MLMediator_Example
//
//  Created by 林志武 on 2019/7/5.
//  Copyright © 2019 linzhiwu. All rights reserved.
//

#import "MLRoomInfoView.h"
#import "MLUserCell.h"
#import <TWMessageBarManager/TWMessageBarManager.h>


@interface MLRoomInfoView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation MLRoomInfoView

#pragma mark - 生命周期
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.followButton.layer.masksToBounds = YES;
    self.infoView.layer.masksToBounds = YES;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(40, 40);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MLUserCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MLUserCell class])];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.infoView.layer.cornerRadius = self.infoView.frame.size.height * 0.5;
    self.followButton.layer.cornerRadius = self.followButton.frame.size.height * 0.5;

}

#pragma mark - 数据源、代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MLUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MLUserCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"别摸我，啥都没有" description:nil type:TWMessageBarMessageTypeError];

}


#pragma mark - getter

@end
