//
//  QuizController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "QuizController.h"
#import "NSFileManager+Plist.h"
#import "ApplicationStateUtils.h"

@interface QuizController ()

@property (nonatomic, strong, readonly) NSDictionary * content;
@property (nonatomic, copy, readonly) NSString * fileName;

@end

@implementation QuizController

- (instancetype)initWithFileName:(NSString *)fileName {
    if(self = [super init]) {
        _fileName = fileName;
        _content = [[NSFileManager defaultManager] readJson:fileName];
        _questions = [[_content allKeys] copy]; // make dictionary with key and results
    }
    return self;
}

#pragma mark - Private


#pragma mark - Public instance methods

- (NSArray <NSString *> *)imagesForQuestion:(NSString *)question
{
    return [self.content objectForKey:question];
}

- (NSString *)responseForQuestion:(NSString *)question
{
    return [[self.content objectForKey:question] firstObject];
}

- (BOOL)responseIsCorrect:(NSString *)response question:(NSString *)question
{
    return [[self responseForQuestion:question] isEqualToString:response];
}

- (void)markAsDone:(BOOL)done
{
    [ApplicationStateUtils setBoolProperty:self.fileName value:done];
}

- (void)setPoint:(NSInteger)point forQuestion:(NSString *)question
{
    [ApplicationStateUtils setIntProperty:self.fileName value:point];
}

- (NSInteger)totalPoints
{
    NSInteger points = 0;
    for(NSString * question in self.questions) {
        points += [ApplicationStateUtils getIntProperty:question orDefault:0];
    }
    return points;
}

- (BOOL)quizAlreadyDone
{
    return [[self class] quizAlreadyDone:self.fileName];
}

#pragma mark - Public class methods

+ (BOOL)quizAlreadyDone:(NSString *)quizName
{
#ifdef DEBUG
    // TODO: Restore result
    return false;
#endif
    
    return [ApplicationStateUtils getBoolProperty:quizName orDefault:false];
}

@end
