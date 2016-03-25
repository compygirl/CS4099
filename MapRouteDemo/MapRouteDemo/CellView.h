//
//  CellView.h
//  ViewComtroller
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellView : UITableViewCell
{
    IBOutlet UILabel *bus_station_name;
}
@property (nonatomic,retain) UILabel *bus_station_name;
@end
