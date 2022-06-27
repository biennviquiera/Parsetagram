//
//  ComposeViewController.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "ComposeViewController.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.postImage.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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
