//
//  DoneViewController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "DoneViewController.h"
#import "QuizController.h"
#import "AppDelegate.h"

@interface DoneViewController ()

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifdef DEBUG
    self.restartButton.hidden = false;
    self.restartButton.enabled = true;
#else
    self.restartButton.hidden = true;
    self.restartButton.enabled = false;
#endif
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.doneLabel.text = @"You have already done this quiz";
    self.pointsLabel.text = [NSString stringWithFormat:@"You got %lu points!", [self.quizController totalPoints]];
}

#pragma mark - Private

- (void)restartQuiz
{
    [self.quizController restart];
    self.quizController = nil;
    
    UIViewController *viewController = [self.storyboard instantiateInitialViewController];
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = viewController;
}

#pragma mark - IBAction methods

- (IBAction)restaryQuiz:(id)sender {
    [self restartQuiz];
}

#pragma mark - Getters

- (QuizController *)quizController {
    
    if(!_quizController) {
        AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
        _quizController = delegate.quizController;
    }
    return _quizController;
}

@end
