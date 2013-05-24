//
//  MainViewController.m
//  MyMart
//


#import "MainViewController.h"


ClassListViewController *classListViewController;
UIThemeManager *uiThemeManager;

@interface MainViewController ()

@end

@implementation MainViewController



/**
 * Method name: initWithNibName: bundle:
 * Description: Returns a newly initialized view controller with the nib file in the specified bundle.
 * Parameters: nibNameOrNil, nibBundleOrNil
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 * Method name: viewDidLoad
 * Description: Called after the controller’s view is loaded into memory.
 * Parameters: -
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    uiThemeManager = [[UIThemeManager alloc]init];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = uiThemeManager.shadowColor.CGColor;
    
    // Set ClassListViewController as a underLeftViewController
    classListViewController = [[ClassListViewController alloc]initWithNibName:@"ClassListViewController"
                                                                       bundle:nil];
    self.slidingViewController.underLeftViewController = classListViewController;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}


/**
 * Method name: didReceiveMemoryWarning
 * Description: Sent to the view controller when the app receives a memory warning.
 * Parameters: -
 */

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
