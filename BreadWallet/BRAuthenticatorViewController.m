//
//  BRAuthenticatorViewController.m
//  BreadWallet
//
//  Created by alon muroch on 2/27/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import "BRAuthenticatorViewController.h"

@interface BRAuthenticatorViewController ()

@end

@implementation BRAuthenticatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.lblExplanation setText:NSLocalizedString(@"Authenticator Explanation", nil)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
