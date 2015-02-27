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

NSMutableArray *wallets;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    wallets = [[NSMutableArray alloc] init];
    
    [self.lblExplanation setText:NSLocalizedString(@"Authenticator Explanation", nil)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)nextTip
{
    return NO; // so to always perform segue
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

#pragma UITableView data source + delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

static NSString *CellIdentifier = @"authenticatorWalletCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure Cell
    // Tags:
    //      10) image view
    //      11) Wallet name label
    //      12) wallet id label
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
    [label setText:@"What ?"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
