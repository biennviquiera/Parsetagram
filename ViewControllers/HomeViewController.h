//
//  HomeViewController.h
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@property (assign, nonatomic) BOOL isMoreDataLoading;


@end

NS_ASSUME_NONNULL_END
