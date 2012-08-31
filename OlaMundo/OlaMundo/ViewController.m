//
//  ViewController.m
//  OlaMundo
//
//  Created by ios2971 on 20/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController ()

//@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@synthesize meuLabel, meuTextField;

- (IBAction)atualizaLabel:(id)sender {
    [meuLabel setText:[meuTextField text]];
}



@synthesize valor1Label, valor2Label, resultadoLabel;

- (IBAction)somaBrasil:(id)sender {
    float val1 = [[valor1Label text] floatValue];
    float val2 = [[valor2Label text] floatValue];
    
    float soma = val1 + val2;
    [resultadoLabel setText: [NSString stringWithFormat: @"%.2f", soma]];
    
    NSLog(@"Soma de %.2f e %.2f eh igual a %.2f", val1, val2, soma);

}




@synthesize slider1, slider2;

- (IBAction)alteraValorSlider1:(id)sender {
    float valorSlider = [slider1 value];
    NSString *valorSliderStr = [NSString stringWithFormat:@"%.2f", valorSlider];
    [valor1Label setText: valorSliderStr];
}

- (IBAction)alteraValorSlider2:(id)sender {
    float valorSlider = [slider2 value];
    NSString *valorSliderStr = [NSString stringWithFormat:@"%.2f", valorSlider];
    [valor2Label setText: valorSliderStr];
}

- (IBAction)atualizaSlider1:(id)sender {
    float valor = [[valor1Label text] floatValue];
    [slider1 setValue: valor];
}

- (IBAction)atualizaSlider2:(id)sender {
    float valor = [[valor2Label text] floatValue];
    [slider2 setValue: valor];
}

@end
