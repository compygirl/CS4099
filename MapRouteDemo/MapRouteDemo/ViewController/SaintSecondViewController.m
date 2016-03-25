//
//  SaintSecondViewController.h
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 02/01/2014.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//

#import "SaintSecondViewController.h"
#import "BusInfoDetailViewController.h"
@interface SaintSecondViewController ()
{
    int numbre_list;
    NSArray *listArray;
    NSArray *lngArray;
    NSArray *latArray;
}
@property(nonatomic, copy) NSArray *filteredPersons;
@property(nonatomic, copy) NSString *currentSearchString;
@property(nonatomic, copy) NSArray *famousPersons;
@end

@implementation SaintSecondViewController

@synthesize  searchBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"LIST of STOPS", @"LIST of STOPS");//title of the page
     
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bus_All_stop_list" ofType:@"txt"];
    
    //SEARCH BAR:
    NSError *error;
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search";
    [searchBar sizeToFit];
    
    //seashing process
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;

    
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];//all bus stops
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    listArray = [fileContents componentsSeparatedByString:@"\n"];//array of all bus stops
    _famousPersons = listArray;
    numbre_list = [listArray count];//number of all bus stops
    tblPositionTable.tableHeaderView = searchBar;//placing the search bar above the table
    
    NSString *latpath = [[NSBundle mainBundle] pathForResource:@"bus_All_latitude" ofType:@"txt"];
    fileContents = [NSString stringWithContentsOfFile:latpath encoding:NSUTF8StringEncoding error:&error];//all bus stops' latitudes
    latArray = [fileContents componentsSeparatedByString:@"\n"];
    
    
    NSString *lngpath = [[NSBundle mainBundle] pathForResource:@"bus_All_longitude" ofType:@"txt"];
    fileContents = [NSString stringWithContentsOfFile:lngpath encoding:NSUTF8StringEncoding error:&error];//all bus stops' longitudes
    lngArray = [fileContents componentsSeparatedByString:@"\n"];


}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//table view representation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
     if (tableView == tblPositionTable)
     {
         return numbre_list;//109 items
     } else {
         return self.filteredPersons.count;
     }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    
    static NSString *MyIdentifier = @"MyIdentifier";
	MyIdentifier = @"tblCellView";
    CellView *cell_view= (CellView *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if(cell_view == nil)
    {
		//cell_view = [[CellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
       [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
		cell_view = tblCell;
	}
    
    if (tableView == tblPositionTable) {
        cell_view.bus_station_name.text = [listArray objectAtIndex:indexPath.row];
         NSLog(@"TEXT %@", cell_view.bus_station_name.text);
    } else {
        cell_view.bus_station_name.text = [self.filteredPersons objectAtIndex:indexPath.row];
    }

     return cell_view;
}


//detect which object were chosen and that bus top' name is displayed as a title of the page with map, however, the implementation of the map is not here. 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!search_flag) {
      
        BusInfoDetailViewController * info = [[BusInfoDetailViewController alloc]initWithNibName:@"BusInfoDetailViewController" bundle:nil lat:[latArray objectAtIndex:indexPath.row] lng:[lngArray objectAtIndex:indexPath.row] title:[listArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:info animated:YES];
    }
    else
    {
        NSString *cellText =[self.filteredPersons objectAtIndex:indexPath.row];
        NSUInteger indexOfTheObject = [listArray indexOfObject: cellText];
        BusInfoDetailViewController * info = [[BusInfoDetailViewController alloc]initWithNibName:@"BusInfoDetailViewController" bundle:nil lat:[latArray objectAtIndex:indexOfTheObject] lng:[lngArray objectAtIndex:indexOfTheObject] title:[listArray objectAtIndex:indexOfTheObject]];
        [self.navigationController pushViewController:info animated:YES];

        
    }
}



- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.filteredPersons = nil;
    self.currentSearchString = @"";
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredPersons = nil;
    self.currentSearchString = nil;
    search_flag = false;
}

//This method deals with searching the word and displaying only the matched words
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length > 0) { // Should always be the case
        NSArray *personsToSearch = self.famousPersons;
        if (self.currentSearchString.length > 0 && [searchString rangeOfString:self.currentSearchString].location == 0) { // If the new search string starts with the last search string, reuse the already filtered array so searching is faster
            personsToSearch = self.filteredPersons;//all words with matched letters
            search_flag = true;
        }
        
        self.filteredPersons = [personsToSearch filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString]];
    } else {
        self.filteredPersons = self.famousPersons;
    }
    
    self.currentSearchString = searchString;
    
    return YES;
}


@end
