//
//  WSGoogleImagesAPI.m
//  Test
//
//  Created by Fabio L Brandao FH on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WSGoogleImagesAPI.h"
#import "DoingTheJSON.h"


@interface WSGoogleImagesAPI ()
- (void)grabImages;
@end

@implementation WSGoogleImagesAPI

@synthesize vOSearchArray = _vOSearchArray;

#pragma mark - initialization

- (id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)fixSearchKeyWhenItContainsSpaceChars:(NSString *)searchKey{
    //
    //HERE WE EXCHANGE " " CHARS BY "%20" FOR EACH " " ON THE SEARCH KEY
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    NSArray *listItems = [searchKey componentsSeparatedByString:@" "];
    NSString *fixedSearchKey = [[NSString alloc] init];
    
    if([listItems count] > 1){
        NSLog(@"Fixing searchKey with space chars!");
        
        NSString *tempString = [[NSString alloc] init];
        
        for(int i = 1; i < [listItems count]; i++){
            tempString = [tempString stringByAppendingString:[[[listItems objectAtIndex:i - 1] stringByAppendingString:@"%20"] stringByAppendingString:[listItems objectAtIndex:i]]];
        }
        
        fixedSearchKey = tempString;
    }else{
        fixedSearchKey = searchKey;
    }
    
    return fixedSearchKey;
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}

- (void)syncImagensDownload:(NSString *)texto {
    
    texto = [self fixSearchKeyWhenItContainsSpaceChars:texto];
    
    NSString *urlString = [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@", texto];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    
    @try {
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        receivedData = [[NSMutableData alloc] initWithData:data];
        
        if(data != nil){
            NSDictionary *returnedDict = [[NSDictionary alloc] initWithDictionary:[DoingTheJSON readingJSON:receivedData]];
            NSDictionary *level2 = [returnedDict objectForKey:@"responseData"];
            NSArray *level3 = [level2 objectForKey:@"results"];
            
            NSDictionary *level4 = [[NSDictionary alloc] init];
            
            _vOSearchArray = [[NSMutableArray alloc] init];
            
            for (NSInteger i = 0; i < [level3 count]; i++) {
                
                level4 = [level3 objectAtIndex:i];
                
                _vOSearch = [[VOSearch alloc] init];
                _vOSearch.uRL = [level4 objectForKey:@"url"];
                _vOSearch.name = [level4 objectForKey:@"titleNoFormatting"];
                _vOSearch.font = [level4 objectForKey:@"visibleUrl"];
                
                _vOSearch.isFavorite = FALSE;
                
                [_vOSearchArray addObject:_vOSearch];
            }
            
            
            if([_vOSearchArray count] == 0){
                NSLog(@"Pesquisa nao retornou resultados!");
                
                NSString *str = [[NSString alloc]initWithFormat:@"Your search did not bring results, please try other keyword!"];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning!" message:str delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:NULL, nil];
                
                [alert show];
                
            }else{
                [self grabImages];
            }
        }else{
            NSLog(@"Metodo grabImages nao sera chamado -> problemas de conexao");
            
            NSString *str = [[NSString alloc]initWithFormat:@"It seems that internet connection is out of reach. Try to adjust internet settings!"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning!" message:str delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:NULL, nil];
            
            [alert show];
        }
    }
    @catch (NSException *e) {
        NSLog(@"METODO syncImagensDownload CLASS WSGoogleImagesAPI: Problema de conectividade -> %@", error);

    }

}

//GET IMAGE FROM THE IMAGE URL ARRAY AND STORE IN A DATA ARRAY
- (void)grabImages{
    
    NSLog(@"Metodo grabImages foi chamado");
    
    NSMutableData *imagem = [[NSMutableData alloc] init];
    
    for (NSInteger i = 0; i < [_vOSearchArray count]; i++) {
        
        _vOSearch = [_vOSearchArray objectAtIndex:i];
        
        imagem = [NSData dataWithContentsOfURL:[NSURL URLWithString:_vOSearch.uRL]];
        
        _vOSearch.image = imagem;
        
        NSLog(@"Imagem %d baixada com %d bytes", i + 1, [_vOSearch.image length]);
    }
}

@end
