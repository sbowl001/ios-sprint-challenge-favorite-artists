//
//  ArtistController.m
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/15/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "ArtistController.h"
#import "LSIArtist.h"
#import "LSIArtist+NSJSONSerialization.h"

@interface ArtistController()

@property (nonatomic) NSMutableArray<LSIArtist *> *internalArtists;
@end

@implementation ArtistController
-(instancetype)init
{
    self = [super init];
    if (self) {
        _internalArtists = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addArtist: (LSIArtist *)anArtist
{
    [self.internalArtists addObject:anArtist];
    [self saveArtistsToDcoumentDirectory];
}

-(void)removeArtist: (LSIArtist *)anArtist
{
    [self.internalArtists removeObject:anArtist];
    [self saveArtistsToDcoumentDirectory];
}

-(NSArray<LSIArtist *> *)artists
{
    return self.internalArtists.copy;
}

#pragma mark - Networking
static NSString *artistBaseURLString = @"https://theaudiodb.com/api/v1/json/1/search.php";

-(void)fetchArtistWithName:(NSString *)artist completionHandler:(FetchArtistCompletionHandler)completionHandler
{
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:artistBaseURLString];
    NSMutableArray *queryItems = [NSMutableArray arrayWithObjects:[NSURLQueryItem queryItemWithName:@"s" value:artist], nil];
    URLComponents.queryItems =queryItems;
    NSURL *URL = URLComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching artists: %@", error);
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError = nil;
        
      
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        
        if (jsonError){
            NSLog(@"Error decoding json: %@",jsonError);
            dispatch_async(dispatch_get_main_queue(),
            ^{
            completionHandler(nil, jsonError);
            });
            return;
        }
        //going into artist array
        NSArray *artistArray = jsonDictionary[@"artists"];
               
        for (NSDictionary *newArtistFromDict in artistArray){
                 
                  LSIArtist *artist = [[LSIArtist alloc] initWithDictionary:newArtistFromDict];
                   
                   if (artist){
                       dispatch_async(dispatch_get_main_queue(), ^{
                       completionHandler(artist, nil);
                       });
                   }
        }
  
    }] resume];
}

//TO Do: SaveArtist and Load artist with UserDefaults

-(void)loadArtistsFromDocumentDirectory
{
     NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"artists.plist"];
    
    NSMutableArray *artistDictionaries = [[NSDictionary alloc] initWithContentsOfURL:documentDirectory][@"artists"];
    
    for (NSDictionary *dictionary in artistDictionaries) {
        LSIArtist *artist = [[LSIArtist alloc] initWithDictionary:dictionary];
        [self.internalArtists addObject:artist];
    }
}

-(void)saveArtistsToDcoumentDirectory
{
    NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"artists.plist"];
       
       NSMutableArray *artistDictionaries = [[NSMutableArray alloc] init];
       
       for (LSIArtist *artist in self.internalArtists) {
           [artistDictionaries addObject:[artist toDictionary]];
       }
       
       NSDictionary *dictionary = @{@"artists":artistDictionaries};
       
       [dictionary writeToURL:documentDirectory atomically:YES];
}
@end
