//
//  SDNearbyCollectionView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/16.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNearbyCollectionView.h"
#import "SDNearbyCollectionViewCell.h"
#define nearbyCell @"nearbyCell"

@interface SDNearbyCollectionView()
<UICollectionViewDelegate,
UICollectionViewDataSource>
@end

@implementation SDNearbyCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self setBackgroundColor:[UIColor clearColor]];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = NO;
        //注册
        [self registerClass:[SDNearbyCollectionViewCell class] forCellWithReuseIdentifier:nearbyCell];
        
    }
    return self;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2,SCREEN_WIDTH/2/187*298);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDNearbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nearbyCell forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.collectionDelegate respondsToSelector:@selector(SDNearbyCollectionView:didSelectItemAtIndexPath:)])
    {
        [self.collectionDelegate SDNearbyCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}


@end