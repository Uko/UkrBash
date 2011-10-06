//
//  Quote.h
//  UkrBash
//
//  Created by Юрко Тимчук on 06.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject
{
    NSNumber* _id;
    NSString* _text;
    NSString* _author;
}

@property (nonatomic,retain) NSNumber* id;
@property (nonatomic,retain) NSString* text;
@property (nonatomic,retain) NSString* author;

@end
