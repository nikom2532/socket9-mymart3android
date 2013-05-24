//
//  ClassListViewController.m
//  MyMart
//


#import "ClassListViewController.h"

Login *login;
ClassList *classList;
UnitList *unitList;
UIThemeManager *uiThemeManager;

@interface ClassListViewController ()

@end

@implementation ClassListViewController
@synthesize selectedUnit;


/**
 * Method name: viewDidLoad
 * Description: Called after the controller’s view is loaded into memory.
 * Parameters: -
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Initial parameter
    uiThemeManager = [[UIThemeManager alloc]init];
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


/**
 * Method name: viewWillAppear
 * Description: Notifies the view controller that its view is about to be added to a view hierarchy.
 * Parameters: animated
 */

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Send request class list
    if (!isAlreadyGetClassList) {
        [self getClassList];
    }
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
    // Create model for call API
    classList = [[ClassList alloc]init];
    [ClassList sharedInstance];
    classList.delegate = self;
    [classList getClassList:login.userID];
    
}

/**
 * Method name: getUnitList:
 * Description: This method for creating model to call GetUnitList API
 * Parameters: classIDSelected
 */

- (void)getUnitList:(NSString *)classIDSelected
{
    // Create model for calling API
    unitList = [[UnitList alloc]init];
    [UnitList sharedInstance];
    unitList.delegate = self;
    [unitList getUnitList:login.userID :classIDSelected];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === ClassList Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: classListFinished
 * Description: Sent from ClassList when NetConnection has finished loading successfully.
 * Parameters: -
 */

- (void)classListFinished{
    
    classListArray = classList.userClassList;
    isAlreadyGetClassList = YES;
    [classTableView reloadData];
   
    // Check class has one calss
    if (classList.isUserHasOnlyOneClass) {
        
        isUserHasOnlyOneClass = YES;
        classTitle = [[classListArray objectAtIndex:0]objectForKey:@"ClassTitle"];
        [self animationUnitTableView];
        [self getUnitList:[[classListArray objectAtIndex:0]objectForKey:@"ClassID"]];
        
    }
}


/**
 * Method name: classListDidFailWithError:
 * Description: Sent from ClassList when NetConnection fails to load successfully.
 * Parameters: -
 */

- (void)classListDidFailWithError{
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *messgage = classList.errorMessage;
    UIAlertView *classListErrorAlertView = [[UIAlertView alloc]initWithTitle:configManager.errorMessage
                                                                     message:messgage
                                                                    delegate:self
                                                           cancelButtonTitle:@"Done"
                                                           otherButtonTitles:nil];
    [classListErrorAlertView show];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === UnitList Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * Method name: unitListFinished
 * Description: Sent from UnitList when NetConnection has finished loading successfully.
 * Parameters: -
 */

- (void)unitListFinished{
    
    unitListArray = unitList.userUnitList;
    
    // Reload data in unitTableView
    [unitTableView reloadData];
    
}


/**
 * Method name: unitListDidFailWithError:
 * Description: Sent from UnitList when NetConnection fails to load successfully.
 * Parameters: -
 */

- (void)unitListDidFailWithError{
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *messgage = unitList.errorMessage;
    
    // Show alertView with message
    UIAlertView *unitListErrorAlertView = [[UIAlertView alloc]initWithTitle:configManager.errorMessage
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
    
    if (tableView == classTableView){
        
        return @"Class List";
        
    }else{
        
        return @"Unit List";
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
    tempView.backgroundColor = uiThemeManager.headerSectionBGColor;
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,0,300,30)];
    tempLabel.backgroundColor = uiThemeManager.labelBGColor;
    tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = uiThemeManager.headerSectionTextColor;
    tempLabel.font = uiThemeManager.cellTextFontSize;
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
    return 30.0;
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
    
    if (tableView == classTableView) {
        
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
    if (tableView == classTableView) {
        
        // Set text of label (ClassTitle)
        cell.textLabel.text = [[classListArray objectAtIndex:indexPath.row]
                                                      objectForKey:@"ClassTitle"];
    
    }else if (tableView == unitTableView){
  
        // Set text of label (UnitTitle)
        cell.textLabel.text = [[unitListArray objectAtIndex:indexPath.row]
                                                      objectForKey:@"UnitTitle"];
    }
    
    // Set font, background color of label
    cell.textLabel.font = uiThemeManager.cellTextFontSize;
    cell.textLabel.textColor = uiThemeManager.cellTextColor;
    cell.textLabel.backgroundColor = uiThemeManager.labelBGColor;
    
    // Set content view background
    cell.contentView.backgroundColor = uiThemeManager.cellBGColor;
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:uiThemeManager.cellSelectedBGColor];
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
    if (tableView == classTableView) {

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
#pragma mark === Animated TableView ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: animationUnitTableView
 * Description: For presenting unitTableView
 * Parameters: -
 */

- (void) animationUnitTableView{

    // Set origin of unitTableView and add to view
    /*unitTableView.frame = CGRectMake(1024, 0, unitTableView.bounds.size.width, unitTableView.bounds.size.height);
    unitTableView.layer.shadowOpacity = 0.75f;
    unitTableView.layer.shadowRadius  = 10.0f;
    unitTableView.layer.shadowColor   = [UIColor blackColor].CGColor;
    [self.view addSubview:unitTableView];*/
    
    unitTableViewBG.frame = CGRectMake(1024, 0, unitTableViewBG.bounds.size.width, unitTableViewBG.bounds.size.height);
    unitTableViewBG.layer.shadowOpacity = 0.75f;
    unitTableViewBG.layer.shadowRadius  = 10.0f;
    unitTableViewBG.layer.shadowColor   = uiThemeManager.shadowColor.CGColor;
    [self.view addSubview:unitTableViewBG];
    
    // Animated unitTableview
    [UIView animateWithDuration:0.5
                     animations:^{
                         unitTableViewBG.frame = CGRectMake(0, 0, unitTableViewBG.bounds.size.width, unitTableViewBG.bounds.size.height);}];
    
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Swipe Gesture Handle ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Method name: handleSwipe
 * Description: For handle with swipe gesture
 * Parameters: -
 */

- (IBAction)handleSwipe
{
    if (!isUserHasOnlyOneClass) {
        classTitle = @"";
        
        // Deselect row in classTableview
        [classTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        // Animated unitTableview
        [UIView animateWithDuration:0.5
                         animations:^{
                             unitTableViewBG.frame = CGRectMake(1024, 0,unitTableViewBG.bounds.size.width, unitTableViewBG.bounds.size.height);}];
        unitListArray = [[NSArray alloc]init];
        [unitTableView reloadData];

    }
}


@end
