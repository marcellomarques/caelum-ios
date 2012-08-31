//
//  ViewController.h
//  OlaMundo
//
//  Created by ios2971 on 20/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, weak) IBOutlet UILabel *meuLabel;

@property(nonatomic, weak) IBOutlet UITextField *meuTextField;

- (IBAction)atualizaLabel : (id)sender;

- (IBAction)somaBrasil : (id)sender;



@property(nonatomic, weak) IBOutlet UITextField *valor1Label, *valor2Label;

@property(nonatomic, weak) IBOutlet UILabel *resultadoLabel;



@property(nonatomic, weak) IBOutlet UISlider *slider1, *slider2;

- (IBAction)alteraValorSlider1:(id)sender;
- (IBAction)alteraValorSlider2:(id)sender;

- (IBAction)atualizaSlider1:(id)sender;
- (IBAction)atualizaSlider2:(id)sender;

@end
