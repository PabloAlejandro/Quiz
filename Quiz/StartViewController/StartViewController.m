//
//  StartViewController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 27/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "StartViewController.h"
#import "QuizController.h"
#import "AppDelegate.h"

static NSString * const kStartSegue = @"StartSegue";

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // If the quiz has been already started we go straight to the next view controller.
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    if([delegate.quizController isStarted])
        [self performSegueWithIdentifier:kStartSegue sender:self];
}

@end
