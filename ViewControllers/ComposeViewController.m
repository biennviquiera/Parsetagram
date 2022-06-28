//
//  ComposeViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ComposeViewController
- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

}
- (IBAction)didTapCompose:(id)sender {
    //do the parse backend stuff here
    
    [Post postUserImage:self.postImage.image withCaption:self.captionLabel.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    
    //close
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
    
    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    //define resized image
    CGSize size = CGSizeMake(360, 360);
    UIImage *resizedImage = (UIImage *) [self resizeImage:editedImage withSize:size];
    self.postImage.image = resizedImage;
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
