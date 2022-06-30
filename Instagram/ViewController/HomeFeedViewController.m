//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Trang Dang on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "DetailPostViewController.h"

@interface HomeFeedViewController () <ComposeViewControllerDelegate, PostCellDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *homeFeedTableView;


@property (strong, nonatomic) NSArray *arrayOfPosts;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.homeFeedTableView.dataSource = self;
    self.homeFeedTableView.delegate = self;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:(UIControlEventValueChanged)];
    [self.homeFeedTableView insertSubview:refreshControl atIndex:0];
   
    [self reloadData:10];
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self reloadData:10];
    [refreshControl endRefreshing];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.imagePostImageView.file = post.image;
    [cell.imagePostImageView loadInBackground];
    cell.captionPostLabel.text = post.caption;
//    cell.delegate  = self;
    return cell;
}

- (IBAction)logoutUser:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User loged out successfully");
            // display view controller that needs to shown after successful login
            SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            mySceneDelegate.window.rootViewController = loginViewController;
        }
        
        // PFUser.current() will now be nil
    }];
}

- (IBAction)didTapCompose:(id)sender {
    ComposeViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComposeViewController"];
    viewController.delegate = self;
    [self.navigationController pushViewController: viewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didPost:(nonnull Post *)post {
//    [self.arrayOfTweets insertObject:post atIndex:0];
    [self.homeFeedTableView reloadData];

}

- (void)reloadData:(NSInteger)count{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //    [query whereKey:@"likesCount" greaterThan:@100];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = count;
    

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
//            for(Post *post in posts){
//                [self.arrayOfPosts addObject:post];
//            }
            self.arrayOfPosts = posts;
            NSLog(@"%@", error.localizedDescription);
        }
        [self.homeFeedTableView reloadData];
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailPostViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPostViewController"];
    Post *post = self.arrayOfPosts[indexPath.row];
    viewController.post = post;
    [self.navigationController pushViewController: viewController animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.arrayOfPosts count]){
        [self reloadData:[self.arrayOfPosts count] + 10];
    }
}

@end
