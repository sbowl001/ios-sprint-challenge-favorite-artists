//
//  ArtistController.h
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/15/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <Foundation/Foundation.h>

 
@class LSIArtist;

typedef void (^FetchArtistCompletionHandler)(LSIArtist *artist, NSError *error);

@interface ArtistController : NSObject

@property (nonatomic, readonly, copy)NSArray<LSIArtist *> *artists;

- (void)addArtist: (LSIArtist *)anArtist;

-(void)removeArtist: (LSIArtist *)anArtist;

-(void)fetchArtistWithName:(NSString *)artist completionHandler:(FetchArtistCompletionHandler)completionHandler;

@end

 
