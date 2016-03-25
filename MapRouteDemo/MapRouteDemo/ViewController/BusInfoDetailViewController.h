//
//  BusInfoDetailViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 16/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusInfoDetailViewController : UIViewController<GMSMapViewDelegate,NSXMLParserDelegate>
{
    NSString *longtidude;
     NSString *latidude;
    NSString *station_name;
}
@property (nonatomic, retain) GMSMapView *mapview;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                  lat:(NSString*)latstring
                  lng:(NSString*)lngstring
                title:(NSString*)titlestring;
@end
