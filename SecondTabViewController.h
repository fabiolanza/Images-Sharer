//
//  SecondTabViewController.h
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSGoogleImagesAPI.h"
#import "VOSearch.h"
#import "VOSearchFavorite.h"
#import "iAd/iAd.h"

@interface SecondTabViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>{
    
    __weak IBOutlet ADBannerView *adView;
    __weak IBOutlet UILabel *rateUsOnAppStore;
    
    NSArray *listData;
    NSMutableArray *imagesArray;
    NSMutableArray *uRLFonts;
    NSMutableArray *uRLNames;
    NSMutableArray *vOSearchArray;
    
    IBOutlet UIButton *busca;
    IBOutlet UITextField *palavraChave;
    IBOutlet UITableView *myTableView;
    IBOutlet UIImageView *thumb;
    IBOutlet UIActivityIndicatorView *waiting;
    
    WSGoogleImagesAPI *_googleAPI;
    
    NSMutableArray *_vOSearchArray;
    NSMutableArray *_vOSearchFavoriteArray;

}

@property (nonatomic, retain) NSArray *vOSearchFavoriteArray;

- (IBAction)getImagesInfo:(id)sender;
- (IBAction)keyboardReturn:(id)sender;
- (IBAction)keyboardReturnAfterPushingSearchButton:(id)sender;

@end
