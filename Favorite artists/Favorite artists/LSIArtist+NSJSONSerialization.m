//
//  LSIArtist+NSJSONSerialization.m
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "LSIArtist+NSJSONSerialization.h"

 

@implementation LSIArtist (NSJSONSerialization)


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSString *artistName = [dictionary objectForKey:@"strArtist"];
        NSString *bio = [dictionary objectForKey:@"strBiographyEN"];
        NSString *yearFormed = [dictionary objectForKey:@"intFormedYear"];
        
        if (artistName != nil && yearFormed != nil &&bio != nil){
            self = [self initWithArtistName:artistName yearFormed:yearFormed bio:bio];
        } else {
            NSLog(@"Invalid artist: %@ JSON Object", artistName);
            self = nil;
        }
    }
    return self;
}
-(NSDictionary *)toDictionary
{
    NSDictionary *result = @{
        @"strArtist": self.artist,
        @"strBiographyEN": self.bio,
        @"intFormedYear": self.yearFormed
    };
    return result;
}
//Add a method that returns your model object as a NSDictionary (to save artists).

@end
