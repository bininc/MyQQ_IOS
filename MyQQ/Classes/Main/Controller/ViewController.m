//
//  ViewController.m
//  I-22-QQ框架
//
//  Created by Bininc on 15/12/10.
//  Copyright © 2015年 Bininc. All rights reserved.
//

#import "ViewController.h"
#import "XMPPFramework.h"

@interface ViewController () <XMPPStreamDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id delegate = [UIApplication sharedApplication].delegate;
    NSLog(@"%@",[delegate xmppStream]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
