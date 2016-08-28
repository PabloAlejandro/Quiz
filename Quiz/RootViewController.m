//
//  RootViewController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataViewController.h"
#import "QuizController.h"
#import "AppDelegate.h"
#import "DoneViewController.h"
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>

@interface RootViewController () <DataDelegate>

@property (nonatomic, strong) ModelController *modelController;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSUInteger page;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.page = self.quizController.currentIndex;
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [self goToPage:self.page];

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat topPadding = 80;
    CGFloat bottomPadding = 70;
    self.pageViewController.view.frame = CGRectMake(0, topPadding * 1.2, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - topPadding - bottomPadding);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set start date if not started
    [self.quizController start];
    
    [self updateTimeLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timerUpdated)
                                                userInfo:nil
                                                 repeats:true];
}

#pragma mark - Private

- (void)timerUpdated
{
    [self updateTimeLabel];
    if([self.quizController finished]) {
        [self timeOut];
    }
}

- (void)updateTimeLabel
{
    NSTimeInterval elapsed = fabs([self.quizController.startDate timeIntervalSinceNow]);
    
    NSInteger minutes = (self.quizController.maxTimeInterval - elapsed) / 60;
    NSInteger seconds = (self.quizController.maxTimeInterval - elapsed) - minutes * 60;
    
    if(minutes > 0)
        self.timeLabel.text = [NSString stringWithFormat:@"%lu min. %lu s.", minutes, seconds];
    else
        self.timeLabel.text = [NSString stringWithFormat:@"%lu s.", seconds];
    
    self.timeLabel.backgroundColor = elapsed > 10 ? [UIColor whiteColor] : [UIColor redColor];
}

- (void)timeOut
{
    [self stopTimer];
    
    self.timeLabel.text = @"Time out!";
    
    __weak __typeof(self) weakSelf = self;
    [UIAlertView showWithTitle:@"Quiz finished"
                       message:@"Oops! Time is out, we are sorry you couldn't finish the Quiz on time."
             cancelButtonTitle:@"Accept"
             otherButtonTitles:nil
                      tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                          [weakSelf endQuiz];
                      }];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)endQuiz
{
    DoneViewController *viewController = (DoneViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DoneViewController"];
    viewController.quizController = self.quizController;
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = viewController;
}

- (void)goToPage:(NSUInteger)page
{
    DataViewController *viewController = [self.modelController viewControllerAtIndex:page++
                                                                                  storyboard:self.storyboard];
    viewController.delegate = self;
    
    __weak __typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[viewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:^(BOOL finished) {
                                         weakSelf.pageLabel.text = [NSString stringWithFormat:@"%lu of %lu", weakSelf.page+1, [weakSelf.modelController numberOfViewControllers]];
                                     }];
}

- (void)goToNextQuestion
{
    if(self.page < [self.modelController numberOfViewControllers] - 1) {
        self.page++;
        [self goToPage:self.page];
    }
    else {
        
        [self stopTimer];
        
        __weak __typeof(self) weakSelf = self;
        [UIAlertView showWithTitle:@"Quiz finished"
                           message:@"Congrats! You have finished the Quiz on time."
                 cancelButtonTitle:@"Accept"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                              [weakSelf endQuiz];
                          }];
    }
}

// Testing purpouses method, the user shouldn't be allowed to go back
- (void)goToPreviousQuestion
{
    if(self.page > 0) {
        self.page--;
        [self goToPage:self.page];
    }
}

#pragma mark - Getters

- (ModelController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] initWithQuizController:self.quizController];
    }
    return _modelController;
}

- (QuizController *)quizController {
    if(!_quizController) {
        AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
        _quizController = delegate.quizController;
    }
    return _quizController;
}

#pragma mark - DataDelegate

- (void)userDidSelectResponse:(NSString *)response forQuestion:(NSString *)question
{
    if([self.quizController responseIsCorrect:response question:question]) {
        // TODO: Add animation or any feedback for the user about his/her response 
    }
    
    if([self.quizController addResponse:response toQuestion:question]) {
        [self goToNextQuestion];
    }
}

@end
