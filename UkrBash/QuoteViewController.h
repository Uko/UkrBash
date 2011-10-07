//
//  QuoteViewController.h
//  UkrBash
//
//  Created by Юрко Тимчук on 02.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *author;
@property (nonatomic, retain) IBOutlet UITextView *quote;

@end