//
//  MainViewController.m
//  MyMart
//
//  Created by Komsan Noipitak on 4/10/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "MainViewController.h"


ClassListViewController *classListViewController;

@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    // Set ClassListViewController as a underLeftViewController
    classListViewController = [[ClassListViewController alloc]initWithNibName:@"ClassListViewController"
                                                                       bundle:nil];
    self.slidingViewController.underLeftViewController = classListViewController;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === UIAction ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


@end
