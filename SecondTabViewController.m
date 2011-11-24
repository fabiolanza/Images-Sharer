//
//  SecondTabViewController.m
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondTabViewController.h"
#import "MyUITableViewCell.h"

@implementation SecondTabViewController

@synthesize vOSearchFavoriteArray = _vOSearchFavoriteArray;


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
    
    myTableView.allowsMultipleSelection = YES;
    
    _vOSearchFavoriteArray = [[NSMutableArray alloc]init];
    
    adView.delegate = self;
    
    adView.hidden = true;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    adView = nil;
    rateUsOnAppStore = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Data Source Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [myTableView cellForRowAtIndexPath:indexPath];
    
//    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:THUMB_TAG];
//    UIImage *cellImage = imageView.image;
//    
//    UILabel *labelMainlabel = (UILabel *)[cell.contentView viewWithTag:MAINLABEL_TAG];
//    NSString *cellName = labelMainlabel.text;
    
    VOSearch *vOSearch = [_vOSearchArray objectAtIndex:indexPath.row];
    
    VOSearchFavorite *vOSearchFavorite = [[VOSearchFavorite alloc]init];
    vOSearchFavorite.imageData = vOSearch.image;
    vOSearchFavorite.imageSite = vOSearch.font;
    vOSearchFavorite.imageURL = vOSearch.uRL;
    vOSearchFavorite.imageName = vOSearch.name;
    vOSearchFavorite.rowAtTableViewCell = indexPath.row;
    
    
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [_vOSearchFavoriteArray addObject:vOSearchFavorite];
        
        vOSearch.isFavorite = TRUE;
        
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        //
        //HERE WE REMOVE FAVORITE OBJECTS FROM FAVORITE OBJECTS ARRAY
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        int favoriteAtIndex;
        for(int i = 0; i < [_vOSearchFavoriteArray count]; i++){
            VOSearchFavorite *favorite = [_vOSearchFavoriteArray objectAtIndex:i];
            if(favorite.rowAtTableViewCell == indexPath.row){
                favoriteAtIndex = i;
            }
        }
        [_vOSearchFavoriteArray removeObjectAtIndex:favoriteAtIndex];
        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        
        vOSearch.isFavorite = FALSE;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [imagesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    MyUITableViewCell *cell = (MyUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MyUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    VOSearch *vOSearch = [_vOSearchArray objectAtIndex:indexPath.row];
    if(vOSearch.isFavorite == FALSE){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [cell setData:[_vOSearchArray objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - getData

- (IBAction)getImagesInfo:(id)sender {
    
    NSLog(@"Metodo getImagesInfo foi chamado, palavra: %@", palavraChave.text);
    
    [waiting performSelectorInBackground:@selector(startAnimating) withObject:NULL];
    
    _googleAPI = [[WSGoogleImagesAPI alloc] init];
    
    if (!imagesArray) {
        imagesArray = [[NSMutableArray alloc] init];
        uRLFonts = [[NSMutableArray alloc] init];
        uRLNames = [[NSMutableArray alloc] init];
    } else {
        //CLEANING LOCAL SET OF ARRAYS
        [imagesArray removeAllObjects];
        [uRLFonts removeAllObjects];
        [uRLNames removeAllObjects];
    }
    
    [_googleAPI syncImagensDownload:palavraChave.text];
    
    _vOSearchArray = _googleAPI.vOSearchArray;
    
    NSMutableArray *iDs = [[NSMutableArray alloc]init];
        
    for(VOSearch *_vOSearch in _vOSearchArray){
        
        UIImage *img = [[UIImage alloc] initWithData:_vOSearch.image];
        NSString *font = _vOSearch.uRL;
        NSString *name = _vOSearch.name;
        
        if([_vOSearch.image length] != 0){
            [imagesArray addObject:img];
            [uRLFonts addObject:font];
            [uRLNames addObject:name];
        }else{
            [iDs addObject:_vOSearch];
        }
    }
    
    for(int i = 0; i < [iDs count]; i++){
        [_vOSearchArray removeObject:[iDs objectAtIndex:i]];
    }
    
    [myTableView reloadData];
    
    [waiting stopAnimating];
}

- (IBAction)keyboardReturn:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)keyboardReturnAfterPushingSearchButton:(id)sender{
    [palavraChave resignFirstResponder];
}

#pragma
#pragma mark - AdBannerView methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    adView.hidden = false;
    rateUsOnAppStore.hidden = true;
    NSLog(@"Showing bannerView at SecondTab");
}

@end
