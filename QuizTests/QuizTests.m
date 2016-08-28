//
//  QuizTests.m
//  QuizTests
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuizController.h"

@interface QuizTests : XCTestCase

@property (nonatomic, strong) QuizController * quizController;

@end

@implementation QuizTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.quizController = [[QuizController alloc] initWithFileName:@"zquestions"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialiser {
    NSAssert(self.quizController != nil, @"quizController must be initialized");
}

- (void)testFileName {
    NSAssert([self.quizController.fileName isEqualToString:@"zquestions"], @"quizController file name must be 'zquestions'");
}

- (void)testsImages {
    
    NSAssert([[self.quizController imagesForQuestion:@""] count] == 0, @"Images for no question must be an empty array");
    NSAssert([[self.quizController imagesForQuestion:@"Sun-Dried Tomato Chicken Sausage"] count] == 4, @"Images for given question must be 4");
    
    for(id object in [self.quizController imagesForQuestion:@"Sun-Dried Tomato Chicken Sausage"]) {
        NSAssert([object isKindOfClass:[NSString class]], @"Images mut be given as NSString objects");
    }
}

- (void)testCorrectResponses {

    NSAssert([self.quizController responseIsCorrect:@"https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12111-89802d942e539321aea13671766e3c96.jpg" question:@"365 Organic Thai Jasmine Rice"] == true, @"Given response must be correct");
    
    NSAssert([self.quizController responseIsCorrect:@"https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12172-4b0201a183fb047f2e46165c749d12ff.jpg" question:@"365 Organic Thai Jasmine Rice"] == false, @"Given response must be incorrect");
    
    NSAssert([self.quizController responseIsCorrect:nil question:@"365 Organic Thai Jasmine Rice"] == false, @"Given response must be incorrect");
    
    NSAssert([self.quizController responseIsCorrect:@"https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12172-4b0201a183fb047f2e46165c749d12ff.jpg" question:nil] == false, @"Given response must be incorrect");
    
    NSAssert([self.quizController responseIsCorrect:nil question:nil] == false, @"Given response must be incorrect");
    
    NSAssert([[self.quizController correctResponseForQuestion:@"365 Organic Thai Jasmine Rice"] isEqualToString:@"https://d2lnr5mha7bycj.cloudfront.net/itemimage/image/12111-89802d942e539321aea13671766e3c96.jpg"], @"Given response must be the same");
}

- (void)testStartDate {
    
    NSAssert(self.quizController.startDate == nil, @"start date must be nil, since the test hasn't started yet");
    
    [self.quizController start];
    
    NSAssert(self.quizController.startDate != nil, @"start date must be different to nil, since the test has started already");
}

- (void)testRestart {
    
    [self.quizController start];
    [self.quizController restart];
    
    NSAssert(self.quizController.startDate == nil, @"start date must be nil, since the test hasn been restarted");
}

- (void)testResponses {
    
    [self.quizController addResponse:@"this is a response" toQuestion:@"this is a question"];
    
    NSAssert([[self.quizController userResponseForQuestion:@"this is a question"] isEqualToString:@"this is a response"], @"User response for question must be given ones");
    
    NSAssert(![[self.quizController userResponseForQuestion:@"this is a "] isEqualToString:@"this is a response"], @"User response for question mustn't be given ones");
    
    NSAssert(![[self.quizController userResponseForQuestion:@"this is a question"] isEqualToString:@" is a response"], @"User response for question mustn't be given ones");
    
    NSAssert([self.quizController userResponseForQuestion:nil] == nil, @"User response for nil mustn't be nil");
    
    [self.quizController addResponse:@"this is another response" toQuestion:@"this is another question"];
    
    NSAssert([self.quizController numberOfUserResponses] == 2, @"There must be 2 responses");
    
    [self.quizController addResponse:@"this is another response" toQuestion:@"this is another question"];
    
    NSAssert([self.quizController numberOfUserResponses] == 2, @"There must be 2 responses");
    
    [self.quizController addResponse:@"this is another response" toQuestion:@"this is another questionnn"];
    
    NSAssert([self.quizController numberOfUserResponses] == 3, @"There must be 3 responses");
}

- (void)testFinished {
    
    NSAssert([self.quizController finished] == false, @"Quiz shouldn't be finished");
    
    for(int i = 0; i < self.quizController.questions.count; i++) {
        [self.quizController addResponse:[NSString stringWithFormat:@"%d", i]
                              toQuestion:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSAssert([self.quizController finished] == true, @"Quiz must be finished");
    
//    [self.quizController start];
//
//    sleep(self.quizController.maxTimeInterval);
//
//    NSAssert([self.quizController finished] == true, @"Quiz must be finished");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
