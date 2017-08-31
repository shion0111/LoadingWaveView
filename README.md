# LoadingwaveView
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wavedetail.gif" width="320"/>
</p>



## Usage
Copy the LoadingwaveView files to your project

### With countdown time 
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wave.gif" height="480"/>
</p>

```objective-c
#import "LoadingwaveView.h" 
    
- (IBAction)showLoading:(id)sender {
    LoadingwaveView *loading = [[LoadingwaveView alloc] initWithTitle:@"Loading..." 
                                                        countdown:5.5 waveColor:UIColor.purpleColor] ;
    [self.view addSubview:loading];
}
```
<p align="center">
  <img src="https://raw.githubusercontent.com/shion0111/LoadingWaveView/master/wave1.gif" height="480"/>
</p>

```objective-c
#import "LoadingwaveView.h" 
    
- (IBAction)showLoading:(id)sender {
    LoadingwaveView *loading = [[LoadingwaveView alloc] initWithTitle:@"Loading..." waveColor:UIColor.purpleColor] ;
    [self.view addSubview:loading];
}
```
