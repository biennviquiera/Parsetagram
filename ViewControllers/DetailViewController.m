//
//  DetailViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/28/22.
//

#import "DetailViewController.h"
#import "DateTools.h"
#import "Parse/Parse.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.passedPost);
    
//    self.userImage =;
    self.postImage.file = self.passedPost.image;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.clipsToBounds = YES;
    [self.postImage loadInBackground];
    NSDate *dateCreated = self.passedPost.createdAt;
    self.dateLabel.text = [dateCreated shortTimeAgoSinceNow];
    self.captionLabel.text = self.passedPost.caption;
    self.usernameLabel.text = [self.passedPost.author username];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
