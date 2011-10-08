//
//  PicturesTableController.m
//  UkrBash
//
//  Created by Юрко Тимчук on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PicturesTableController.h"
#import "Picture.h"
#import "PictureViewController.h"

@implementation PicturesTableController

@synthesize picturesTable = _picturesTable;
@synthesize tableData = _tableData;
@synthesize restKitManager = _restKitManager;
@synthesize pictureViewController = _pictureViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    [_restKitManager loadObjectsAtResourcePath:@"pictures.getPublished.json?client=6999312d8ef26bc9" delegate:self];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    /*for (Quote* i in objects) {
     NSLog(@"ID: %@; Text: %@; Author: %@", i.id, i.text, i.author);
     }*/
    _tableData = [[NSMutableArray alloc] initWithArray: objects];
    [_picturesTable reloadData];
    //NSLog(@"Load collection of Articles: %@", objects);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Error:%@",error);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    _restKitManager = [[RKObjectManager objectManagerWithBaseURL:@"http://api.ukrbash.org/1/"] retain];
    // Enable automatic network activity indicator management
    _restKitManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    RKObjectMapping* quoteMapping = [RKObjectMapping mappingForClass:[Picture class]];
    [quoteMapping mapKeyPath:@"id" toAttribute:@"id"];
    [quoteMapping mapKeyPath:@"title" toAttribute:@"title"];
    [quoteMapping mapKeyPath:@"author" toAttribute:@"author"];
    [quoteMapping mapKeyPath:@"thumbnail" toAttribute:@"thumbnail"];
    [quoteMapping mapKeyPath:@"image" toAttribute:@"image"];
    
    [_restKitManager.mappingProvider setMapping:quoteMapping forKeyPath:@""];
    
    [self loadQuotes];
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
    NSLog(@"%i rows",[_tableData count]);
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.detailTextLabel.text=[(Picture *)[_tableData objectAtIndex:[indexPath row]] author];
    cell.textLabel.text = [(Picture *)[_tableData objectAtIndex:[indexPath row]] title];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[(Picture *)[_tableData objectAtIndex:[indexPath row]] thumbnail]]];
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
    Picture *picture = [_tableData objectAtIndex:row];
    _pictureViewController.title = [NSString stringWithFormat:@"%@",picture.title];
    [self.navigationController pushViewController:_pictureViewController animated:YES];
    _pictureViewController.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picture.image]]; 
}

-(IBAction)reload
{
    [self loadQuotes];
}

@end
