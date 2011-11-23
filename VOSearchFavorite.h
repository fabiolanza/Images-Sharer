//
//  VOSearchFavorite.h
//  Images Sharer
//
//  Created by Fabio L Brandao FH on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VOSearchFavorite : NSObject{
    NSData *imageData;
    NSString *imageName;
    NSString *imageSite;
    NSString *imageURL;
    int rowAtTableViewCell;
}

@property (nonatomic, retain) NSData *imageData;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) NSString *imageSite;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, assign) int rowAtTableViewCell;

@end
