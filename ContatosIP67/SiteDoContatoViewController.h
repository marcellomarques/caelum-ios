//
//  SiteDoContatoViewController.h
//  ContatosIP67
//
//  Created by ios2971 on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface SiteDoContatoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *web;

@property (strong, nonatomic) Contato *contato;

- (id) initWithContato: (Contato *) c;

@end
