//
//  DoneViewController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizController;

@interface DoneViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton * restartButton;
@property (nonatomic, weak) IBOutlet UILabel * doneLabel;
@property (nonatomic, weak) IBOutlet UILabel * pointsLabel;

@property (nonatomic, strong) QuizController * quizController;

@end
