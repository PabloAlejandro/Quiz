//
//  JsonTests.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 28/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSFileManager+Json.h"

@interface JsonTests : XCTestCase

@end

@implementation JsonTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGoodFile {
    NSAssert([[NSFileManager defaultManager] readJson:@"zquestions"] != nil, @"File must be valid");
    NSAssert([[[NSFileManager defaultManager] readJson:@"zquestions"] isKindOfClass:[NSDictionary class]], @"File content must be a dictionary");
}

- (void)testWrongFile {
    NSAssert([[NSFileManager defaultManager] readJson:@"test"] == nil, @"File should be invalid");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
