// KMLElement and subclasses declared here implement a class hierarchy for
// storing a KML document structure.  The actual KML file is parsed with a SAX
// parser and only the relevant document structure is retained in the object
// graph produced by the parser.  Data parsed is also transformed into
// appropriate UIKit and MapKit classes as necessary.

// Abstract KMLElement type.  Handles storing an element identifier (id="...")
// as well as a buffer for accumulating character data parsed from the xml.
// In general, subclasses should have beginElement and endElement classes for
// keeping track of parsing state.  The parser will call beginElement when
// an interesting element is encountered, then all character data found in the
// element will be stored into accum, and then when endElement is called accum
// will be parsed according to the conventions for that particular element type
// in order to save the data from the element.  Finally, clearString will be
// called to reset the character data accumulator.

@interface KMLElement : NSObject {
@private
	NSString *_identifier;
    NSMutableString *_accumulated;
}

- (id) initWithIdentifier:(NSString *) ident;

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *accumulated;

// Returns YES if we're currently parsing an element that has character data contents that we are interested in saving.
- (BOOL) canAddString;

// Add character data parsed from the xml
- (void) addString:(NSString *) str;

// Once the character data for an element has been parsed, use clearString to
// reset the character buffer to get ready to parse another element.
- (void) clearString;
@end
