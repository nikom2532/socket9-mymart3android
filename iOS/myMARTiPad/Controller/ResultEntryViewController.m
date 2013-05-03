//
//  ResultEntryViewController.m
//  MyMart
//
//  Created by Komsan Noipitak on 3/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "ResultEntryViewController.h"
#import "NSObject+DelayedBlock.h"

#define ROWS 100

@interface ResultEntryViewController ()

@end

@implementation ResultEntryViewController
@synthesize unitTitle;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self setTableview];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self setCommentView];

}

- (void)setTableview{
    
    unitTitleLabel.text = unitTitle;
    
    numberOfColumns     = 16;
    numberOfSections    = 1;
    
    int sectionDistro[] = {20};
    colWidth = 70.0f;
    
    data = [[NSMutableArray alloc] initWithCapacity:numberOfSections * 5];
    sectionHeaderData = [[NSMutableArray alloc] initWithCapacity:numberOfSections];
    
    for (int i = 0; i < numberOfSections; i++) {
        
        int rows = sectionDistro[i];
        NSMutableArray *a = [NSMutableArray arrayWithCapacity:numberOfColumns];
        for (int j = 0; j < numberOfColumns; j++) {
            
            int d = rand() % 100;
            
            NSMutableString *text = [NSMutableString stringWithFormat:@"S %d C %d", i, j];
            if (d < 66) {
                [text appendFormat:@"\nsecond line"];
            }
            
            if (d < 33) {
                [text appendFormat:@"\nthird line"];
            }
            
            
            [a addObject:text];
        }
        [sectionHeaderData addObject:a];
        
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:10];
        for (int k = 0; k < rows; k++) {
            
            NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:numberOfColumns];
            for (int j = 0; j < numberOfColumns; j++) {
                int d = rand() % 100;
                
                NSMutableString *text = [NSMutableString stringWithFormat:@"(%d, %d, %d)", i, k, j];
                if (d < 66) {
                    [text appendFormat:@"\nsecond line"];
                }
                
                if (d < 33) {
                    [text appendFormat:@"\nthird line"];
                }
                
                [rowArray addObject:text];
            }
            
            [sectionArray addObject:rowArray];
        }
        
        [data addObject:sectionArray];
    }
    
    
    tblView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectMake(5, 92, 1010, 650)];
    tblView.sectionHeaderEnabled = YES;
    tblView.dataSource = self;
    tblView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tblView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === Set CommentView ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)setCommentView
{
    
    commentView = [[PullableView alloc] initWithFrame:CGRectMake(100, 200, 700, 664)];
    commentView.backgroundColor = [UIColor colorWithRed:242.0/255.0
                                                  green:248.0/255.0
                                                   blue:163.0/255.0
                                                  alpha:1.0];
    
    commentView.openedCenter = CGPointMake(800, 423);
    commentView.closedCenter = CGPointMake (1350, 423);
    commentView.center = commentView.closedCenter;
    commentView.delegate = self;
    commentView.animate = YES;
    
    commentView.handleView.backgroundColor = [UIColor blackColor];
    commentView.handleView.frame = CGRectMake(0, 0, 30, 664);
    
    [self.view addSubview:commentView];
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark === PullableView Delegate ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened) {
        commentView.layer.shadowOpacity = 0.75f;
        commentView.layer.shadowRadius = 10.0f;
        commentView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        [self.view removeGestureRecognizer:self.slidingViewController.panGesture];
        
    } else {
        commentView.layer.shadowOpacity = 0.0f;
        commentView.layer.shadowRadius = 0.0f;
        commentView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    }
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark - === EWMultiColumnTableView DataSource ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return numberOfSections;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, colWidth, 40.0f)];
    l.numberOfLines = 0;
    l.lineBreakMode = UILineBreakModeWordWrap;
    
    return l;
}


