//
//  ArtistDetailViewController.h
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtistController;
@class LSIArtist;

@interface ArtistDetailViewController : UIViewController

@property (nonatomic) ArtistController *artistController;
@property (nonatomic) LSIArtist *artist;
@end

 
