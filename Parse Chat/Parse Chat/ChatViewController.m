//
//  ChatViewController.m
//  Parse Chat
//
//  Created by Samuel Osa-Agbontaen on 6/27/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "ChatCell.h"


@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) NSArray *arrayOfChats;

@end

@implementation ChatViewController
- (IBAction)sendAction:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.chatTextField.text;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
            self.chatTextField.text = @"";
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}

- (void)periodicRefresh{
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            //NSLog(@" grab posts : %@", posts);
            self.arrayOfChats = posts;
            //NSLog(@" grab posts : %@", self.arrayOfChats);
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self.chatTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    PFObject *chat = self.arrayOfChats[indexPath.row];
    //NSLog(@"%@", self.arrayOfChats);
    cell.messageLabel.text = chat[@"text"];
    NSLog(@"Grab from array : %@", chat[@"text"]);
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatTableView.dataSource = self;
    self.chatTableView.delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(periodicRefresh) userInfo:nil repeats:true];
    // Do any additional setup after loading the view.
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
