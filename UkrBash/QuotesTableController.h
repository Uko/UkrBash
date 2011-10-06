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
    NSMutableArray *_tableData;
    QuoteViewController *_quoteViewController;
}

@property (nonatomic, retain) IBOutlet UITableView *quotesTable;
@property (nonatomic, retain) NSMutableArray *tableData;
@property (nonatomic, retain) QuoteViewController *quoteViewController;

@end
