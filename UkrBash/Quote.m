//
//  Quote.m
//  UkrBash
//
//  Created by Юрко Тимчук on 06.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quote.h"

@implementation Quote

@synthesize id = _id;
@synthesize text = _text;
@synthesize author = _author;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [_id release];
    [_text release];
    [_author release];
    
    [super dealloc];
}

@end
