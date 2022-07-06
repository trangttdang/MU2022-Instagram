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
@property (weak, nonatomic) IBOutlet PFImageView *detailProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTimestampLabel;
@end

@implementation DetailPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailCaptionLabel.text = self.post.caption;
    self.detailPostImageView.file = self.post.image;
    [self.detailPostImageView loadInBackground];
    self.detailTimestampLabel.text = [NSString stringWithFormat:@"%@", self.post.createdAt];
    
    self.detailProfileImageView.file = self.post.author[@"profilePhoto"];
    [self.detailProfileImageView loadInBackground];
    self.detailProfileImageView.layer.cornerRadius = self.detailProfileImageView.frame.size.width/2;
    self.detailUsernameLabel.text = self.post.author.username;
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
