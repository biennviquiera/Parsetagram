//
//  HomeViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "HomeFeedCell.h"
#import "Post.h"
#import "LoginViewController.h"
#import "DetailViewController.h"
#import "ComposeViewController.h"


@interface HomeViewController() <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, UIScrollViewDelegate>
@property(nonatomic, strong, nullable) UIRefreshControl *refreshControl;
@property NSInteger globalQuery;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.globalQuery =0;
    // Do any additional setup after loading the view.
    // query parse for data to show in home vc
    self.tableView.estimatedRowHeight = 360;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self queryPosts];
    [self.tableView reloadData];
    
}

- (void)queryPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    self.globalQuery += 20;
    [query includeKey:@"image"];
    [query includeKey:@"caption"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    query.limit = self.globalQuery;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            self.arrayOfPosts = objects;
            NSLog(@"%@",self.arrayOfPosts);
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    
    }];
    //change current view controller to login
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"array count %lu", self.arrayOfPosts.count);
    return self.arrayOfPosts.count;
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeFeedCell" forIndexPath:indexPath];
    Post *currentPost = self.arrayOfPosts[indexPath.row];
    
    cell.image.file = currentPost[@"image"];
    cell.captionLabel.text = currentPost[@"caption"];
    cell.userLabel.text = [currentPost[@"author"] username];

    if (currentPost[@"author"][@"profileImage"]) {
        cell.userImage.file = currentPost[@"author"][@"profileImage"];
        [cell.userImage loadInBackground];
        
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2;
        cell.userImage.clipsToBounds = YES;
    }
    [cell.image loadInBackground];

    cell.post = currentPost;
    
    return cell;
}

- (void) beginRefresh:(UIRefreshControl *) refreshControl {
    [refreshControl beginRefreshing];
    [self queryPosts];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

- (void) didPost {
    [self beginRefresh:self.refreshControl];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
                int scrollViewContentHeight = self.tableView.contentSize.height;
                int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
                // When the user has scrolled past the threshold, start requesting
                if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
                    // ... Code to load more results ...
                    self.isMoreDataLoading = true;
                    [self loadMoreData];
                    
                }
        

    }
}
    
-(void)loadMoreData{
  
    // Update flag
    self.isMoreDataLoading = false;
    
    // ... Use the new data to update the data source ...
    [self queryPosts];
    // Reload the tableView now that there is new data
    [self.tableView reloadData];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"composeSegue"]) {
        ComposeViewController *composeVC = [segue destinationViewController];
        composeVC.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailViewController *detailVC = [segue destinationViewController];
        NSLog(@"passing %@", ((HomeFeedCell *)sender).post);
        detailVC.passedPost = ((HomeFeedCell *)sender).post;
    }
    
}


@end
