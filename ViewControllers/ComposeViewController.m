//
//  ComposeViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController
- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //create tap gesture recognizer
    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tappedPhoto:)];
    photoTap.numberOfTapsRequired = 1;
    [self.postImage addGestureRecognizer:photoTap];
}

- (void)tappedPhoto: (id)sender {
    NSLog(@"I've been tapped!");
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
