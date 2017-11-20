//
//  ListJacksonVC.m
//  eJackson
//
//  Created by Galileo Guzman on 11/20/17.
//  Copyright © 2017 Galileo Guzman. All rights reserved.
//

#import "ListJacksonVC.h"

@interface ListJacksonVC ()

@property (nonatomic, strong) NSMutableArray* songs;
@property (nonatomic, strong) ArtistModel* songSelected;
@property (nonatomic, strong) UIRefreshControl* refreshTableControl;
@end

@implementation ListJacksonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)initController{
    // ------------------------------------------------------------------------------
    // ADDING REFRESH CONTROL FOR TABLE VIEW
    // ------------------------------------------------------------------------------
    self.refreshTableControl = [[UIRefreshControl alloc]init];
    self.refreshTableControl.backgroundColor = [UIColor clearColor];
    self.refreshTableControl.tintColor = [UIColor grayColor];
    [self.tblContent addSubview:self.refreshTableControl];
    [self.refreshTableControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    [self setupNavigationBar];
    
    self.songs = [[NSMutableArray alloc] init];
    
    [self queueLoadData];
    
}
-(void)setupNavigationBar{
    [self.tblContent setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height,0,0,0)];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueDetailArticle"]) {
        
//        // Get destination view
//        DeatilNewController *vc = [segue destinationViewController];
//
//        // Pass the information to your destination view
//        [vc setArticle:self.articleSelected];
    }
}

/**********************************************************************************************/
#pragma mark - Table delegate methods
/**********************************************************************************************/
//-------------------------------------------------------------------------------

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (1)
        
    {
        
        //1. Setup the CATransform3D structure
        
        CATransform3D rotation;
        
        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
        
        rotation.m34 = 1.0/ -600;
        
        
        
        //2. Define the initial state (Before the animation)
        
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        
        cell.alpha = 0;
        
        
        
        cell.layer.transform = rotation;
        
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        
        
        //3. Define the final state (After the animation) and commit the animation
        
        [UIView beginAnimations:@"rotation" context:NULL];
        
        [UIView setAnimationDuration:0.4];
        
        cell.layer.transform = CATransform3DIdentity;
        
        cell.alpha = 1;
        
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        
        
        
        //Reassure that cell its in its place (WaGo)
        
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        
        [UIView commitAnimations];
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CardCell";
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    
    
    ArtistModel *p = [ArtistModel alloc];
    p = self.songs[indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:p.artworkUrl100]]];
        NSLog(@"Artist url image %@", p.artworkUrl60);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // assign cell image on main thread
            cell.imgNew.image = img;
        });
    });
    
    cell.lblTitle.text = p.artistName;
    cell.lblSummary.text = p.trackCensoredName;
    
    cell.lblPublishDate.text = [NSString stringWithFormat:@"Price $ %@ USD",p.trackPrice];
    
    
    
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.articleSelected = self.news[indexPath.row];
//    [self performSegueWithIdentifier:@"segueDetailArticle" sender:self];
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *visibleCells = [self.tblContent visibleCells];
    
    for(CardCell *cell in visibleCells){
        [cell cellOnTableView:self.tblContent didScrollOnView:self.view];
    }
}

#pragma mark - Queue for load data
-(void)queueLoadData
{
    NSOperationQueue *queue         = [NSOperationQueue new];
    NSInvocationOperation *opInit = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(initLoadData) object:nil];
    [queue addOperation:opInit];
    
    NSInvocationOperation *opGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadRequest) object:nil];
    [opGet addDependency:opInit];
    [queue addOperation:opGet];
    
    NSInvocationOperation *opDidGet = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(didLoadData) object:nil];
    [opDidGet addDependency:opGet];
    [queue addOperation:opDidGet];
}

-(void)initLoadData{
    //self.songs = (NSMutableArray <NewModel>*) [MemoryServices readCustomArrayFromFile:FILEArticles];
}
-(void)loadRequest{
    [WebServices getJacksonWithCompletionHandler:^(NSMutableArray *response) {
        self.songs = (NSMutableArray <ArtistModel>*) response;
        
        [self didLoadData];
    }];
}

- (void)didLoadData {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadCurrentTable];
    });
    
    // ------------------------------------------------------------------------------
    // REFRESCH CONTROL FOR TABLE ANIMATION
    // ------------------------------------------------------------------------------
    if (self.refreshTableControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];;
        [formatter setDateFormat:@"MMMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last updated: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor grayColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title.capitalizedString attributes:attrsDictionary];
        self.refreshTableControl.attributedTitle = attributedTitle;
        
        [self.refreshTableControl endRefreshing];
    }
}

- (void) reloadCurrentTable {
    [self.tblContent reloadData];
}

// ------------------------------------------------------------------------------
#pragma mark - REFRESH TABLE VIEW
// ------------------------------------------------------------------------------
-(void)refreshTableView{
    [self queueLoadData];
}

@end
