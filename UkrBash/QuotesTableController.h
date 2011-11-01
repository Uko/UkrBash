//
//  QuotesTableController.h
//  UkrBash
//
//  Created by Юрко Тимчук on 02.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
@class QuoteViewController;

@interface QuotesTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate>
{
    NSMutableArray *_publishedData;
    NSMutableArray *_notpublishedData;
    NSMutableArray *_bestData;
    RKObjectManager *_restKitManager;
}

@property (nonatomic, retain) IBOutlet UITableView *quotesTable;
@property (nonatomic, retain) IBOutlet QuoteViewController *quoteViewController;
@property (nonatomic, retain) RKObjectManager *restKitManager;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction) reload;
- (IBAction) changePage:(id)sender;

@end
