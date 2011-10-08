//
//  PicturesTableController.h
//  UkrBash
//
//  Created by Юрко Тимчук on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
@class PictureViewController;

@interface PicturesTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate>
{
    NSMutableArray * _tableData;
    RKObjectManager *_restKitManager;
}

@property (nonatomic, retain) NSMutableArray * tableData;
@property (nonatomic, retain) RKObjectManager *restKitManager;
@property (nonatomic, retain) IBOutlet UITableView * picturesTable;
@property (nonatomic, retain) IBOutlet PictureViewController * pictureViewController;

- (IBAction) reload;

@end
