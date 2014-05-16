//
//  GridCollectionViewCustomLayout.h
//  DemandPlanning
//
//  Created by Rahul Wakade on 13/05/13.
//  Copyright (c) 2013 Triple Point Technology, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridCollectionViewDelegateCustomLayout <UICollectionViewDelegate>

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GridCollectionViewCustomLayout : UICollectionViewLayout
{
    NSMutableArray *layoutAttributes;
}
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end
