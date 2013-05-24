/*
 * Copyright (c) 2011 Eli Wang
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

//////////////////////////////////////// OBJECTIVE ///////////////////////////////////////////////////////
/**
 * Base on the UITableView containing only one column, this project implements a multi-column table view for
 * iOS. It has a horizontal scrollable table body, a fixed left and top table header. It also supports
 * foldable sections, and draggable columns.
 *
 * Using in UnitResultEntryViewController for creating multicolumn tableview
 */
/////////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@class EWMultiColumnTableView;


@interface EWMultiColumnTableViewBGScrollView : UIScrollView {
    NSMutableArray *lines;
}

@property (nonatomic, assign) EWMultiColumnTableView *parent;

// This method will draw the vertical lines. It adds UIViews as lines ABOVE all views. call it after the table reloads
// to make sure the lines visible
- (void)redraw;

@end
