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
        self.artist = [dictionary objectForKey:@"strArtist"];
        self.bio = [dictionary objectForKey:@"strBiographyEN"];
        self.year = [[dictionary objectForKey:@"intFormedYear"] intValue];
    }
    return self;
}
-(NSDictionary *)toDictionary
{
    
}
//Add a method that returns your model object as a NSDictionary (to save artists).

@end
