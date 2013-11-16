//
//  StackOverflowClientTests.m
//  StackOverflowClientTests
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPStackOverflowNetworkingEngine.h"
#import "SPAsyncTesting.h"
#import "SPStackOverflowQuestion.h"


@interface StackOverflowClientTests : XCTestCase
@property(nonatomic,strong) SPStackOverflowNetworkingEngine *networkingEngine;
@end

@implementation StackOverflowClientTests

- (void)setUp
{
    [super setUp];
    self.networkingEngine = [[SPStackOverflowNetworkingEngine alloc] initWithHostName:@"api.stackexchange.com"];
    [self.networkingEngine useCache];
}

- (void)tearDown
{
    // Force the test to sleep the thread and allow async testing to complete.
    [NSThread sleepForTimeInterval:1.0];
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testQuestionsQuery
{
    
    StartBlock();
    NSDictionary *parameters = @{@"tagged":@"objective-c",
                                 @"site":@"stackoverflow",
                                 @"order":@"desc",
                                 @"sort":@"activity",
                                 @"filter":@"!-.CabyPaznWF"};
    
    StackOverflowQuestionsResponseBlock response = ^(NSArray *questions){
        XCTAssertNotNil(questions);
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        XCTAssertNil(error);
    };
    
    
    [self.networkingEngine questionsWithParameters:parameters
                                  completionHandler:response
                                       errorHandler:errorBlock];
    
    WaitUntilBlockCompletes();
}

- (void)testQuestionQuery
{
    StartBlock();
    NSDictionary *parameters = @{@"order":@"desc",
                                 @"site":@"stackoverflow",
                                 @"sort":@"activity",
                                 @"filter":@"withbody"};
    StackOverflowQuestionResponseBlock response = ^(SPStackOverflowQuestion *question){
        XCTAssertNotNil(question);
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        XCTAssertNil(error);
    };
    
    
    [self.networkingEngine questionWithQuestionId:@1
                                   withParameters:parameters
                                completionHandler:response
                                     errorHandler:errorBlock];
    WaitUntilBlockCompletes();
}

@end
