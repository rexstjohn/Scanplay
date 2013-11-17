//
//  PGSelectFriendsCollectionViewController.m
//  EatAGram
//
//  Created by Rex St John on 7/3/13.
//  Copyright (c) 2013 Pig. All rights reserved.
//

#import "PGSelectFriendsCollectionViewController.h"

@interface PGSelectFriendsCollectionViewController ()

@end

@implementation PGSelectFriendsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [Foursquare2 getFriendsOfUser:@"" callback:^(BOOL success, id result) {
        [self populateFriends];
    }];
}

- (void)populateFriends{
     
}

@end
