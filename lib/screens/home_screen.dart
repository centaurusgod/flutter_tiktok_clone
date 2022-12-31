import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late bool playPauseStatusIndicator;
  String _videoURL = "";
  double _initialVolumeSlider = 0.5;
  bool _isMuted = false;
  bool _volumeMax = false;
  bool _isVisibleVolumeSlider = false;
  double _copyInitialVolumeSlider = 0.5;

  int defaultIndexVideoPlay = 0;

//not sure if this works like this
  List<String> _videoURLs = List.empty(growable: true);

//final

  @override
  void initState() {
    _videoURL = 'assets/images/sample_video2.mp4';

    //lets add some default asset values to list<string> videoURLS
    {
      _videoURLs.add('assets/images/sample_video.mp4');

      _videoURLs.add('assets/images/butterfly.mp4');
      _videoURLs.add('assets/images/sample_video2.mp4');
    }

    _controller = VideoPlayerController.asset(_videoURLs[0]);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1);
    playPauseStatusIndicator = true;
    //   _volumeIcon = Icon(
    //   Icons.volume_down_rounded,
    //   //size: getDeviceScreenHeight / 21,
    //   color: Colors.white,
    // );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getDeviceScreenHeight = MediaQuery.of(context).size.height;
    final getDeviceScreenWidth = MediaQuery.of(context).size.height;
    //  _volumeIcon = Icon(
    //   Icons.volume_down_rounded,
    //   //size: getDeviceScreenHeight / 21,
    //   color: Colors.white,
    // );
    //setBooleanToFalseAfterOneSecond();
   // hideVolumeSliderAfterOneSecond();
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  log(_videoURLs[value]);
                  playPauseStatusIndicator = false;

                  _controller = VideoPlayerController.asset(_videoURLs[value]);
                  _initializeVideoPlayerFuture = _controller.initialize();
                  _controller.play();
                });
                // _controller.play();
              },
              scrollDirection: Axis.vertical,
              children: [
                demoContainer(context),
                demoContainer(context),
                demoContainer(context),
              ],
            ),
            Visibility(
              visible: playPauseStatusIndicator,
              child: GestureDetector(
                onTap: () {
                  playPauseStatusIndicator = !playPauseStatusIndicator;
                 // _isVisibleVolumeSlider=!_isVisibleVolumeSlider;
                // setBooleanToFalseAfterOneSecond();
                  
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 75.0,
                    color: Colors.white.withOpacity(0.65),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: getDeviceScreenHeight / 6,
              right: 10,

              //left:50.0,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _isVisibleVolumeSlider,
                   // disappearanceDuration: Duration(seconds: 1),

                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                       
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                         color: Colors.black.withOpacity(0.45),
                        ),
                        width: getDeviceScreenWidth/4,
                        
                        child: Slider(
                          value: _initialVolumeSlider,
                          min: 0.0,
                          max: 1.0,
                          onChanged: ((value) {
                            //hideVolumeSliderAfterOneSecond();
                            setState(() {
                              //initialSliderX = value;
                              _initialVolumeSlider = value;
                              _controller.setVolume(value);
                              log(value.toString());
                              if (value == 0.0 || value<0.1 ) {
                                _isMuted = true;
                              } 
                                if (value > 0.7) {
                                  _volumeMax = true;
                                  _isMuted=false;
                                }
                                else{
                                  _volumeMax=false;
                                  _isMuted=false;

                                }
                              });
                              // if (value > 0.7) {
                              //   // _volumeIcon = Icon(
                              //   //   Icons.volume_mute,
                              //   //   size: getDeviceScreenHeight / 21,
                              //   //   color: Colors.white,
                              //   // );
                              // }
                          
                            //print(roundIntX);
                            //roundIntX = (initialSliderX * 100).toInt();
                            //print(roundIntX);
                          }),
                          inactiveColor: Color.fromARGB(255, 255, 255, 255),
                          activeColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _copyInitialVolumeSlider = _initialVolumeSlider;
                      setState(() {
                         _isVisibleVolumeSlider=!_isVisibleVolumeSlider;
                         
                      //  _initialVolumeSlider = 0.0;
                       // _controller.setVolume(0.0);
                       // _isMuted = !_isMuted;

                        _volumeMax=false;
                       // hideVolumeSliderAfterOneSecond();
                          
                      });
                      hideVolumeSliderAfterOneSecond();
                    },
                    icon: (_isMuted || _initialVolumeSlider == 0)
                        ? Icon(
                            Icons.volume_off,
                            size: getDeviceScreenHeight / 21,
                            color: Colors.white,
                          )
                        : (!_volumeMax)
                            ? Icon(
                                Icons.volume_down_rounded,
                                size: getDeviceScreenHeight / 20,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.volume_up,
                                size: getDeviceScreenHeight / 21,
                                color: Colors.white,
                              ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                color: Colors.transparent,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconSize: 25.0,
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          icon: Icon(
                            Icons.home_rounded,
                            // color: Colors.white,
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          icon: Icon(
                            Icons.search_rounded, //color: Colors.white,
                          ),
                          // title: Text('Search'),
                          label: "Discover"),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.transparent,
                          icon: Image.asset(
                            'assets/images/video_add.png',
                            width: getDeviceScreenWidth / 20,
                            height: getDeviceScreenHeight / 25,
                          ),
                          label: ""
                          //title: Text('Settings'),
                          ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.message,
                          //color: Colors.white,
                        ),
                        label: "Inbox",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          //color: Colors.white,
                        ),
                        label: "Me",
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white,
                    selectedFontSize: 14.0,
                    unselectedFontSize: 14.0,
                    selectedIconTheme: IconThemeData(color: Colors.white),
                    unselectedIconTheme: IconThemeData(color: Colors.white),
                    selectedLabelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.w800,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.w700,
                    ),
                    onTap: ((value) {
                      _selectedIndex = value;
                      log(_selectedIndex.toString());
                      setState(() {
                        _selectedIndex = value;
                      });
                    }),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Container demoContainer(BuildContext context) {
    final getDeviceScreenHeight = MediaQuery.of(context).size.height;
    final getDeviceScreenWidth = MediaQuery.of(context).size.height;

    return Container(
        height: getDeviceScreenHeight,
        width: getDeviceScreenWidth,
        //  color: Color.fromARGB(255, 70, 0, 65),
        color: Colors.transparent,
        //  child:  Text(
        //     'Home Screen',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 25.0,
        //     ),
        //   ),
        //  child: Image.asset('assets/images/tiktok_lite_icon.png', height: getDeviceScreenHeight, width: getDeviceScreenWidth,),

        // child:  VideoPlayer(_controller)
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: GestureDetector(
                    onTap: () {
                   
                      playPauseStatusIndicator = !playPauseStatusIndicator;
                    
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: VideoPlayer(_controller)),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
  void hideVolumeSliderAfterOneSecond() {
   
  Future.delayed(const Duration(milliseconds: 2500), () {
    setState(() {
      _isVisibleVolumeSlider=false;
    });
  });
}
}
