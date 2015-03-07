//
//  BRAuthenticatorPendingRequests.m
//  BreadWallet
//
//  Created by alon muroch on 2/28/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import "BRAuthenticatorPendingRequests.h"
#import <Authenticator/NSManagedObject+Manager.h>
#import "DLAVAlertView.h"
#import "Authenticator/BARemoteNotificationData.h"

#import "Authenticator/RemoteNotificationHandler.h"

@interface BRAuthenticatorPendingRequests ()

@end

@implementation BRAuthenticatorPendingRequests

@synthesize pairingData;
NSArray *pendingRequests;


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
     [self loadData];
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
    DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:NSLocalizedString(@"warning", nil)
                                                            message:NSLocalizedString(@"delete pairing alert msg", nil)
                                                            delegate:nil
                                                            cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                                            otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
     [alertView showWithCompletion:^(DLAVAlertView *alertView, NSInteger buttonIndex) {
         if(buttonIndex != alertView.cancelButtonIndex)
         {
             [BAPairingData _deleteObjects:[NSArray arrayWithObject:self.pairingData]];
             [BAPairingData _saveContext];
             [self.navigationController dismissViewControllerAnimated:YES completion:nil];
         }
      }];
}

- (IBAction)rename:(id)sender {
    DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:NSLocalizedString(@"warning", nil)
                                                            message:NSLocalizedString(@"rename pairing alert msg", nil)
                                                            delegate:nil
                                                            cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                                            otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
    alertView.alertViewStyle = DLAVAlertViewStylePlainTextInput;
    [alertView showWithCompletion:^(DLAVAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex != alertView.cancelButtonIndex)
        {
            NSString *newName = [alertView textFieldTextAtIndex:0];
            
            // a quick validation
            if(newName.length > 2)
            {
                pairingData.pairingName = newName;
                [BAPairingData _saveContext];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                DLAVAlertView *illegalNewNameAlert = [[DLAVAlertView alloc] initWithTitle:NSLocalizedString(@"error", nil)
                                                                                    message:NSLocalizedString(@"rename pairing illegal new name error msg", nil)
                                                                                    delegate:nil
                                                                                    cancelButtonTitle:NSLocalizedString(@"ok", nil)
                                                                                    otherButtonTitles:nil, nil];
                [illegalNewNameAlert showWithCompletion:nil];
            }
        }
    }];
}

#pragma UITableView data source + delegate

-(void)loadData
{
    pendingRequests = [self.pairingData.pendigNotifications array];
//    
//    if(pendingRequests.count == 0) {
//        NSDictionary *reqPayload = [NSDictionary dictionaryWithObjectsAndKeys:@"1.1.1.1", @"LocalIP", @"2.2.2.2", @"ExternalIP", nil];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"RequestType",
//                             @"959788595",@"WalletID",
//                             @"67890",@"RequestID",
//                             @"my msg", @"CustomMsg",
//                             reqPayload, @"ReqPayload", nil];
//        
//        [RemoteNotificationHandler handleRemoteNotificaitonPayload:dic];
//    }
    [self.tblView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pendingRequests.count;
}

static NSString *CellIdentifier = @"pendingReqCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    BARemoteNotificationData *d = [self.pairingData.pendigNotifications objectAtIndex:indexPath.row];
    // Tags:
    //      10) label
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:10];
    [lbl setText:[NSString stringWithFormat:@"what %d", indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.pairingData removePendigNotificationsObject:[self.pairingData.pendigNotifications objectAtIndex:indexPath.row]];
        [BAPairingData _saveContext];
        [self.tblView reloadData];
    }
}

@end
