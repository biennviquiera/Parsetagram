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


@interface HomeViewController()
@property(nonatomic, strong, nullable) UIRefreshControl *refreshControl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [query includeKey:@"image"];
    [query includeKey:@"caption"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    query.limit = 20;
    
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
    NSLog(@"fifth item%@", self.arrayOfPosts[indexPath.row]);
    
    NSLog(@"I reached it!!");
    cell.image.file = currentPost[@"image"];
    cell.captionLabel.text = currentPost[@"caption"];
    [cell.image loadInBackground];
    
    return cell;
}

- (void) beginRefresh:(UIRefreshControl *) refreshControl {
    [refreshControl beginRefreshing];
    [self queryPosts];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
