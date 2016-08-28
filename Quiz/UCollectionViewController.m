//
//  UCollectionViewController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 27/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "UCollectionViewController.h"

static CGFloat const kLeftPadding = 10.0f;
static CGFloat const kRightPadding = 10.0f;
static CGFloat const kTopPadding = 10.0f;
static CGFloat const kBottomPadding = 10.0f;
static NSTimeInterval const kDefaultColumns = 2;

@interface UCollectionViewController ()

@end

@implementation UCollectionViewController

#pragma mark - View Controller

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.entries.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Override this method
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = .7;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = 1;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat padding = (kLeftPadding + kRightPadding) / 2;
    return CGSizeMake((CGRectGetWidth(collectionView.frame) - padding * self.columns * 2) / self.columns, (CGRectGetWidth(collectionView.frame) - padding * self.columns * 2) / self.columns);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kTopPadding, kLeftPadding, kBottomPadding, kRightPadding);
}

#pragma mark - Getters

- (NSUInteger)columns
{
    if(_columns == 0) {
        _columns = kDefaultColumns;
    }
    return _columns;
}

@end
