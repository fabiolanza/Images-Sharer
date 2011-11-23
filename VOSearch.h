//
//  VOSearch.h
//  Images Sharer
//
//  Created by Fabio L Brandao FH on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOSearch : NSObject{
    NSString *name;
    NSString *uRL;
    NSString *font;
    NSMutableData *image;
    BOOL *isFavorite;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *uRL;
@property(nonatomic, retain) NSString *font;
@property(nonatomic, retain) NSMutableData *image;
@property(nonatomic, assign) BOOL *isFavorite;

@end
