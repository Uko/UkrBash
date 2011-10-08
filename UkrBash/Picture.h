//
//  Picture.h
//  UkrBash
//
//  Created by Юрко Тимчук on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject
{
    NSNumber* _id;
    NSString* _title;
    NSString* _author;
    NSURL * _thumbnail;
    NSURL * _image;
}

@property (nonatomic,retain) NSNumber* id;
@property (nonatomic,retain) NSString* author;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSURL* thumbnail;
@property (nonatomic,retain) NSURL* image;

@end