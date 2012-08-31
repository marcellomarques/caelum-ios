//
//  AppDelegate.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ContatoFormViewController.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewControllerViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize contatos = _contatos;
@synthesize arquivoContatos = _arquivoContatos;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    // Obtem o caminho absoluto para gravar o arquivo
    NSArray *usersDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [usersDirs objectAtIndex:0];
    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos", documentDir];
    
    // Inicializa o array dos contatos
    //_contatos = [NSMutableArray array]; // Maneira anterior de passar a referencia da lista de contatos
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
    if (!self.contatos || self.contatos.count == 0)
    {
        self.contatos = [NSMutableArray array];
    }
    
    // Inicializa a tela de listagem de contatos e passa a referencia para o componente
    // UINavigationController, e a referencia do ultimo para o self window.
    ListaContatosViewController *lista = [[ListaContatosViewController alloc] init]; 

        
    // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];
    // [[self window] setRootViewController:nav];

    
    // Passa a referencia do array dos contatos para o ListaContatosViewController
    [lista setContatos:[self contatos]];
    
    self.window.backgroundColor = [UIColor blackColor];

    UINavigationController *listaNavigation = [[UINavigationController alloc] initWithRootViewController:lista];
                                               
    ContatosNoMapaViewControllerViewController *contatosMapa = [[ContatosNoMapaViewControllerViewController alloc] init];
    
    contatosMapa.contatos = self.contatos;
    
    UINavigationController *mapaNavigation = [[UINavigationController alloc] initWithRootViewController:contatosMapa];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:listaNavigation, mapaNavigation, nil];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    sleep(1);
    
    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
//    (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}

@end
