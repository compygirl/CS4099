//
//  SaintFirstViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 23/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaintViewController.h"
#import "CellView.h"
@interface SaintFirstViewController : SaintViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tblPositionTable;     //table view
   
 //   IBOutlet CellView *tblCell;

}
@end
