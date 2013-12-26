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
                                 @"filter":@"!-.CabyPaznWF",
                                 @"page":[[NSNumber numberWithInteger:1] stringValue],
                                 @"pagesize":[[NSNumber numberWithInteger:3] stringValue]};
    
    StackOverflowQuestionsResponseBlock response = ^(NSArray *questions){
        XCTAssertNotNil(questions);
        XCTAssertTrue(questions.count > 0);
        NSLog(@"Questions returned with length: %i", questions.count);
        EndBlock();
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        XCTAssertNil(error);
        EndBlock();
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
        NSLog(@"Question returned with body: %@", question.body);
        EndBlock();
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        XCTAssertNil(error);
        EndBlock();
    };
    
    
    [self.networkingEngine questionWithQuestionId:@20025570
                                   withParameters:parameters
                                completionHandler:response
                                     errorHandler:errorBlock];
    WaitUntilBlockCompletes();
}

@end
