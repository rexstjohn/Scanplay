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
    __weak NSMutableArray *bodyTexts = [NSMutableArray arrayWithCapacity:self.answers.count];
    __weak NSMutableArray *titleTexts = [NSMutableArray arrayWithCapacity:self.answers.count];
    
    [titleTexts addObject:question.title];
    [bodyTexts addObject:question.body];
    
    [self.answers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isMemberOfClass:[SPStackOverflowQuestion class]]) {
            [bodyTexts addObject:[obj body]];
            [titleTexts addObject:[obj title]];
        }
        if(idx == weakSelf.answers.count-1){
            weakSelf.titleArray = [NSArray arrayWithArray:titleTexts];
            weakSelf.bodyTextArray = [NSArray arrayWithArray:bodyTexts];
            [weakSelf.tableView performSelectorOnMainThread:@selector(reloadData)
                                                 withObject:nil
                                              waitUntilDone:YES];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    } else{
        return self.answers.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(indexPath.section == 0){
        UILabel *titleLabel = (UILabel*)[cell viewWithTag:10];
        titleLabel.text = self.question.title;
        
        UILabel *bodyLabel = (UILabel*)[cell viewWithTag:11];
        bodyLabel.text = self.question.body;
    } else{
        SPStackOverflowAnswer *answer = [self.answers objectAtIndex:indexPath.row];
        
        UILabel *titleLabel = (UILabel*)[cell viewWithTag:10];
        titleLabel.text = @"";
        
        UILabel *bodyLabel = (UILabel*)[cell viewWithTag:11];
        bodyLabel.text = answer.body;
    }
    
    return cell;
}

@end
