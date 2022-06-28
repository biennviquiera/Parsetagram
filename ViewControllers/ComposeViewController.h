//
//  ComposeViewController.h
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
