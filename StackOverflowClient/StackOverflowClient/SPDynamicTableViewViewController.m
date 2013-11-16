//
//  SPDynamicTableViewViewController.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPDynamicTableViewViewController.h"

@interface SPDynamicTableViewViewController ()

@end

@implementation SPDynamicTableViewViewController

// This is the method that determines the height of each cell.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self getTextAtIndex:indexPath];
    CGSize size = [self frameForText:text sizeWithFont:nil constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    return size.height + 80;
}

// Think of this as some utility function that given text, calculates how much
// space would be needed to fit that text.
-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size{
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    
    // This contains both height and width, but we really care about height.
    return frame.size;
}

// Think of this as a source for the text to be rendered in the text view.
// I used a dictionary to map indexPath to some dynamically fetched text.
- (NSString*) getTextAtIndex: (NSIndexPath *) indexPath
{
    return @"This is stubbed text - update it to return the text of the text view.";
}

@end
