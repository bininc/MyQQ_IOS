//
//  AboutTableViewController.m
//  MyQQ
//
//  Created by bininc on 16/1/17.
//  Copyright © 2016年 bininc. All rights reserved.
//

#import "AboutTableViewController.h"

@interface AboutTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *abuotLabel;
@end

@implementation AboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getcurrentVersion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getcurrentVersion
{
  self.abuotLabel.text = [NSString stringWithFormat:@"V%@_%@",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"],[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]];
}

@end
