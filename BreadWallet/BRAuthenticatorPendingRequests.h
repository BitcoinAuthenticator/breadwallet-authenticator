//
//  BRAuthenticatorPendingRequests.h
//  BreadWallet
//
//  Created by alon muroch on 2/28/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Authenticator/BAPairingData.h>

@interface BRAuthenticatorPendingRequests : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property(nonatomic, strong) BAPairingData *pairingData;

@end
