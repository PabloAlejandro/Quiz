//
//  UCollectionViewController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 27/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This class can be subclassed for custom collection view controllers
 */

@interface UCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, copy) NSArray * entries;
@property (nonatomic, assign) NSUInteger columns;

@end
