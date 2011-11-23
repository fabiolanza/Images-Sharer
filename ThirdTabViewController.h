//
//  ThirdTabViewController.h
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "VOSearchFavorite.h"
#import "FBConnect.h"

@interface ThirdTabViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIApplicationDelegate, MFMailComposeViewControllerDelegate, FBDialogDelegate>{
    
    NSInteger _choosenImageToShare;
    
    IBOutlet UIPickerView *picker;
    IBOutlet UIImageView *imageView;
    
    NSArray *_vOSearchFavoriteArray;

    __weak IBOutlet UIBarButtonItem *_saveButtonItem;
    __weak IBOutlet UIBarButtonItem *_shareButtonItem;
}


- (IBAction)shareButton:(id)sender;
- (IBAction)saveButton:(id)sender;

- (void) saveImageToCameraRow;
- (void) tweet:(NSString *)text;
- (void) email;
- (void) shareWithFacebook;

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end
