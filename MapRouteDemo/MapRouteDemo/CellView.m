//
//  CellView.m
//  ViewComtroller
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import "CellView.h"

@implementation CellView

@synthesize bus_station_name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bus_station_name = [[UILabel alloc] init];
//        bus_station_name.text = @"cell";
    }
    return self;
}

- (void)setLabelText:(NSString *)_text{
    
	bus_station_name.text = _text;
    NSLog(@"%@",bus_station_name.text);
    NSLog(@"%@",_text);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
