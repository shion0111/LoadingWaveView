# LoadingwaveView
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wavedetail.gif" width="320"/>
</p>



## Usage
Copy the LoadingwaveView.h and LoadingwaveView.w files to your project

### With countdown time 
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wave.gif" height="320"/>
</p>

```objective-c
#import "LoadingwaveView.h" 
    
- (IBAction)showLoading:(id)sender {
    LoadingwaveView *loading = [[LoadingwaveView alloc] initWithTitle:@"Loading..." 
                                                        countdown:5.5 waveColor:UIColor.purpleColor] ;
    [self.view addSubview:loading];
}
```
### Without countdown time
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wave1.gif" height="320"/>
</p>

```objective-c
#import "LoadingwaveView.h" 

@interface ViewController()
@property (nonatmoic) LoadingwaveView *loading;
@end

- (IBAction)showLoading:(id)sender {
    _loading = [[LoadingwaveView alloc] initWithTitle:@"Loading..." waveColor:UIColor.purpleColor] ;
    [self.view addSubview:loading];
}
- (IBAction)dismissLoading:(id)sender {
  [_loading dismiss];
  _loading = nil;
}
```
