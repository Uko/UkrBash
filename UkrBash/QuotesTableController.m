//
//  QuotesTableController.m
//  UkrBash
//
//  Created by Юрко Тимчук on 02.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuotesTableController.h"
#import "QuoteViewController.h"
#import "UkrBashAppDelegate.h"
#include <RestKit/RestKit.h>
#include "Quote.h"

@implementation QuotesTableController

@synthesize quotesTable = _quotesTable;
@synthesize quoteViewController = _quoteViewController;
@synthesize restKitManager = _restKitManager;
@synthesize segmentedControl = _segmentedControl;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark RKObjectLoaderDelegate methods

- (void)loadQuotes {
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            [_restKitManager loadObjectsAtResourcePath:@"quotes.getUpcoming.json?client=6999312d8ef26bc9" delegate:self];
            break;
        case 1:
            [_restKitManager loadObjectsAtResourcePath:@"quotes.getPublished.json?client=6999312d8ef26bc9" delegate:self];
            break;
        case 2:
            [_restKitManager loadObjectsAtResourcePath:@"quotes.getTheBest.json?client=6999312d8ef26bc9" delegate:self];
    }
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    /*for (Quote* i in objects) {
        NSLog(@"ID: %@; Text: %@; Author: %@", i.id, i.text, i.author);
    }*/
    _publishedData = [[NSMutableArray alloc] initWithArray: objects];
    [_quotesTable reloadData];
    //NSLog(@"Load collection of Articles: %@", objects);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Error:%@",error);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _quoteViewController.navigationItem.hidesBackButton = NO;
    _restKitManager = [RKObjectManager objectManagerWithBaseURL:@"http://api.ukrbash.org/1/"];
    // Enable automatic network activity indicator management
    _restKitManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    RKObjectMapping* quoteMapping = [RKObjectMapping mappingForClass:[Quote class]];
    [quoteMapping mapKeyPath:@"id" toAttribute:@"id"];
    [quoteMapping mapKeyPath:@"text" toAttribute:@"text"];
    [quoteMapping mapKeyPath:@"author" toAttribute:@"author"];
    
    [_restKitManager.mappingProvider setMapping:quoteMapping forKeyPath:@""];
    //NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"one", @"two", nil];
    //_tableData = [[NSMutableArray alloc] initWithObjects:@"one", @"two", nil];
    [self loadQuotes];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_quotesTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%i rows",[_publishedData count]);
    return [_publishedData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    //cell.textLabel.text=[_tableData objectAtIndex:[indexPath row]]; }
    cell.detailTextLabel.text=[(Quote *)[_publishedData objectAtIndex:[indexPath row]] author];
    cell.textLabel.text = [(Quote *)[_publishedData objectAtIndex:[indexPath row]] text];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSInteger row = [indexPath row];
    Quote *quote = [_publishedData objectAtIndex:row];
    _quoteViewController.title = [NSString stringWithFormat:@"%@",quote.author];
    [self.navigationController pushViewController:_quoteViewController animated:YES];
    _quoteViewController.author.text = quote.author;
    _quoteViewController.quote.text = quote.text;
}

- (IBAction)reload
{
    [self loadQuotes];
}

- (IBAction)changePage:(id)sender
{
    self.navigationItem.title = [_segmentedControl titleForSegmentAtIndex:_segmentedControl.selectedSegmentIndex];
    [self loadQuotes];
}

- (void) dealloc
{
    [_restKitManager release];
    [_quotesTable release];
    [_publishedData release];
    [_quoteViewController release];
    [super dealloc];
}

@end
