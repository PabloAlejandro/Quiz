//
//  RootViewController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizController;

@interface RootViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UILabel * pageLabel;
@property (nonatomic, weak) IBOutlet UIButton * nextButton;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) QuizController * quizController;

@end

