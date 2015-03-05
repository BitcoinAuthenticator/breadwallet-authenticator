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
         }
      }];
}

- (IBAction)rename:(id)sender {
//    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:NSLocalizedString(@"warning", nil) andMessage:NSLocalizedString(@"rename pairing alert msg", nil)];
//    
//    UITextView *txv = [[UITextView alloc] init];
//    [alertView addSubview:txv];
    
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
