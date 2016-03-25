//
//  SaintFirstViewController.m
//  ViewController
//
//  Created by Aigerim Yessenbayeva on 23/12/2013.
//  Copyright (c) 2014 Aigerim Yessenbayeva. All rights reserved.
//


#import "SaintFirstViewController.h"
#import "AppDelegate.h"
#import "KMLViewerViewController.h"

@interface SaintFirstViewController ()

@end

@implementation SaintFirstViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"BUS LIST", @"BUS LIST");   //title text of the page
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }

    
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bus_list" ofType:@"txt"];   //file path
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];//contains buses' numbers
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    //for debugging...
    NSLog(@"contents: %@", fileContents);
    
    NSArray *listArray = [fileContents componentsSeparatedByString:@"\n"];       //array of the buses' names: 99A, 99B, 99C, 99D
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;            //used to set a standard type
    return cell;
    
}

//DETECTS WHICH ROW WAS SELECTED, I.E. WHICH BUS WAS SELECTED
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"Value %i", indexPath.row);
    KMLViewerViewController *kmlviewcontroller =  [[KMLViewerViewController alloc]initWithNibName:@"KMLViewerViewController" bundle:nil busnumber:(indexPath.row+1)];
    [self.navigationController pushViewController:kmlviewcontroller animated:YES];
}
@end
