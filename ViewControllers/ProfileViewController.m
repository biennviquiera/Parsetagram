//
//  ProfileViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "ProfileViewController.h"
#import "ProfileCell.h"
#import <Parse/Parse.h>
@import Parse;

@interface ProfileViewController () <UICollectionViewDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSArray *test;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    // Do any additional setup after loading the view.
//    self.test = @[@"foo", @"bar"];
//    [self.collectionView reloadData];
    UILongPressGestureRecognizer *photoHold = [[UILongPressGestureRecognizer alloc] initWithTarget:self  action:@selector(heldPhoto:)];
    photoHold.minimumPressDuration = 0.5;
    [self.profileImage addGestureRecognizer:photoHold];
    //check for image
    if ([PFUser currentUser][@"profileImage"]) {
        self.profileImage.file = [PFUser currentUser][@"profileImage"];
        [self.profileImage loadInBackground];
    }
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.clipsToBounds = YES;
    self.usernameLabel.text = [PFUser currentUser][@"username"];
    

}

- (void) heldPhoto:(UILongPressGestureRecognizer *) gesture{
    NSLog(@"I have been held");
    //on tap, want to show gallery
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}


//delegate for tapped photo
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    //define resized image
    CGSize size = CGSizeMake(360, 360);
    UIImage *resizedImage = (UIImage *) [self resizeImage:editedImage withSize:size];
    //upload as current user's image
    PFUser *user = [PFUser currentUser];
    [self.profileImage setImage:resizedImage];
    
    PFFileObject *img = [PFFileObject fileObjectWithName:@"userImg.png" data:UIImagePNGRepresentation(resizedImage)];
    user[@"profileImage"] = img;
    [user saveInBackground];
    
    self.profileImage.file = [PFUser currentUser][@"profileImage"];
    [self.profileImage loadInBackground];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

//resize for image limit
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.test.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    cell.textLabel = [self.test objectAtIndex:indexPath.row];
    return cell;
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
