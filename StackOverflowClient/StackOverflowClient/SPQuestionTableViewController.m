//
//  SPTableViewController.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPQuestionTableViewController.h"
#import "SPStackOverflowNetworkingEngine.h"
#import "SPStackOverflowQuestion.h"
#import "SPAnswerTableViewController.h"

@interface SPQuestionTableViewController ()
@property(nonatomic,strong) SPStackOverflowNetworkingEngine *networkingEngine;
@property(nonatomic,strong) NSArray *questions;
@end

@implementation SPQuestionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.networkingEngine = [[SPStackOverflowNetworkingEngine alloc] initWithHostName:@"api.stackexchange.com"];
    [self.networkingEngine useCache];
    
    NSDictionary *parameters = @{@"tagged":@"objective-c",
                                 @"site":@"stackoverflow",
                                 @"order":@"desc",
                                 @"sort":@"activity",
                                 @"filter":@"!-.CabyPaznWF"};
    
    StackOverflowQuestionsResponseBlock response = ^(NSArray *questions){
        self.questions = questions;
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get results" message:@"Check your internet connection and try again" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    };
    
    
    [self.networkingEngine questionsWithParameters:parameters
                                 completionHandler:response
                                      errorHandler:errorBlock];
}

- (void) setQuestions:(NSArray *)questions{
    
    _questions = questions;
    __weak SPQuestionTableViewController *weakSelf= self;
    __weak NSMutableArray *bodyTexts = [NSMutableArray arrayWithCapacity:self.questions.count];
    __weak NSMutableArray *titleTexts = [NSMutableArray arrayWithCapacity:self.questions.count];
    
    [self.questions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isMemberOfClass:[SPStackOverflowQuestion class]]) {
            [bodyTexts addObject:[obj body]];
            [titleTexts addObject:[obj title]];
        }
        if(idx == questions.count-1){
            weakSelf.titleArray = [NSArray arrayWithArray:titleTexts];
            weakSelf.bodyTextArray = [NSArray arrayWithArray:bodyTexts];
            [weakSelf.tableView performSelectorOnMainThread:@selector(reloadData)
                                                 withObject:nil
                                              waitUntilDone:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Alert View Delegate


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SPStackOverflowQuestion *question = [self.questions objectAtIndex:indexPath.row];
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:10];
    titleLabel.text = question.title;
    
    UILabel *bodyLabel = (UILabel*)[cell viewWithTag:11];
    bodyLabel.text = question.body;
    
    return cell;
}

 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if([[segue identifier] isEqualToString:@"AnswerSegue"]){
         
         UITableViewCell *cell = (UITableViewCell*)sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         SPStackOverflowQuestion *question = (SPStackOverflowQuestion*)self.questions[indexPath.row];
         
         SPAnswerTableViewController *answerTable = (SPAnswerTableViewController*)[segue destinationViewController];
         answerTable.question=question;
         answerTable.answers=question.answers;
     }
     
     
 }
 

@end
