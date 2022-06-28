//
//  HomeFeedCell.h
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface HomeFeedCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post *post;



@end

NS_ASSUME_NONNULL_END
