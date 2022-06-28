//
//  HomeViewController.h
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;

@end

NS_ASSUME_NONNULL_END
