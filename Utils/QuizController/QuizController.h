//
//  QuizController.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizController : NSObject

- (instancetype)init  __attribute__((unavailable("Must use initWithFileName: instead.")));
- (instancetype)initWithFileName:(NSString *)fileName NS_DESIGNATED_INITIALIZER;
- (NSArray <NSString *> *)imagesForQuestion:(NSString *)question;
- (BOOL)responseIsCorrect:(NSString *)response question:(NSString *)question;
- (void)markAsDone:(BOOL)done;
- (void)setPoint:(NSInteger)point forQuestion:(NSString *)question;
- (NSInteger)totalPoints;
- (BOOL)quizAlreadyDone;

+ (BOOL)quizAlreadyDone:(NSString *)quizName;

@property (nonatomic, strong, readonly) NSArray <NSDictionary *> * questions;

@end