- (void)tableView:(EWMultiColumnTableView *)tableView setContentForCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath column:(NSInteger)col{
    UILabel *l = (UILabel *)cell;
    //l.text = @"A";//[[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:col];
    
    CGRect f = l.frame;
    f.size.width = [self tableView:tableView widthForColumn:colWidth];
    l.frame = f;
    l.text = @"       ";
    //[l sizeToFit];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    //NSString *str = [[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:col];
    //CGSize s = [str sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
     //          constrainedToSize:CGSizeMake([self tableView:tableView widthForColumn:col], MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return 40.0f;//s.height+ 20.0f;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    return colWidth;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[data objectAtIndex:section] count];
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView sectionHeaderCellForSection:(NSInteger)section column:(NSInteger)col
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self tableView:tableView widthForColumn:col], 40.0f)];
    l.backgroundColor = [UIColor yellowColor];
    return l;
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForSectionHeaderCell:(UIView *)cell section:(NSInteger)section column:(NSInteger)col
{
    UILabel *l = (UILabel *)cell;
    l.text = @"A";//[NSString stringWithFormat:@"S %d C %d", section, col];
    
    CGRect f = l.frame;
    f.size.width = [self tableView:tableView widthForColumn:col];
    l.frame = f;
    
    [l sizeToFit];
}

- (NSInteger)numberOfColumnsInTableView:(EWMultiColumnTableView *)tableView
{
    return numberOfColumns;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark === Header Cell ===
#pragma mark -

////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellForIndexPath:(NSIndexPath *)indexPath
{
    return [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForHeaderCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *l = (UILabel *)cell;
    l.backgroundColor = [UIColor clearColor];
    l.text = [NSString stringWithFormat:@"  Student%d",indexPath.row+1];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForHeaderCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

/*- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForSectionHeaderCellAtSection:(NSInteger)section column:(NSInteger)col
{
    return 50.0f;
}*/

- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellInSectionHeaderForSection:(NSInteger)section
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self widthForHeaderCellOfTableView:tableView], 30.0f)];
    l.backgroundColor = [UIColor orangeColor];
    return l;
    
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForHeaderCellInSectionHeader:(UIView *)cell AtSection:(NSInteger)section
{
    UILabel *l = (UILabel *)cell;
    l.text = [NSString stringWithFormat:@"Section %d", section];
}

- (CGFloat)widthForHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    return 200.0f;
}


- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellForColumn:(NSInteger)col
{
    UILabel *l =  [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, [self heightForHeaderCellOfTableView:tableView])];
    l.backgroundColor = [UIColor lightGrayColor];
    l.text = [NSString stringWithFormat:@"   C%d", col+1];
    l.userInteractionEnabled = YES;
    l.tag = col;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    recognizer.numberOfTapsRequired = 2;
    [l addGestureRecognizer:recognizer];
    
    return l;
}

- (UIView *)topleftHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    UILabel *l =  [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, [self heightForHeaderCellOfTableView:tableView])];
    l.backgroundColor = [UIColor lightGrayColor];
    l.text = @"  Students";
    
    return l;
}

- (CGFloat)heightForHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    return 50.0f;
}

- (void)tableView:(EWMultiColumnTableView *)tableView swapDataOfColumn:(NSInteger)col1 andColumn:(NSInteger)col2
{
    for (int i = 0; i < [self numberOfSectionsInTableView:tableView]; i++) {
        NSMutableArray *section = [data objectAtIndex:i];
        for (int j = 0; j < [self tableView:tableView numberOfRowsInSection:i]; j++) {
            NSMutableArray *a = [section objectAtIndex:j];
            id tmp = [a objectAtIndex:col2];
            
            [a replaceObjectAtIndex:col2 withObject:[a objectAtIndex:col1]];
            [a replaceObjectAtIndex:col1 withObject:tmp];

        }
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    int col = [recognizer.view tag];
    for (NSMutableArray *array in sectionHeaderData) {
        [array removeObjectAtIndex:col];
        //        [array addObject:@""];
    }
    
    for (NSMutableArray *section in data) {
        for (NSMutableArray *row in section) {
            [row removeObjectAtIndex:col];
            //            [row addObject:@""];
        }
    }
    
    numberOfColumns--;
    
    [tblView reloadData];
    
}









@end
