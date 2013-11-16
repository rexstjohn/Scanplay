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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *bodyText = [self.bodyTextArray objectAtIndex:indexPath.row];
    NSString *titleText = [self.titleArray objectAtIndex:indexPath.row];
    CGSize bodyTextSize = [self frameForText:bodyText sizeWithFont:nil constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    CGSize titleTextSize = [self frameForText:titleText sizeWithFont:nil constrainedToSize:CGSizeMake(300.f, CGFLOAT_MAX)];
    return bodyTextSize.height + titleTextSize.height + 80;
}

-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size{
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    return frame.size;
}

@end
