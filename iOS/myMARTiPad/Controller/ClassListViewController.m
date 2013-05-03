//
//  ClassListViewController.m
//  MyMart
//
//  Created by Komsan Noipitak on 3/26/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "ClassListViewController.h"

Login *login;
ClassList *classList;
UnitList *unitList;

@interface ClassListViewController ()

@end

@implementation ClassListViewController
@synthesize selectedUnit;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initial parameter
    classListArray = [[NSArray alloc]init];
    unitListArray  = [[NSArray alloc]init];
    login = [[Login alloc]init];
    [Login sharedInstance];
    
    isAlreadyGetClassList = NO;
    isUserHasOnlyOneClass = NO;
    
    // Set AnchorRightRevealAmount
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    // Add UISwipeGestureRecognizer in unitTableView
    UISwipeGestureRecognizer *gestureR = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(handleSwipe)];
    gestureR.direction = UISwipeGestureRecognizerDirectionRight;
    [unitTableView addGestureRecognizer:gestureR];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Send request class list
    if (!isAlreadyGetClassList) {
        [self getClassList];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Calling API ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: getClassList
 * Description: This method for creating model to call GetClassList API
 * Parameters: -
 */

- (void)getClassList
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(classListFinished:)
                                                 name:@"classList"
                                               object:nil ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(classListDidFailWithError:)
                                                 name:@"ClassListError"
                                               object:nil ];
    
    // Create model for call API
    classList = [[ClassList alloc]init];
    [ClassList sharedInstance];
    [classList getClassList:login.userID];
    
}

/**
 * Method name: getUnitList:
 * Description: This method for creating model to call GetUnitList API
 * Parameters: classIDSelected
 */

- (void)getUnitList:(NSString *)classIDSelected
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unitListFinished:)
                                                 name:@"unitList"
                                               object:nil ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unitListDidFailWithError:)
                                                 name:@"unitListError"
                                               object:nil ];
    
    // Create model for calling API
    unitList = [[UnitList alloc]init];
    [UnitList sharedInstance];
    [unitList getUnitList:login.userID :classIDSelected];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: classListFinished:
 * Description: Sent from model when GetClassListAPI has finished loading successfully.
 * Parameters: notification
 */

- (void)classListFinished:(NSNotification *)notification{
    
    classListArray = classList.userClassList;
    isAlreadyGetClassList = YES;
    [self.tableView reloadData];
   
    // Check class has one calss
    if (classList.isUserHasOnlyOneClass) {
        
        isUserHasOnlyOneClass = YES;
        classTitle = [[classListArray objectAtIndex:0]objectForKey:@"ClassTitle"];
        [self animationUnitTableView];
        [self getUnitList:[[classListArray objectAtIndex:0]objectForKey:@"ClassID"]];
        
    }
}

/**
 * Method name: unitListFinished:
 * Description: Sent from model when GetUnitListAPI has finished loading successfully.
 * Parameters: notification
 */

- (void)unitListFinished:(NSNotification *)notification{
    
    unitListArray = unitList.userUnitList;
    
    // Reload data in unitTableView
    [unitTableView reloadData];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Handle Error Function ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: classListDidFailWithError:
 * Description: Sent from model when GetClassListAPI fails to load successfully.
 * Parameters: notification
 */

- (void)classListDidFailWithError:(NSNotification *)notification {
    
    NSString *messgage = classList.errorMessage;
    UIAlertView *classListErrorAlertView = [[UIAlertView alloc]initWithTitle:@"No Internet Connection"
                                                                 message:messgage
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];
    [classListErrorAlertView show];
}

/**
 * Method name: unitListDidFailWithError:
 * Description: Sent from model when GetUnitListAPI fails to load successfully.
 * Parameters: notification
 */

- (void)unitListDidFailWithError:(NSNotification *)notification {
    
    NSString *messgage = unitList.errorMessage;
    
    // Show alertView with message
    UIAlertView *unitListErrorAlertView = [[UIAlertView alloc]initWithTitle:@"No Internet Connection"
                                                                 message:messgage
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];
    [unitListErrorAlertView show];
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark - === TableView data source and delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: numberOfSectionsInTableView:
 * Description: Asks the data source to return the number of sections in the table view.
 * Parameters: tableView
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections in table view.
    return 1;
}

/**
 * Method name: tableView:titleForHeaderInSection:
 * Description: Asks the data source for the title of the header of the specified section of the table view.
 * Parameters: tableView, section
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    // Return the header of title in section
    
    if (tableView == self.tableView){
        
        return @"Class Selection";
        
    }else{
        
        return classTitle;
    }    
}

/**
 * Method name: tableView:viewForHeaderInSection:
 * Description: Asks the delegate for a view object to display in the header of the specified section of the table view.
 * Parameters: tableView, section
 */

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0,200,1024,55)];
    tempView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor colorWithRed:93.0/255.0 green:30.0/255.0 blue:39.0/255.0 alpha:1.0];
    tempLabel.font = [UIFont boldSystemFontOfSize:20];
    tempLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    [tempView addSubview:tempLabel];
    
    return tempView;
}

