//
//  QuizController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizController : NSObject //<NSCoding>

// init method not available
- (instancetype)init  __attribute__((unavailable("Must use initWithFileName: instead.")));

// Designated initializer
- (instancetype)initWithFileName:(NSString *)fileName NS_DESIGNATED_INITIALIZER;

// Method to returns a list of urls as strings
- (NSArray <NSString *> *)imagesForQuestion:(NSString *)question;

// Method to check if a response is correct
- (BOOL)responseIsCorrect:(NSString *)response question:(NSString *)question;

// Get correct response for a question
- (NSString *)correctResponseForQuestion:(NSString *)question;

// Get user's last response for question
- (NSString *)userResponseForQuestion:(NSString *)question;

// Method to save user's response
- (BOOL)addResponse:(NSString *)response toQuestion:(NSString *)question;;

// Method to set the starting date
- (void)start;

// DEBUG: method to restart quiz and start over again
- (void)restart;

// Current points for the quiz
- (NSInteger)totalPoints;

// Method to check if the user has already done the quiz
- (BOOL)finished;

// Method to save current state
- (void)saveState;

@property (nonatomic, copy, readonly) NSString * fileName;
@property (nonatomic, strong, readonly) NSArray <NSDictionary *> * questions;
@property (nonatomic, strong, readonly) NSDate * startDate;
@property (nonatomic, assign, readonly) NSUInteger currentIndex;
@property (nonatomic, assign, readonly) NSTimeInterval maxTimeInterval;
@property (nonatomic, assign, readonly, getter=isStarted) BOOL started;

@end
