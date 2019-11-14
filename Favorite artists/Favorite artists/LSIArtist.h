//
//  LSIArtist.h
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIArtist : NSObject

@property (nonatomic, readonly, copy)NSString *artist;
@property (nonatomic, readonly, copy)NSString *yearFormed;
@property (nonatomic, readonly, copy)NSString *bio;


-(instancetype)initWithArtistName:(NSString *)name
                       yearFormed:(NSString *)yearFormed
                              bio:(NSString *)bio;

@end

NS_ASSUME_NONNULL_END
