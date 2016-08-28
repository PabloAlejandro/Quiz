//
//  QuizController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizController : NSObject

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
- (BOOL)addResponse:(NSString *)response toQuestion:(NSString *)question;

// Method to get the amount of responses given by the user
- (NSUInteger)numberOfUserResponses;

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

// Name of the local JSON file
@property (nonatomic, copy, readonly) NSString * fileName;

// Array of the Quiz questions and response options
@property (nonatomic, copy, readonly) NSArray <NSDictionary *> * questions;

// Questions array sorted randomly
@property (nonatomic, copy, readonly) NSArray <NSDictionary *> * randomQuestions;

// Date when the Quiz started
@property (nonatomic, strong, readonly) NSDate * startDate;

// Current question index in the array of questions
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

// Max time interval to finish the Quiz
@property (nonatomic, assign, readonly) NSTimeInterval maxTimeInterval;

// Wether or not the Quiz started
@property (nonatomic, assign, readonly, getter=isStarted) BOOL started;

@end
