//
//  MyAnnotation.h
//  ViewComtroller
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    
}

// if you implement VPPMapCustomAnnotation you can customize the annotation
// as much as you want.

// pin's coordinates (only required property)
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
// pin's title
@property (nonatomic, copy) NSString *title;
// pin's subtitle
@property (nonatomic, copy) NSString *subtitle;


@end
