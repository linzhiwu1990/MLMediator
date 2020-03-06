//
//  MLViewController.m
//  MLMediator
//
//  Created by linzhiwu on 06/21/2019.
//  Copyright (c) 2019 linzhiwu. All rights reserved.
//

#import "MLViewController.h"
#import "MLRoomViewController.h"
#import "MLStartLiveViewController.h"

@interface MLViewController ()

@end

@implementation MLViewController

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
- (IBAction)clickActionButton:(id)sender {
    
    MLRoomViewController *roomVC = [[MLRoomViewController alloc] init];
    [self.navigationController pushViewController:roomVC animated:YES];
}
- (IBAction)clickStartLiveButton:(UIButton *)sender {
    MLStartLiveViewController *startLiveVC = [[MLStartLiveViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:startLiveVC];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navController animated:YES completion:nil];
    
}

@end
