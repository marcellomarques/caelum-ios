//
//  ContatosNoMapaViewControllerViewController.h
//  ContatosIP67
//
//  Created by ios2971 on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewControllerViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@property (strong, nonatomic) NSMutableArray *contatos;

@end
