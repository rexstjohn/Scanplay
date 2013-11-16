//
//  SPAnswerTableViewController.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPAnswerTableViewController.h"
#import "SPStackOverflowQuestion.h"
#import "SPStackOverflowAnswer.h"

@interface SPAnswerTableViewController ()
@property(nonatomic,strong, readwrite) NSArray *answers;
@end

@implementation SPAnswerTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setQuestion:(SPStackOverflowQuestion*)question{
    _question = question;
    _answers = question.answers;
    
    __weak SPAnswerTableViewController *weakSelf= self;
    __weak NSMutableArray *bodyTexts = [NSMutableArray arrayWithCapacity:self.answers.count+1];
    __weak NSMutableArray *titleTexts = [NSMutableArray arrayWithCapacity:self.answers.count+1];
    
    [titleTexts addObject:question.title];
    [bodyTexts addObject:question.body];
    self.titleArray = titleTexts;
    
    if(self.answers.count != 0 && self.answers != nil){
        [self.answers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isMemberOfClass:[SPStackOverflowAnswer class]]) {
                [bodyTexts addObject:[obj body]];
            }
            if(idx == weakSelf.answers.count-1){
                weakSelf.bodyTextArray = [NSArray arrayWithArray:bodyTexts];
                [weakSelf.tableView performSelectorOnMainThread:@selector(reloadData)
                                                     withObject:nil
                                                  waitUntilDone:YES];
            }
        }];
    } else {
        weakSelf.bodyTextArray = [NSArray arrayWithArray:bodyTexts];
        [weakSelf.tableView performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 2){
        if(self.answers.count == 0){
            return 54.0f;
        } else {
            return 0.0f;
        }
    }
    
    NSString *bodyText  = @"";
    NSString *titleText = @"";
    
    if(self.bodyTextArray.count > indexPath.row){
        bodyText = [self.bodyTextArray objectAtIndex:indexPath.row];
    }
    
    if(self.titleArray.count > indexPath.row && indexPath.section == 1){
        titleText = [self.titleArray objectAtIndex:indexPath.row];
    }
    
    CGSize bodyTextSize = [self frameForText:bodyText sizeWithFont:nil constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    CGSize titleTextSize =[self frameForText:titleText sizeWithFont:nil constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    return bodyTextSize.height + titleTextSize.height + 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    } else if (section == 1){
        return self.answers.count;
    } else{
        if(self.answers.count == 0){
            return 1;
        } else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *titleLabel = (UILabel*)[cell viewWithTag:10];
    UILabel *bodyLabel = (UILabel*)[cell viewWithTag:11];
    
    if(indexPath.section == 0){
        titleLabel.text = self.question.title;
        bodyLabel.text = self.question.body;
        
        cell.backgroundColor = [UIColor lightGrayColor];
    } else if (indexPath.section == 1){
        SPStackOverflowAnswer *answer = [self.answers objectAtIndex:indexPath.row];
        titleLabel.text = @"";
        bodyLabel.text = answer.body;
        
        if(answer.is_accepted == YES){
            cell.backgroundColor = [UIColor greenColor];
        } else{
            cell.backgroundColor = [UIColor whiteColor];
        }
    } else {
        titleLabel.text = @"This question has no answer.";
        bodyLabel.text = @"";
    }
    
    return cell;
}

@end
