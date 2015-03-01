//
//  BRAuthenticatorViewController.h
//  BreadWallet
//
//  Created by alon muroch on 2/27/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRScanViewController.h"

@interface BRAuthenticatorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AVCaptureMetadataOutputObjectsDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) IBOutlet UILabel *lblExplanation;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (nonatomic, strong) BRScanViewController *scanController;

@end
