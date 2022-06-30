//
//  ProfileViewController.m
//  Instagram
//
//  Created by Trang Dang on 6/27/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "PostCollectionViewCell.h"
#import "Post.h"
#import "Parse/PFImageView.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
@property (nonatomic, strong) PFFileObject *image;
@property (weak, nonatomic) IBOutlet UICollectionView *PostCollectionView;
@property (nonatomic, strong) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    PFUser *currentUser = [PFUser currentUser];
    self.PostCollectionView.dataSource = self;
    self.PostCollectionView.delegate = self;
    self.profileImageView.file = self.image;
    [self.profileImageView loadInBackground];
    [self fetchPosts];
//
}

- (void)fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo: [PFUser currentUser]];
    query.limit = 30;
    

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            for(Post *post in posts){
//                [self.arrayOfPosts addObject:post];
//            }
            self.posts = posts;
            NSLog(@"%@", error.localizedDescription);
        }
        [self.PostCollectionView reloadData];
    }];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    cell.postImageView.file = post.image;
    [cell.postImageView loadInBackground];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int totalwidth = self.PostCollectionView.bounds.size.width;
    int numberOfCellsPerRow = 4;
    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    return CGSizeMake(dimensions*1.2, dimensions*1.2);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapUploadProfileImage:(id)sender {
    [self getPicture];
//    PFUser *currentUser = [PFUser currentUser];
//    currentUser[@"profilePhoto"] = self.image;
    
}

- (void)getPicture{
    // Do any additional setup after loading the view.
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // Instantiate a UIImagePickerController
    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
//    PFUser *currentUser = [PFUser currentUser];
//    currentUser[@"profilePhoto"] = self.image;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    
    
    [self.profileImageView setImage:resizedImage];
    self.image = [self getPFFileFromImage:resizedImage];
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"profilePhoto"] = self.image;
    
    [currentUser saveInBackground];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

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

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
