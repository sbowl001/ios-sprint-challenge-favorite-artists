//
//  ArtistsTableViewController.m
//  Favorite artists
//
//  Created by Stephanie Bowles on 11/14/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

#import "ArtistsTableViewController.h"
#import "ArtistDetailViewController.h"
#import "ArtistController.h"
#import "LSIArtist.h"

@interface ArtistsTableViewController ()
@property (nonatomic, readonly) ArtistController *artistController;
@end

@implementation ArtistsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.artistController loadArtistsFromDocumentDirectory];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
 

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artistController.artists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
    
    LSIArtist *artist = [self.artistController.artists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = artist.artist;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Formed in %@", artist.yearFormed];
    cell.detailTextLabel.text = artist.yearFormed;
    return cell;
}

 

 
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LSIArtist *artist = [self.artistController.artists objectAtIndex:indexPath.row];
        [self.artistController removeArtist:artist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
 

 
 
#pragma mark - Navigation

 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowArtistDetail"]) {
           NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
           ArtistDetailViewController *detailVC = segue.destinationViewController;
           detailVC.artistController = self.artistController;
           detailVC.artist = [self.artistController.artists objectAtIndex:indexPath.row];
       } else if ([segue.identifier isEqualToString:@"AddArtist"]) {
           ArtistDetailViewController *detailVC = segue.destinationViewController;
           detailVC.artistController = self.artistController;
       }
}
 

@synthesize artistController = _artistController;
-(ArtistController *)artistController
{
    if (!_artistController){
        _artistController = [[ArtistController alloc] init];
    }
    return _artistController;
}

@end
