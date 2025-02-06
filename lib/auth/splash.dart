import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _fadeAnimation;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    // Initialize the video controller
    _videoController = VideoPlayerController.asset('assets/88.webm')
      ..initialize().then((_) {
        setState(() {}); // Update the UI once the video is initialized
        _videoController.play(); // Start playing the video
        _videoController.setLooping(true); // Loop the video
      });

    // Start the animation
    _controller!.forward();

    // Navigate to Onboarding screen after a delay
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(Duration(seconds: 4)); // Wait for 4 seconds
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _videoController.dispose(); // Dispose the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive setup
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    // MediaQuery for responsive layout
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 255, 255), // White
                  Color.fromARGB(255, 250, 250, 250), // Light gray
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered Column with video and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Video with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        )
                      : CircularProgressIndicator(), // Show a loader while the video is initializing
                ),

                SizedBox(height: 20.h),

                // Text with fade animation
                // FadeTransition(
                //   opacity: _fadeAnimation,
                //   child: Text(
                //     'ACLUB',
                //     style: TextStyle(
                //       fontSize: 32.sp,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //       letterSpacing: 1.5,
                //       shadows: [
                //         Shadow(
                //           offset: Offset(1.5, 1.5),
                //           blurRadius: 5.0,
                //           color: Colors.black45,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(height: 25.h),

                // Circular loading indicator with fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}