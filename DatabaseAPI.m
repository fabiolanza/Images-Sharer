//
//  DatabaseAPI.m
//  Test
//
//  Created by Fabio L Brandao FH on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DatabaseAPI.h"

@implementation DatabaseAPI

- (void) createDatabase{
    NSString *docsDir;
    NSArray *dirPaths;
    
    //GET PATH OF DOCUMENTS DIRECTORY
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //ADD docsDir to array of paths
    docsDir = [dirPaths objectAtIndex:0];
    //NSLog(@"Diretorio do banco: %@", [dirPaths objectAtIndex:0]);
    
    //BUILD THE PATH TO THE DATABASE FILE
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"images.db"]];
    NSLog(@"Diretorio do banco: %@", _databasePath);
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:_databasePath] == NO) {
        const char *dbPath = [_databasePath UTF8String];
        
        if(sqlite3_open(dbPath, &_imagesDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS IMAGES (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, URL TEXT, IMAGE TEXT)";
            
            if(sqlite3_exec(_imagesDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                NSLog(@"Falha na criacao da tabela images");
            }else{
                NSLog(@"Tabela images criada com sucesso!");
            }
            
            NSLog(@"Fechando database...");
            sqlite3_close(_imagesDB);
            
        }else{
            NSLog(@"Falha ao tentar abrir database _images.BD");
        }
    }else{
        NSLog(@"Database ja existe -> Nao sera criado!");
    }
}

- (void) saveImageToDirectory:(NSData *)image{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", 
                          documentsDirectory];
    //create content - four lines of text
    NSString *content = @"One\nTwo\nThree\nFour\nFive";
    //save content to the documents directory
    [content writeToFile:fileName 
              atomically:NO 
                encoding:NSStringEncodingConversionAllowLossy 
                   error:nil];
}

- (void) saveMetaDataToBD:(NSString *)name:(NSString *)url:(NSString *)imageDirectory{
    
    sqlite3_stmt    *statement;
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_imagesDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO IMAGES (NAME, URL, IMAGE) VALUES (\"%@\", \"%@\", \"%@\")", name, url, imageDirectory];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(_imagesDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {

        } else {
            NSLog(@"Failed to add contact");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_imagesDB);
    }
  
}  

- (void) getData{
    
}

- (void) readFromPlist{
    
    NSString *plistDir;
    NSArray *plistPaths;
    
    //GET PATH OF DOCUMENTS DIRECTORY
    plistPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //ADD docsDir to array of paths
    plistDir = [plistPaths objectAtIndex:0];
    
    _plist = [[NSString alloc] initWithString:[plistDir stringByAppendingPathComponent:@"settings.plist"]];
    
}

- (void) writeOnPlist{
    
}

@end
