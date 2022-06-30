//
//  DetailPostViewController.m
//  Instagram
//
//  Created by Trang Dang on 6/30/22.
//

#import "DetailPostViewController.h"
#import <Foundation/Foundation.h>
@interface DetailPostViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *detailPostImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTimestampLabel;
@end

@implementation DetailPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailCaptionLabel.text = self.post.caption;
    self.detailPostImageView.file = self.post.image;
    self.detailTimestampLabel.text = [NSString stringWithFormat:@"%@", self.post.createdAt];
    [self.detailPostImageView loadInBackground];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *datePostDetail = self.post.createdAt;
    //Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    // Convert Date to String
    
    self.detailTimestampLabel.text = [formatter stringFromDate:datePostDetail];
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
