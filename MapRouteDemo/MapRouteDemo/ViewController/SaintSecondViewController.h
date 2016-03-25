//
//  SaintSecondViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SaintViewController.h"
#import "CellView.h"
@interface SaintSecondViewController : SaintViewController<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    IBOutlet UITableView *tblPositionTable;    //tableview
    IBOutlet CellView *tblCell;             //customcell
    UISearchBar *searchBar;               //search bar
    BOOL search_flag;                      //search flag

}
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;

@end
