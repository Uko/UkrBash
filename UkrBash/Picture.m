//
//  Picture.m
//  UkrBash
//
//  Created by Юрко Тимчук on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Picture.h"

@implementation Picture

@synthesize id = _id;
@synthesize author = _author;
@synthesize title = _title;
@synthesize thumbnail = _thumbnail;
@synthesize image = _image;

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
    [_title release];
    [_author release];
    [_thumbnail release];
    [_image release];
    
    [super dealloc];
}

@end
