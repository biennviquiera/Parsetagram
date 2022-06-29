//
//  ComposeViewController.h
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPost;

@end

@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *postImage;
@property (strong, nonatomic) IBOutlet UITextView *captionLabel;
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
