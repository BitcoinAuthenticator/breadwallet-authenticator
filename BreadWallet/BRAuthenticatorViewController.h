//
//  BRAuthenticatorViewController.h
//  BreadWallet
//
//  Created by alon muroch on 2/27/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRAuthenticatorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblExplanation;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
