//
//  GridCollectionViewCustomLayout.m
//  DemandPlanning
//
//  Created by Rahul Wakade on 13/05/13.
//  Copyright (c) 2013 Triple Point Technology, Inc. All rights reserved.
//

#import "GridCollectionViewCustomLayout.h"

@implementation GridCollectionViewCustomLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    //create layout attributes for all items
    layoutAttributes = [[NSMutableArray alloc] initWithCapacity:[self.collectionView numberOfItemsInSection:0]];
    CGFloat offset = 0.0f;
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (NSUInteger i = 0; i < numberOfItems; i++)
    {
        CGSize itemSize = [self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
        UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        if (_scrollDirection == UICollectionViewScrollDirectionHorizontal)
        {
            if(offset > 0 && numberOfItems > 1)
                offset += _minimumInteritemSpacing;
            
            [layoutAttribute setFrame:CGRectMake(offset, 0, itemSize.width, itemSize.height)];
            offset += itemSize.width;
        }
        else
        {
            if(offset > 0 && numberOfItems > 1)
                offset += _minimumInteritemSpacing;

            [layoutAttribute setFrame:CGRectMake(0, offset, itemSize.width, itemSize.height)];
            offset += itemSize.height;
        }

        [layoutAttribute setSize:itemSize];
        [layoutAttribute setIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [layoutAttributes insertObject:layoutAttribute atIndex:i];
    }
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < layoutAttributes.count)
        return [layoutAttributes objectAtIndex:indexPath.row];

    return nil;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [[NSMutableArray alloc] init];
    [layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop){
                    if (CGRectIntersectsRect(rect, attributes.frame)) {
                        [allAttributes addObject:attributes];
                    }
    }];
    
    return allAttributes;
}

-(CGSize)collectionViewContentSize
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGFloat itemSpacing = (numberOfItems > 1)?_minimumInteritemSpacing:0.0f;
    CGFloat contentSizeOfItems = 0.0f;
    
    if (_scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        for (int i = 0; i < numberOfItems; i++)
        {
            CGSize itemSize = [self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            contentSizeOfItems += itemSize.width;
        }
        return CGSizeMake(contentSizeOfItems + (--numberOfItems * itemSpacing), _itemSize.height);
    }
    else
    {
        for (int i = 0; i < numberOfItems; i++)
        {
            CGSize itemSize = [self sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            contentSizeOfItems += itemSize.height;
        }
        return CGSizeMake(_itemSize.width, contentSizeOfItems + (--numberOfItems * itemSpacing));
    }
}

-(CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    
    if([self.collectionView.delegate conformsToProtocol:@protocol(GridCollectionViewDelegateCustomLayout)] && [self.collectionView.delegate respondsToSelector:@selector(collectionView:customLayout:sizeForItemAtIndexPath:)])
    {
        id <GridCollectionViewDelegateCustomLayout> delegate = (id)self.collectionView.delegate;
        itemSize = [delegate collectionView:self.collectionView customLayout:self sizeForItemAtIndexPath:indexPath];
    }
    else
    {
        itemSize = _itemSize;
    }
    return itemSize;
}

@end
