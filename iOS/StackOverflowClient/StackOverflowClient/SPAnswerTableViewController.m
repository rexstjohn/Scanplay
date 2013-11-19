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

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // Content size changes
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(preferredContentSizeChanged:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

#pragma mark - Content Size Changes

- (void)preferredContentSizeChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

#pragma mark - Question fetching and loading

-(void)setQuestion:(SPStackOverflowQuestion*)question{
    _question = question;
    _answers = question.answers;
    
    __weak SPAnswerTableViewController *weakSelf= self;
    NSMutableArray *bodyTexts = [NSMutableArray arrayWithCapacity:self.answers.count+1];
    NSMutableArray *titleTexts = [NSMutableArray arrayWithCapacity:self.answers.count+1];
    
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
    
    // Have to adjust the row index due to there being multiple sections
    NSString *bodyText  = @"";
    NSString *titleText = @"";
    NSUInteger row = (indexPath.section == 1)?1+indexPath.row:0;
    
    if(self.bodyTextArray.count > row){
        bodyText = [self.bodyTextArray objectAtIndex:row];
    }
    
    if(self.titleArray.count > row){
        titleText = [self.titleArray objectAtIndex:row];
    }
    
    CGSize bodyTextSize = [self frameForText:bodyText sizeWithFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    CGSize titleTextSize =[self frameForText:titleText sizeWithFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    return bodyTextSize.height + titleTextSize.height + 120;
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
    UITextView *bodyTextView = (UITextView*)[cell viewWithTag:11];
    
    if(indexPath.section == 0){
        titleLabel.text = self.question.title;
        bodyTextView.text = self.question.body;
        [[SPThemeResolver theme] themeQuestionTableViewCell:cell];
    } else if (indexPath.section == 1){
        SPStackOverflowAnswer *answer = [self.answers objectAtIndex:indexPath.row];
        NSString *answerText = answer.body;
        NSString *accepted = (answer.is_accepted == YES)?@"YES":@"NO";
        titleLabel.text = [NSString stringWithFormat:@"Answer #%i, Accepted: %@", indexPath.row+1, accepted];
        bodyTextView.text = answerText;
        
        if(answer.is_accepted == YES){
            cell.backgroundColor = [UIColor greenColor];
        } else{
            [[SPThemeResolver theme] themeAnswerTableViewCell:cell];
        }
    } else {
        titleLabel.text = @"This question has no answer.";
        bodyTextView.text = @"";
    }
     
    [[SPThemeResolver theme] themeTitleLabel:titleLabel];
    [[SPThemeResolver theme] themeBodyTextView:bodyTextView];
    return cell;
}

@end
