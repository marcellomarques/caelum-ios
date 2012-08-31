//
//  ContatosNoMapaViewControllerViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"
#import "ContatosNoMapaViewControllerViewController.h"
#import "Mapkit/MKUserTrackingBarButtonItem.h" 

//@interface ContatosNoMapaViewControllerViewController ()
//
//@end

@implementation ContatosNoMapaViewControllerViewController

@synthesize mapa, contatos;

- (id) init {
    self = [super init];
    if (self) {
        UIImage *imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0];
        
        self.tabBarItem = tabItem;
        self.title = @"Localização";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.mapa addAnnotations:contatos];
}

- (void) viewDidDisappear:(BOOL)animated {
    [self.mapa removeAnnotations:contatos];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{     
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
}

- (void)viewDidUnload
{
    [self setMapa:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *identifier = @"pino";
    
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pino) {
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        pino.annotation = annotation;
    }
    
    Contato *contato = (Contato *) annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;
    
    if (contato.foto) {
        UIImageView *imageContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imageContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imageContato;
    }

return pino;
}

@end
