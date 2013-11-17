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
#import <CoreText/CoreText.h>

@interface SPQuestionTableViewController ()
@property(nonatomic,strong) SPStackOverflowNetworkingEngine *networkingEngine;
@property(nonatomic,strong) NSMutableArray *questions;
@property(nonatomic,assign) NSUInteger currentPageIndex;
@property(nonatomic,assign) NSUInteger rowCount;
@end

@implementation SPQuestionTableViewController

NSInteger const kPageSize = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.networkingEngine = [[SPStackOverflowNetworkingEngine alloc] initWithHostName:@"api.stackexchange.com"];
    [self.networkingEngine useCache];
    self.currentPageIndex = 1;
    [self getQuestionsByPageIndex:self.currentPageIndex];
}

-(void)getQuestionsByPageIndex:(NSUInteger)pageIndex{
    
    NSDictionary *parameters = @{@"tagged":@"objective-c",
                                 @"site":@"stackoverflow",
                                 @"order":@"desc",
                                 @"sort":@"activity",
                                 @"filter":@"!-.CabyPaznWF",
                                 @"page":[[NSNumber numberWithInteger:pageIndex] stringValue],
                                 @"pagesize":[[NSNumber numberWithInteger:kPageSize] stringValue]};
    
    StackOverflowQuestionsResponseBlock response = ^(NSArray *questions){
        self.rowCount = self.questions.count + questions.count;
        if(self.questions.count > 0){
            [self.questions addObjectsFromArray:questions];
        } else {
            self.questions = [NSMutableArray arrayWithArray:questions];
        }
        // Force the questions data to reload itself.
        self.questions = _questions;
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get results"
                                                        message:@"Check your internet connection and try again"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Try Again", nil];
        [alert show];
    };
    
    [self.networkingEngine questionsWithParameters:parameters
                                 completionHandler:response
                                      errorHandler:errorBlock];
}


-(void)didTapGetMoreButton:(id)sender{
    self.currentPageIndex++;
    [self getQuestionsByPageIndex:self.currentPageIndex];
}

#pragma mark - AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        // Cancel button.
    }else{
        // Try again.
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self getQuestionsByPageIndex:self.currentPageIndex];
    }
}

#pragma mark - Setters

- (void) setQuestions:(NSArray *)questions{
    
    _questions = [questions mutableCopy];
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

#pragma mark - Table View Delegate

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.tableView.frame.size.width,44.0f)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Get More Questions" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapGetMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [aView addSubview:button];
    [button setFrame:aView.frame];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    return aView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SPStackOverflowQuestion *question = [self.questions objectAtIndex:indexPath.row];
    UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    UIColor* textColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
    NSDictionary *attrs = @{
                             NSFontAttributeName : font,
                             NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
    NSDictionary *colorAttrs = @{ NSForegroundColorAttributeName : textColor};
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]
                                      initWithString:[NSString stringWithFormat:@"#%i %@",indexPath.row+1,question.title]
                                      attributes:attrs];
    [attrString addAttributes:colorAttrs range:NSMakeRange(0, [[NSNumber numberWithInt:indexPath.row+1] stringValue].length+1)];
    
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:10];
    titleLabel.attributedText = attrString;
    
    UILabel *bodyLabel = (UILabel*)[cell viewWithTag:11];
    bodyLabel.text = question.body;
    
    UILabel *detailsLabel = (UILabel*)[cell viewWithTag:12];
    NSString *isAnswered = (question.hasAcceptedAnswer == YES)?@"YES":@"NO";
    detailsLabel.text = [NSString stringWithFormat:@"Answers: %i Accepted? %@", question.answers.count, isAnswered ];
    
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
         answerTable.question = question;
         answerTable.title = @"Answer";
     }
     
     
 }
 

@end
