#import <MapKit/MapKit.h>

@class KMLPlacemark;
@class KMLStyle;

@interface KMLParser : NSObject <NSXMLParserDelegate> {
@private
    NSMutableDictionary *_styles;
    NSMutableArray *_placemarks;
    
    KMLPlacemark *_placemark;
    KMLStyle *_style;
    
    NSXMLParser *_xmlParser;
}

- (id) initWithURL:(NSURL *) url;

@property (weak, nonatomic, readonly) NSArray *overlays;
@property (weak, nonatomic, readonly) NSArray *points;
@property (weak, nonatomic, readonly) NSArray *coordinates;

- (void) parseKML;

- (MKAnnotationView *) viewForAnnotation:(id <MKAnnotation>) point;
- (MKOverlayView *) viewForOverlay:(id <MKOverlay>) overlay;
@end