/**
 * Method name: tableView:heightForHeaderInSection:
 * Description: Asks the delegate for the height to use for the header of a particular section.
 * Parameters: tableView, section
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

/**
 * Method name: tableView:heightForRowAtIndexPath:
 * Description: Asks the delegate for the height to use for a row in a specified location.
 * Parameters: tableView, indexPath
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

/**
 * Method name: tableView:numberOfRowsInSection:
 * Description: Tells the data source to return the number of rows in a given section of a table view. (required)
 * Parameters: tableView, section
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    if (tableView == self.tableView) {
        
        return [classListArray count];
        
    }else{
        
        return [unitListArray count];
    }
}

/**
 * Method name: tableView:cellForRowAtIndexPath:
 * Description: Asks the data source for a cell to insert in a particular location of the table view. (required)
 * Parameters: tableView, indexPath
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (tableView == self.tableView) {
        
        // Set text of label (ClassTitle)
        cell.textLabel.text = [[classListArray objectAtIndex:indexPath.row]
                                                      objectForKey:@"ClassTitle"];
    
    }else if (tableView == unitTableView){
  
        // Set text of label (UnitTitle)
        cell.textLabel.text = [[unitListArray objectAtIndex:indexPath.row]
                                                      objectForKey:@"UnitTitle"];
    }
    
    // Set font, background color of label
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor   = [UIColor clearColor];
    
    // Set content view background
    cell.contentView.backgroundColor = [UIColor colorWithRed:48.0/255.0
                                                       green:53.0/255.0
                                                        blue:58.0/255.0
                                                       alpha:1.0];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:106.0/255.0
                                                    green:35.0/255.0
                                                     blue:45.0/255.0
                                                    alpha:1.0]];
    bgColorView.layer.cornerRadius = 5.0;
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

/**
 * Method name: tableView:didSelectRowAtIndexPath:
 * Description: Tells the delegate that the specified row is now selected.
 * Parameters: tableView, indexPath
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Selected row in self.tableView 
    if (tableView == self.tableView) {

        selectedIndexPath = indexPath;
        
        // Get classTitle for use in header of unitTableview
        classTitle = [[classListArray objectAtIndex:indexPath.row]
                                       objectForKey:@"ClassTitle"];
        
        // Get classID for requesting GetUnitList API
        NSString *classIDSelected = [[classListArray objectAtIndex:indexPath.row]
                                                      objectForKey:@"ClassID"];
        
        // Pass "classIDSelected" to getUnitList()
        [self getUnitList:classIDSelected];
        
        // Animated unitTableview 
        [self animationUnitTableView];
        
    // Selected row in unitTableView    
    }else if (tableView == unitTableView) {
        
        selectedUnit = YES;
        ResultEntryViewController *resultEntryViewController = [[ResultEntryViewController alloc]init];
        
        // Set unitTitleLabel
        NSString *unitTitle = [[unitListArray objectAtIndex:indexPath.row]
                                               objectForKey:@"UnitTitle"];

        resultEntryViewController.unitTitle = unitTitle;
        
        // Hide ClassListView & UnitListView
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = resultEntryViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Animated Unit TableView ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: animationUnitTableView
 * Description: For presenting unitTableView
 * Parameters: -
 */

- (void) animationUnitTableView{

    // Set origin of unitTableView and add to view
    unitTableView.frame = CGRectMake(1024, 0, unitTableView.bounds.size.width, unitTableView.bounds.size.height);
    unitTableView.layer.shadowOpacity = 0.75f;
    unitTableView.layer.shadowRadius  = 10.0f;
    unitTableView.layer.shadowColor   = [UIColor blackColor].CGColor;
    [self.view addSubview:unitTableView];
    
    // Animated unitTableview
    [UIView animateWithDuration:0.5
                     animations:^{
                         unitTableView.frame = CGRectMake(0, 0, unitTableView.bounds.size.width, unitTableView.bounds.size.height);}];
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Swipe gesture handle ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: handleSwipe
 * Description: For handle with swipe gesture
 * Parameters: -
 */

- (void)handleSwipe
{
    if (!isUserHasOnlyOneClass) {
        classTitle = @"";
        
        // Deselect row in classTableview
        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        // Animated unitTableview
        [UIView animateWithDuration:0.5
                         animations:^{
                             unitTableView.frame = CGRectMake(1024, 0,unitTableView.bounds.size.width, unitTableView.bounds.size.height);}];
        unitListArray = [[NSArray alloc]init];
        [unitTableView reloadData];

    }
}


@end
