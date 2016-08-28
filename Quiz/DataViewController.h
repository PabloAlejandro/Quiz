//
//  DataViewController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCollectionViewController.h"

@protocol DataDelegate <NSObject>

- (void)userDidSelectResponse:(NSString *)response forQuestion:(NSString *)question;

@end

@interface DataViewController : UCollectionViewController

@property (nonatomic, weak) IBOutlet UILabel *dataLabel;
@property (nonatomic, strong) NSDictionary * dataObject;
@property (nonatomic, weak) id <DataDelegate> delegate;
@end

