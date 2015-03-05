//
//  BRAuthenticatorViewController.m
//  BreadWallet
//
//  Created by alon muroch on 2/27/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import "BRAuthenticatorViewController.h"
#import "BRAuthenticatorPendingRequests.h"
#import <Authenticator/BAPairingProtocol.h>
#import <Authenticator/Authenticator.h>
#import <Authenticator/NSManagedObject+Manager.h>

@interface BRAuthenticatorViewController ()

@end

@implementation BRAuthenticatorViewController

NSArray *pairings;
int lastSelectedPairingIdx;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.lblExplanation setText:NSLocalizedString(@"Authenticator Explanation", nil)];
    self.scanController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
    [self loadPairingsData];
    
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

- (BOOL)nextTip
{
    return NO; // so to always perform segue
}

#pragma Data model changes callback

- (void)handleDataModelChange:(NSNotification *)note
{
    [self loadPairingsData];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     BRAuthenticatorPendingRequests *v = (BRAuthenticatorPendingRequests *)[[segue destinationViewController] topViewController];
     v.pairingData = [pairings objectAtIndex:lastSelectedPairingIdx];
 }

#pragma UITableView data source + delegate

-(void)loadPairingsData
{
    pairings = [BAPairingData _allObjects];
    [self.tblView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pairings == nil? 0:[pairings count];
}

static NSString *CellIdentifier = @"authenticatorWalletCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    BAPairingData *d = [pairings objectAtIndex:indexPath.row];
    // Configure Cell
    // Tags:
    //      10) image view
    //      11) Wallet name label
    //      12) wallet id label
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
    [label setText:d.pairingName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastSelectedPairingIdx = (int)indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma Pairing

-(IBAction)pairAuthenticator:(id)sender
{
    [sender setEnabled:NO];
    self.scanController.delegate = self;
    self.scanController.transitioningDelegate = self;
    [self.navigationController presentViewController:self.scanController animated:YES completion:nil];
}

#pragma AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataMachineReadableCodeObject *o in metadataObjects) {
        if (! [o.type isEqual:AVMetadataObjectTypeQRCode]) continue;
        
        NSString *s = o.stringValue;
        
        BAPairingProtocol *pairingProtocolo = [Authenticator pair:s];
        if([pairingProtocolo isValid])
        {
            [pairingProtocolo pairingData];
            pairings = [BAPairingData _allObjects];
            // will update the table via NSNotificationCenter
            
            self.scanController.cameraGuide.image = [UIImage imageNamed:@"cameraguide-green"];
            [self.scanController stop];
            [self resetQRGuide];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.35 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    [self resetQRGuide];
                }];
            });
        }
        else {
            self.scanController.cameraGuide.image = [UIImage imageNamed:@"cameraguide-red"];
            self.scanController.message.text = NSLocalizedString(@"Not an Authenticator pairing QR", nil);
            [self performSelector:@selector(resetQRGuide) withObject:nil afterDelay:0.35];
        }
        
        NSLog(@"");
        
        break;
    }
}

- (void)resetQRGuide
{
    self.scanController.message.text = nil;
    self.scanController.cameraGuide.image = [UIImage imageNamed:@"cameraguide"];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

// This is used for percent driven interactive transitions, as well as for container controllers that have companion
// animations that might need to synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

// This method can only be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *v = transitionContext.containerView;
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey],
    *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UILabel *lbl = self.lblExplanation;
    UIView *guide = self.scanController.cameraGuide;
    
    [self.scanController.view layoutIfNeeded];
    
    if (to == self.scanController) {
        [v addSubview:to.view];
        to.view.frame = from.view.frame;
        to.view.center = CGPointMake(to.view.center.x, v.frame.size.height*3/2);
        guide.transform = CGAffineTransformMakeScale(lbl.bounds.size.width/guide.bounds.size.width,
                                                     lbl.bounds.size.height/guide.bounds.size.height);
        guide.alpha = 0;
        
        [UIView animateWithDuration:0.1 animations:^{
            lbl.alpha = 0.0;
            guide.alpha = 1.0;
        }];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.8
              initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                  to.view.center = from.view.center;
              } completion:^(BOOL finished) {
                  lbl.alpha = 1.0;
                  [transitionContext completeTransition:YES];
              }];
        
        [UIView animateWithDuration:0.8 delay:0.15 usingSpringWithDamping:0.5 initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                guide.transform = CGAffineTransformIdentity;
                            } completion:^(BOOL finished) {
                                [to.view addSubview:guide];
                            }];
    }
    else {
        [v insertSubview:to.view belowSubview:from.view];
//        [self cancel:nil];
        
        [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                guide.transform = CGAffineTransformMakeScale(lbl.bounds.size.width/guide.bounds.size.width,
                                                                             lbl.bounds.size.height/guide.bounds.size.height);
                                guide.alpha = 0.0;
                            } completion:^(BOOL finished) {
                                guide.transform = CGAffineTransformIdentity;
                                guide.alpha = 1.0;
                            }];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] - 0.15 delay:0.15
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                from.view.center = CGPointMake(from.view.center.x, v.frame.size.height*3/2);
                            } completion:^(BOOL finished) {
                                [transitionContext completeTransition:YES];
                            }];
    }
}

@end
