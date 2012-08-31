//
//  DCUltimosTweetsViewController.m
//  Twitter
//
//  Created by Diego Chohfi on 8/30/12.
//  Copyright (c) 2012 Diego Chohfi. All rights reserved.
//

#import "DCUltimosTweetsViewController.h"
#import "DCTweet.h"
@interface DCUltimosTweetsViewController ()

@end

@implementation DCUltimosTweetsViewController
@synthesize ultimosTweets;

-(void)viewDidLoad{
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=dchohfi&count=100"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSMutableArray *tweets = [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingMutableContainers
                                      error:nil];
    self.ultimosTweets = [[NSMutableDictionary alloc] init];
    for(NSDictionary *tweetDict in tweets){
        DCTweet *tweet = [[DCTweet alloc] init];
        tweet.text = [tweetDict objectForKey:@"text"];
        
        
        int indice = [tweets indexOfObject:tweetDict];
        if(indice % 2 == 0){
            [self addObject:tweet forKey:@"Par"];
        }else{            
            [self addObject:tweet forKey:@"Impar"];
        }
    }
    
}
- (void) addObject: (DCTweet *) tweet forKey: (NSString *) chave {
    NSMutableArray *tweets = [self.ultimosTweets objectForKey:chave];
    if(!tweets){
        tweets = [[NSMutableArray alloc] init];
        [self.ultimosTweets setObject:tweets forKey:chave];
    }
    [tweets addObject:tweet];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.ultimosTweets allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *parOuImpar = [[self.ultimosTweets allKeys] objectAtIndex:section];
    NSMutableArray *tweets = [self.ultimosTweets objectForKey:parOuImpar];
    return [tweets count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *parOuImpar = [[self.ultimosTweets allKeys] objectAtIndex:indexPath.section];
    NSMutableArray *tweets = [self.ultimosTweets objectForKey:parOuImpar];
    DCTweet *tweet = [tweets objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = tweet.text;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *parOuImpar = [[self.ultimosTweets allKeys] objectAtIndex:section];
    return parOuImpar;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"FIM DA PARADA";
}
@end
