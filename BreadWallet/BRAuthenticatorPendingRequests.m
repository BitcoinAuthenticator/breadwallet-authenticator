//
//  BRAuthenticatorPendingRequests.m
//  BreadWallet
//
//  Created by alon muroch on 2/28/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import "BRAuthenticatorPendingRequests.h"
#import <Authenticator/NSManagedObject+Manager.h>

@interface BRAuthenticatorPendingRequests ()

@end

@implementation BRAuthenticatorPendingRequests

@synthesize pairingData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[NSNotificationCenter defaultCenter]
                             addObserver:self
                             selector:@selector(handleDataModelChange:)
                             name:NSManagedObjectContextObjectsDidChangeNotification
                             object:[BAPairingData _context]];
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

#pragma IBActions

- (IBAction)close:(id)sender {
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)delete:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"warning", nil)
                                                   message:NSLocalizedString(@"delete pairing alert msg", nil)
                                                  delegate:self
                                         cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                         otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
    
    alert.tag = deletePairingAlertTag;
    [alert show];
}

- (IBAction)rename:(id)sender {
}

#pragma UIAlertView delegate
const int deletePairingAlertTag = 101;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == deletePairingAlertTag) {
        if(buttonIndex != alertView.cancelButtonIndex)
        {
            [BAPairingData _deleteObjects:[NSArray arrayWithObject:self.pairingData]];
            [BAPairingData _saveContext];
        }
    }
}

#pragma Data model changes callback

- (void)handleDataModelChange:(NSNotification *)note
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma UITableView data source + delegate

-(void)loadData
{
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

static NSString *CellIdentifier = @"pendingReqCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
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
