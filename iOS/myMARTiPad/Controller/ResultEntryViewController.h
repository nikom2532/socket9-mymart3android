//
//  ResultEntryViewController.h
//  MyMart
//
//  Created by Komsan Noipitak on 3/22/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "StyledPullableView.h"
#import "ClassListViewController.h"
#import "EWMultiColumnTableView.h"

@interface ResultEntryViewController : UIViewController <PullableViewDelegate, EWMultiColumnTableViewDataSource> {
    
    UISplitViewController   *classListViewController;
    PullableView            *commentView;
    EWMultiColumnTableView  *tblView;
    
    NSMutableArray          *data;
    NSMutableArray          *sectionHeaderData;
    
    CGFloat     colWidth;
    NSInteger   numberOfSections;
    NSInteger   numberOfColumns;
    
    NSString *unitTitle;
    IBOutlet UILabel *unitTitleLabel;
    
}

@property (retain, nonatomic)NSString *unitTitle;

- (IBAction)revealMenu:(id)sender;

@end
