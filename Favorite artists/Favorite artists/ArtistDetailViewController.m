//
//  ArtistDetailViewController.m
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "ArtistController.h"
#import "LSIArtist.h"
#import "LSIArtist+NSJSONSerialization.h"

@interface ArtistDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setDelegate:self];
    [self updateViews];
    
}

-(void)updateViews
{
//    self.title = self.artist.artist ?: "Search for Artist";
    if(!self.isViewLoaded || !self.artist) {return;}
    
    self.nameLabel.text = self.artist.artist;
    self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed in %@", self.artist.yearFormed];
    self.bioTextView.text = self.artist.bio;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = searchBar.text;
    [_artistController fetchArtistWithName:searchTerm completionHandler:^(LSIArtist *artist, NSError *error) {
        self.artist = artist;
        [self updateViews];
    }];
}

-(void)setArtist:(LSIArtist *)artist
{
    if (_artist != artist){
        _artist = artist;
        [self updateViews];
    }
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    LSIArtist *artist = [[LSIArtist alloc] initWithArtistName:self.nameLabel.text yearFormed:self.yearFormedLabel.text bio:self.bioTextView.text];
    [self.artistController addArtist:artist];
    [self.navigationController popViewControllerAnimated:YES];
}

 
@end
