//
//  ModelController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController, QuizController;

@interface ModelController : NSObject 

- (instancetype)initWithQuizController:(QuizController *)quizController NS_DESIGNATED_INITIALIZER;
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
- (NSUInteger)numberOfViewControllers;

@property (nonatomic, strong) QuizController * quizController;

@end

