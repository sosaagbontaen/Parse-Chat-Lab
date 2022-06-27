//
//  ViewController.m
//  Parse Chat
//
//  Created by Samuel Osa-Agbontaen on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation ViewController
- (IBAction)registerUser:(id)sender {
    if ([self.usernameTextField.text isEqual:@""] && [self.passwordTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid username and password" messageLabel:@"Username and password fields are empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    else if ([self.usernameTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid username" messageLabel:@"Username field is empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    else if ([self.passwordTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid password" messageLabel:@"Password field is empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
        }
    }];
}
- (IBAction)loginUser:(id)sender {
    if ([self.usernameTextField.text isEqual:@""] && [self.passwordTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid username and password" messageLabel:@"Username and password fields are empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    else if ([self.usernameTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid username" messageLabel:@"Username field is empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    else if ([self.passwordTextField.text isEqual:@""]){
        [self loginAlert:@"Invalid password" messageLabel:@"Password field is empty" leftLabel:@"Cancel" rightLabel:@"OK"];
        return;
    }
    
    
    NSString *username = self.usernameTextField.text;
        NSString *password = self.passwordTextField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
            }
        }];
}

- (void)loginAlert:(NSString *)titleLabel messageLabel:(NSString *)messageLabel leftLabel: (NSString *)leftLabel rightLabel: (NSString *)rightLabel{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleLabel
                                                                               message:messageLabel
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftLabel
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    [alert addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:rightLabel
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
