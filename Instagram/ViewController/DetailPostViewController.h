//
//  DetailPostViewController.h
//  Instagram
//
//  Created by Trang Dang on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailPostViewController : UIViewController
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
