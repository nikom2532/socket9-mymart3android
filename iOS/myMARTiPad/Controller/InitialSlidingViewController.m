//
//  InitialSlidingViewController.m
//  MyMart
//


#import "InitialSlidingViewController.h"

MainViewController *mainViewController;

@interface InitialSlidingViewController ()

@end

@implementation InitialSlidingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set ResultEntryViewController as a top view of main view
    mainViewController = [[MainViewController alloc]initWithNibName:@"MainViewController"
                                                                           bundle:nil];
    self.topViewController = mainViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return  UIInterfaceOrientationIsLandscape(toInterfaceOrientation);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
