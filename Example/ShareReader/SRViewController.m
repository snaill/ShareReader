//
//  SRViewController.m
//  ShareReader
//
//  Created by snaill on 09/20/2015.
//  Copyright (c) 2015 snaill. All rights reserved.
//

#import "SRViewController.h"
#import <ShareReader/ShareReader.h>

@interface SRViewController ()

@end

@implementation SRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClicked:(id)sender {
    
    UIViewController * vc = [ShareReader readerWithID:@"P-0BF2B6DE-7A3B-15A2-574D-53D532192E51"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
