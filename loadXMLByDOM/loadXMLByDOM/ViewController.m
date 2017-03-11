//
//  ViewController.m
//  loadXMLByDOM
//
//  Created by 梁家伟 on 17/3/9.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "Video.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray* videosArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _videosArray = [NSMutableArray array];
    [self loadXMLWithGData];
    
    NSLog(@"%@",_videosArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadXMLWithGData{
    
    
    NSURL* url = [NSURL URLWithString:@"http://127.0.0.1/videos02.xml"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"出错信息:%@",error);
        }
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:data error:nil];
        //遍历根节点下的子节点
        for (GDataXMLElement* element in doc.rootElement.children) {
            
            Video* video = [Video new];
            
            //遍历子节点的 元素节点
            for (GDataXMLElement* node in element.children) {
                [video setValue:node.name forKey:node.stringValue];
            }
            
            for (GDataXMLNode* nodeAttr in element.attributes) {
                [video setValue:nodeAttr.name forKey:nodeAttr.stringValue];
            }
            
            [_videosArray addObject:video];
        }
        
    }] resume];
  
    
    
}


@end
