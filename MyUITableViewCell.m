//
//  MyUITableViewCell.m
//  Images Sharer
//
//  Created by Fabio L Brandao FH on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyUITableViewCell.h"

#define MAINLABEL_TAG 1
#define THUMB_TAG 3
#define SECONDLABEL_TAG 2

@implementation MyUITableViewCell
@synthesize mainLabel;
@synthesize secondLabel;
@synthesize img;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *myContentView = self.contentView;
        
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 15.0, 200.0, 25.0)];
        mainLabel.tag = MAINLABEL_TAG;
        mainLabel.font = [UIFont systemFontOfSize:14.0];
        mainLabel.textAlignment = UITextAlignmentLeft;
        mainLabel.textColor = [UIColor blackColor];
        [myContentView addSubview:mainLabel];
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0, 40.0, 200.0, 20.0)];
        secondLabel.tag = SECONDLABEL_TAG;
        secondLabel.font = [UIFont systemFontOfSize:12.0];
        secondLabel.textAlignment = UITextAlignmentLeft;
        secondLabel.textColor = [UIColor darkGrayColor];
        [myContentView addSubview:secondLabel];
        
        thumb = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 70, 70)];
        thumb.tag = THUMB_TAG;
        [myContentView addSubview:thumb];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma 
#pragma mark - other methods

- (void)setData:(VOSearch *)vOSearch{
    self.mainLabel.text = vOSearch.name;
    self.secondLabel.text = vOSearch.font;

    img = [[UIImage alloc] initWithData:vOSearch.image];
    thumb.image = img;
}

@end
