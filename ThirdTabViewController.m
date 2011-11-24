//
//  ThirdTabViewController.m
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ThirdTabViewController.h"
#import "SecondTabViewController.h"
#import <Twitter/Twitter.h>
#import "AppDelegate.h"

@implementation ThirdTabViewController

#define kAppId @"165580606871844"


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *viewControllers = self.tabBarController.viewControllers;
    SecondTabViewController *secondTabVC = [viewControllers objectAtIndex:1];
    
    _vOSearchFavoriteArray = secondTabVC.vOSearchFavoriteArray;
    
    if([_vOSearchFavoriteArray count] == 0){
        [_shareButtonItem setEnabled:NO];
        [_saveButtonItem setEnabled:NO];
    }else{
        [_shareButtonItem setEnabled:YES];
        [_saveButtonItem setEnabled:YES];
    }
    
    [picker reloadAllComponents];
    
    NSLog(@"Quantidade de favoritos: %d", [_vOSearchFavoriteArray count]);
}

- (void)viewDidUnload
{
    _saveButtonItem = nil;
    _shareButtonItem = nil;
    [super viewDidUnload];
    
    picker = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerView methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_vOSearchFavoriteArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    VOSearchFavorite *vOSearchFavorite = [_vOSearchFavoriteArray objectAtIndex:row];
    return vOSearchFavorite.imageName;
}

#pragma mark - UIPickerView delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    if(_vOSearchFavoriteArray != NULL) {
        if(row < [_vOSearchFavoriteArray count]) {
            VOSearchFavorite *vOSearchFavorite = [_vOSearchFavoriteArray objectAtIndex:row];
            UIImage *img = [[UIImage alloc]initWithData:vOSearchFavorite.imageData];
            imageView.image = img;
            _choosenImageToShare = row;
            
            NSLog(@"Imagem selecionada no PickerView: %d", _choosenImageToShare);
        }else{
            NSLog(@"Nenhuma imagem para selecionar no PickerView");
            imageView.image = nil;
        }
    }else{
        NSLog(@"Array de favoriteNames e favoriteImages e nulo");
    }
    
}

#pragma mark - Alert methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
        NSLog(@"Compartilhando -> opcao %d clicada", buttonIndex);
    

     }

- (IBAction)shareButton:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sharing options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Twitter", @"E-mail", @"Facebook", nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    
}

#pragma mark - action sheet delegates

- (void)actionSheet:(UIActionSheet *)sender clickedButtonAtIndex:(int)buttonIndex
{
    if(buttonIndex == 0){
        [self tweet:@"  -> Tweeted by Images Sharer"];
    }else if(buttonIndex == 1){
        [self email];
    }else if(buttonIndex == 2){
        [self shareWithFacebook];
    }
}



#pragma mark - Twitter methods

- (void)tweet:(NSString *)text{
    Class twitterClass = NSClassFromString(@"TWTweetComposeViewController");
    
    if(twitterClass){
        TWTweetComposeViewController *composer = [[TWTweetComposeViewController alloc] init];
        [composer setInitialText:text];
        
        VOSearchFavorite *vOSearchFavorite = [_vOSearchFavoriteArray objectAtIndex:_choosenImageToShare];
        UIImage *img = [[UIImage alloc]initWithData:vOSearchFavorite.imageData];
        [composer addImage:img];
        
        [self presentViewController:composer animated:YES completion:NULL];
    }
}

#pragma mark
#pragma mark - Facebook methods and delegates

- (void)shareWithFacebook{
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream",
                            nil];
    
    if (![appDelegate.facebook isSessionValid]) {
        [appDelegate.facebook authorize:permissions];
    }
    
    VOSearchFavorite *vOSearchFavorite = [_vOSearchFavoriteArray objectAtIndex:_choosenImageToShare];
    NSString *imgUrl = vOSearchFavorite.imageURL;
    NSString *imgName = vOSearchFavorite.imageName;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   kAppId, @"app_id",
                                   imgUrl, @"link",
                                   imgUrl, @"picture",
                                   imgName, @"name",
                                   @"Reference Documentation:", @"caption",
                                   @"New way of sharing your pictures among.", @"description",
                                   @"Check out this amazing picture I found with Images Sharer for iPhone!",  @"message",
                                   nil];
    
    [appDelegate.facebook dialog:@"feed" andParams:params andDelegate:self];
    

}



#pragma mark
#pragma mark - Mail methods and delegates

- (void)email{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"Check out this super photo found with Images Sharer for iPhone!"];
    
    VOSearchFavorite *vOSearchFavorite = [_vOSearchFavoriteArray objectAtIndex:_choosenImageToShare];
    NSString *favoriteImageLink = vOSearchFavorite.imageURL;
    NSString *msg = [[NSString alloc]initWithString:@"This photo was shared through Images Sharer iPhone"];
    NSString *bodyMsg = [NSString stringWithFormat:@"%@\n\n%@", favoriteImageLink, msg];
    
    [controller setMessageBody:bodyMsg isHTML:NO];
    
    [self presentModalViewController:controller animated:YES];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - Save Image to Camera Row methods and delegates

- (IBAction)saveButton:(id)sender{
    [self saveImageToCameraRow];
}

- (void) saveImageToCameraRow{
    VOSearchFavorite *favoriteObject = [_vOSearchFavoriteArray objectAtIndex:_choosenImageToShare];
    NSData *data = favoriteObject.imageData;
    if(data != nil){
        UIImage *img = [[UIImage alloc]initWithData:data];
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil );
    }else{
        NSLog(@"There are no favorite images!");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"There are no favorite images!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:NULL, nil];
        
        [alert show];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error != NULL)
    {
        NSLog(@"Image NOT saved to Camera Row, something went wrong!");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Image NOT saved due to some error!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:NULL, nil];
        
        [alert show];
        
    }
    else
    {
        NSLog(@"Image saved to Camera Row, well done!");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Image saved to Camera Row!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:NULL, nil];
        
        [alert show];
    }
}

@end
