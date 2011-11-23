//
//  MyUITableViewCell.h
//  Images Sharer
//
//  Created by Fabio L Brandao FH on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VOSearch.h"

@interface MyUITableViewCell : UITableViewCell{
    UILabel *mainLabel;
    UILabel *secondLabel;
    
    UIImageView *thumb;
    
    UIImage *img;
}

@property(nonatomic, retain) UILabel *mainLabel;
@property(nonatomic, retain) UILabel *secondLabel;
@property(nonatomic, retain) UIImage *img;

- (void) setData:(VOSearch *)vOSearch;

@end
