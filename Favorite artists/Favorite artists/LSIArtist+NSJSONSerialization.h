//
//  LSIArtist+NSJSONSerialization.h
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//




#import "LSIArtist.h"

 

@interface LSIArtist (NSJSONSerialization)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;
@end

 
