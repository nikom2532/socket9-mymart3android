//
//  ClassListViewController.h
//  MyMart
//
//  Created by Komsan Noipitak on 3/26/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "ResultEntryViewController.h"
#import "CocoaSecurity.h"
#import "NSData+Base64Converter.h"
#import "NSString+HexToByteConverter.h"
#import "ClassList.h"
#import "UnitList.h"
#import "Login.h"


@interface ClassListViewController : UITableViewController {
    
    NSString *classTitle;
    NSIndexPath *selectedIndexPath;
    NSArray *classListArray;
    NSArray *unitListArray;
    BOOL selectedUnit;
    BOOL isAlreadyGetClassList;
    BOOL isUserHasOnlyOneClass;
    
    IBOutlet UITableView *unitTableView;
    
}

@property (nonatomic, assign) BOOL selectedUnit;


@end
