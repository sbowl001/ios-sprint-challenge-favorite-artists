//
//  LSIArtist.m
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "LSIArtist.h"

@implementation LSIArtist



-(instancetype)initWithArtistName:(NSString *)name
                       yearFormed:(NSString *)yearFormed
                              bio:(NSString *)bio
{
    self = [super init];
    if (self){
        _artist = name;
        _yearFormed = yearFormed;
        _bio = bio;
    }
    return self;
}
@end
