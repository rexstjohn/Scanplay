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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    };
    
    
    MKNKErrorBlock errorBlock = ^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get results" message:@"Check your internet connection and try again" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    };
    
    
    [self.networkingEngine questionsWithParameters:parameters
                                 completionHandler:response
                                      errorHandler:errorBlock];
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
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
