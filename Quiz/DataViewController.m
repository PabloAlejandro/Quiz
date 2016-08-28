//
//  DataViewController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "DataViewController.h"
#import "CollectionCell.h"
#import "NSArray+Shuffle.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DataViewController ()

@property (nonatomic, copy, readonly) NSString * question;

@end

@implementation DataViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = self.question;
    self.collectionView.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.collectionView.alpha = 1;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.collectionView.alpha = 0;
    }];
}

#pragma mark - Private

- (UICollectionViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView imagePath:(NSString *)imagePath
{
    static NSString * kMyIdentifier = @"CollectionCell";
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kMyIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8f];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = true;
    // Set image asynchronously with SDWebImage
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    return cell;
}

#pragma mark - Setters

- (void)setDataObject:(NSDictionary *)dataObject
{
    _dataObject = dataObject;
    _question = [dataObject objectForKey:@"question"];
    self.entries = [[dataObject objectForKey:@"responses"] shuffledArray];
}

#pragma mark - UITableViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellAtIndexPath:indexPath
                  collectionView:collectionView
                       imagePath:self.entries[indexPath.row]];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    if([self.delegate respondsToSelector:@selector(userDidSelectResponse:forQuestion:)]) {
        [self.delegate userDidSelectResponse:self.entries[indexPath.row] forQuestion:self.question];
    }
}

@end
