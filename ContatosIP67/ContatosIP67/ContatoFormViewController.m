//
//  ContatoFormViewController.m
//  ContatosIP67
//
//  Created by ios2971 on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ContatoFormViewController.h"
#import "Contato.h"

@implementation ContatoFormViewController
@synthesize scroll;

@synthesize nomeTextField, telefoneTextField, emailTextField, enderecoTextField, siteTextField, twitterTextField, botaoFoto, latitudeTextField, longitudeTextField;
@synthesize contatos = _contatos;
@synthesize contato;
@synthesize delegate;
@synthesize campoAtual;

// sobreescrita do metodo init para quando a tela for criada, tambem iniciara o array.
- (id) init {
    self = [super init];
    if (self) {
        
        [[self navigationItem] setTitle:@"Cadastro"];
        
        UIBarButtonItem *botaoCancelar = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self action:@selector(ocultaFormulario)];
                                    
        UIBarButtonItem *botaoConfirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self action:@selector(criaContato)];
        
        [[self navigationItem] setLeftBarButtonItem:botaoCancelar];
        [[self navigationItem] setRightBarButtonItem:botaoConfirmar];
    }
    return self;
}

- (id) initWithContato:(Contato *)_contato {
    self = super.init;
    if (self)
    {
        self.contato = _contato;
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] 
                                      initWithTitle:@"Confirmar" 
                                      style:UIBarButtonItemStylePlain 
                                      target:self 
                                      action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
    }
    return self;
}


- (void) ocultaFormulario {
    [self dismissModalViewControllerAnimated:YES];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.contato) {
        nomeTextField.text = contato.nome;
        telefoneTextField.text = contato.telefone;
        emailTextField.text = contato.email;
        enderecoTextField.text = contato.endereco;
        siteTextField.text = contato.site;
        twitterTextField.text = contato.twitter;
        latitudeTextField.text = [contato.latitude stringValue];
        longitudeTextField.text = [contato.longitude stringValue];
        
        if (contato.foto) {
            [botaoFoto setImage:contato.foto forState:UIControlStateNormal];
        }
    }
}

- (void) viewDidUnload {
    [self setScroll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;  
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// metodo responsavel por receber os dados do formulario e retornar um objeto Contato totalmente preenchido.
- (Contato *) pegaDadosDoFormulario {
    if (!self.contato) {
        contato = [Contato new];
    }
    
    if (botaoFoto.imageView.image) {
        contato.foto = botaoFoto.imageView.image;
    }
    
    [contato setNome:[nomeTextField text]];
    [contato setTelefone:[telefoneTextField text]];
    [contato setEmail:[emailTextField text]];
    [contato setEndereco:[enderecoTextField text]];
    [contato setSite:[siteTextField text]];
    [contato setTwitter:[twitterTextField text]];
    [contato setLatitude:[self numberWithString:[[self latitudeTextField] text]]];
    [contato setLongitude:[self numberWithString:[[self longitudeTextField] text]]];
    
    return contato;
}

- (NSNumber *) numberWithString: (NSString *) texto {
    return [NSNumber numberWithFloat:[texto floatValue]];
}

// metodo responsavel por verificar quando o proximo textfield devera ser acionado, ou receber
// a responsabilidade de controle sobre o keyboard.
- (IBAction) proximoElemento:(UITextField *)textField {
    // Campos em ordem na tela: nome, telefone, email, endereco, site, twitter.
    
    if (textField == [self nomeTextField]) {
        [[self telefoneTextField] becomeFirstResponder];
    } else if (textField == [self telefoneTextField]) {
        [[self emailTextField] becomeFirstResponder];
    } else if (textField == [self emailTextField]) {
        [[self enderecoTextField] becomeFirstResponder];
    } else if (textField == [self enderecoTextField]) {
        [[self latitudeTextField] becomeFirstResponder];
    } else if (textField == [self latitudeTextField]) {
        [[self longitudeTextField] becomeFirstResponder];
    } else if (textField == [self longitudeTextField]) {
        [[self siteTextField] becomeFirstResponder];    
    } else if (textField == [self siteTextField]) {
        [[self twitterTextField] becomeFirstResponder];
    } else if  (textField == [self twitterTextField]) {
        [[self twitterTextField] resignFirstResponder];
    }
    
}

- (IBAction) selecionaFoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Camera Disponivel
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

- (IBAction) buscarCoordenadas:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:enderecoTextField.text completionHandler:^(NSArray *resultados, NSError *error) {
        if (error == nil && [resultados count] > 0) {
            CLPlacemark *resultado = [resultados objectAtIndex:0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            latitudeTextField.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
            longitudeTextField.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
        }
    }];
}   

- (void) criaContato {
    Contato *novoContato = [self pegaDadosDoFormulario];
    if (self.delegate) {
        [self.delegate contatoAdicionado:novoContato];   
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void) atualizaContato {
    Contato *contatoAtualizado = [self pegaDadosDoFormulario];
    if (self.delegate) {
        [self.delegate contatoAtualizado:contatoAtualizado];   
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)tecladoApareceu: (NSNotification *)notification {
    NSLog(@"Um teclado qualquer apareceu na tela");
    NSDictionary *info = [notification userInfo];
    CGRect areaDoTeclado = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize tamanhoTeclado = areaDoTeclado.size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, tamanhoTeclado.height, 0.0);
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
    
    if (campoAtual != NULL) {
        CGFloat tamanhoDosElementos = tamanhoTeclado.height + self.navigationController.navigationBar.frame.size.height;
        CGRect tamanhoDaTela = self.view.frame;
        tamanhoDaTela.size.height -= tamanhoDosElementos;
        
        BOOL campoAtualSumiu = !CGRectContainsPoint(tamanhoDaTela, campoAtual.frame.origin);
        
        if (campoAtualSumiu) {
            CGFloat tamanhoAdicional = tamanhoTeclado.height - self.navigationController.navigationBar.frame.size.height;
            
            CGPoint pontoVisivel = CGPointMake(0.0, campoAtual.frame.origin.y - tamanhoAdicional);
            
            [scroll setContentOffset:pontoVisivel animated:YES];
            
            CGSize scrollContentSize = scroll.contentSize;
            
            scrollContentSize.height += tamanhoAdicional;
            
            [scroll setContentSize:scrollContentSize];
        }
    }
}

- (void)tecladoSumiu: (NSNotification *)notification {
    NSLog(@"Um teclado qualquer sumiu da tela");
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
    [scroll setContentOffset:CGPointZero animated:YES];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    campoAtual = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    campoAtual = nil;
}

@end
