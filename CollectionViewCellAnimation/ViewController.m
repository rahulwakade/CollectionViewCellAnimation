//
//  ViewController.m
//  CollectionViewCellAnimation
//
//  Created by Rahul Wakade on 16/05/14.
//  Copyright (c) 2014 Rahul Wakade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGSize expandedCellSize;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    expandedCellSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    [self.collectionView setAllowsMultipleSelection:YES];
    
#warning Remove below code to keep UICollectionViewFlowLayout
////////////////////////////////////////////////////////////////////////////////
    GridCollectionViewCustomLayout *layout = [[GridCollectionViewCustomLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(self.collectionView.frame.size.width, 200)];
    [layout setMinimumInteritemSpacing:10];
    [self.collectionView setCollectionViewLayout:layout];
////////////////////////////////////////////////////////////////////////////////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Animate cell expand
    [self animateCellResize];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Animate cell collapse
    [self animateCellResize];
}

-(void)animateCellResize
{
    [self.collectionView performBatchUpdates:^{
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView setCollectionViewLayout:self.collectionView.collectionViewLayout animated:YES];
        
    }completion:^(BOOL finished){
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //Cell is expanded if it is selected
    if([[self.collectionView indexPathsForSelectedItems] containsObject:indexPath])
        return CGSizeMake(self.collectionView.frame.size.width, 400);// Return height of collectionview to expand cell to fll height
    
    return CGSizeMake(self.collectionView.frame.size.width, 200);
}

#pragma mark - GridCollectionViewDelegateCustomLayout
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //Cell is collapsed if it is selected
    if([[self.collectionView indexPathsForSelectedItems] containsObject:indexPath])
        return CGSizeMake(self.collectionView.frame.size.width, 400); // Return height of collectionview to expand cell to fll height

    
    return CGSizeMake(self.collectionView.frame.size.width, 200);
}

@end
