//
//  QuizController.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "QuizController.h"
#import "NSFileManager+Json.h"
#import "ApplicationStateUtils.h"

#define kContentKey                 @"Content"
#define kFileNameKey                @"FileName"
#define kResponsesKey               @"Responses"
#define kQuestionsKey               @"Questions"
#define kStartDateKey               @"StartDate"

static NSTimeInterval const maxTimeInterval = 2 * 60;

@interface QuizController ()

@property (nonatomic, strong, readwrite) NSDate * startDate;
@property (nonatomic, copy, readwrite) NSString * fileName;
@property (nonatomic, strong, readwrite) NSDictionary * content;
@property (nonatomic, strong) NSMutableDictionary * responses;

@end

@implementation QuizController

- (instancetype)initWithFileName:(NSString *)fileName {
    
    if(self = [super init]) {
        
        _fileName = fileName;
//        _content = [[NSFileManager defaultManager] readJson:fileName];
//        NSMutableArray * questions = [NSMutableArray new];
//        for(NSString * key in [_content allKeys]) {
//            NSDictionary * dict = @{
//                                    @"question" : key,
//                                    @"responses" : [_content objectForKey:key] ? :[NSNull null]
//                                    };
//            [questions addObject:dict];
//        }
//        _questions = [questions copy];
//        _responses = [NSMutableDictionary new];
        
        // Get data from last session
        NSDictionary * info = [ApplicationStateUtils getObjectProperty:fileName orDefault:nil];
        
        if(info) {
            
            if([[info objectForKey:kContentKey] isKindOfClass:[NSDictionary class]])
                _content = [info objectForKey:kContentKey];
            
            if([[info objectForKey:kQuestionsKey] isKindOfClass:[NSArray class]])
                _questions = [info objectForKey:kQuestionsKey];
            
            if([[info objectForKey:kResponsesKey] isKindOfClass:[NSDictionary class]])
                _responses = [[NSMutableDictionary alloc] initWithDictionary:[info objectForKey:kResponsesKey]];
            
            if([[info objectForKey:kStartDateKey] isKindOfClass:[NSDate class]])
                _startDate = [info objectForKey:kStartDateKey];
        }
        
        // If there wasn't any data we initialiase it
        if(!_content)
            _content = [[NSFileManager defaultManager] readJson:fileName];
        
        if(!_questions) {
            NSMutableArray * questions = [NSMutableArray new];
            for(NSString * key in [_content allKeys]) {
                NSDictionary * dict = @{
                                        @"question" : key,
                                        @"responses" : [_content objectForKey:key] ? :[NSNull null]
                                        };
                [questions addObject:dict];
            }
            _questions = [questions copy];
        }
        
        if(!_responses)
            _responses = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Private

+ (NSString *)finishedKeyForFile:(NSString *)fileName {
    return [NSString stringWithFormat:@"%@_finished", fileName];
}

#pragma mark - Public instance methods

- (NSArray <NSString *> *)imagesForQuestion:(NSString *)question
{
    return [self.content objectForKey:question];
}

- (NSString *)correctResponseForQuestion:(NSString *)question
{
    return [[self.content objectForKey:question] firstObject];
}

- (BOOL)responseIsCorrect:(NSString *)response question:(NSString *)question
{
    if(!response || !question) {return false;}
    
    return [[self correctResponseForQuestion:question] isEqualToString:response];
}

- (NSString *)userResponseForQuestion:(NSString *)question;
{
    return [self.responses objectForKey:question];
}

- (BOOL)addResponse:(NSString *)response toQuestion:(NSString *)question
{
    if(!response || !question) {return false;}
    [self.responses setObject:response forKey:question];
    return true;
}

- (void)start
{
    if(![self isStarted]) {
        self.startDate = [NSDate date];
    }
}

- (void)restart
{
    self.startDate = nil;
    self.responses = [NSMutableDictionary new];
    
    [ApplicationStateUtils setObjectProperty:self.fileName value:nil];
}

- (NSInteger)totalPoints
{
    NSInteger points = 0;
    for(NSString * question in [self.responses allKeys]) {
        NSString * response = [self.responses objectForKey:question];
        NSUInteger point = [self responseIsCorrect:response question:question] ? 1 : 0;
        points += point;
    }
    return points;
}

- (BOOL)finished
{
    return fabs([self.startDate timeIntervalSinceNow]) >= self.maxTimeInterval ||
    self.responses.count == self.questions.count;
}

#pragma mark - Getters

- (BOOL)isStarted {
    return self.startDate != nil;
}

- (NSUInteger)currentIndex {
    return [self.responses allKeys].count;
}

- (NSTimeInterval)maxTimeInterval {
    return maxTimeInterval;
}

- (void)saveState {
    
    NSMutableDictionary * info = [NSMutableDictionary new];
    
    if(self.content)
        [info setObject:self.content forKey:kContentKey];
    
    if(self.questions)
        [info setObject:self.questions forKey:kQuestionsKey];
    
    if(self.responses)
        [info setObject:self.responses forKey:kResponsesKey];
    
    if(self.startDate)
        [info setObject:self.startDate forKey:kStartDateKey];
    
    [ApplicationStateUtils setObjectProperty:self.fileName value:info];
}

@end
