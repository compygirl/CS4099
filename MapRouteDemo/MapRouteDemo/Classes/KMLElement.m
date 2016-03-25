#import "KMLElement.h"

// Begin the implementations of KMLElement and subclasses.  These objects
// act as state machines during parsing time and then once the document is
// fully parsed they act as an object graph for describing the placemarks and
// styles that have been parsed.
@implementation KMLElement
- (id) initWithIdentifier:(NSString *) identifier {
    if ((self = [super init])) {
        _identifier = [identifier copy];
    }

    return self;
}


#pragma mark -

- (BOOL) canAddString {
    return NO;
}

- (void) addString:(NSString *) string {
    if ([self canAddString]) {
        if (!_accumulated)
            _accumulated = [[NSMutableString alloc] init];
        [_accumulated appendString:string];
    }
}

- (void) clearString {
    _accumulated = nil;
}
@end
