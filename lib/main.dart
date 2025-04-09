import 'package:flutter/material.dart';
//デバイスごとのUI比重を調整するためのパッケージ
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onigiri_app/1.Hotel/Hotel_page.dart';
import 'package:onigiri_app/2.Restaurant/Restaurant.dart';
import 'package:onigiri_app/3.Phone inquiries/Inquire by phone2.dart';
import 'package:onigiri_app/4.Shopping/Shopping_page.dart';
import 'package:onigiri_app/5.Food Takeaways/Take away_page.dart';
import 'package:onigiri_app/6.Shopping2/Shopping 2_page.dart';
import 'package:onigiri_app/7.Kamakura/Go to Kamakura_page.dart';
import 'package:onigiri_app/8.Fast food/Fast food_page.dart';
import 'package:onigiri_app/9.Asking for/Ask recommendation_page.dart';
import 'package:onigiri_app/Grammer/grammer_chart.dart';
import 'package:onigiri_app/Numbers/Numbers.dart';
import 'package:onigiri_app/colors.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences インスタンスを取得
  final prefs = await SharedPreferences.getInstance();

  // `isFirstLaunch` フラグを取得（存在しない場合は `true` をデフォルトにする）
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  // Flutter アプリを起動
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Onigiri',
          theme: ThemeData(
            primaryColor: AppColors.turquoiseBlue,
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
              // 以下の行で全体のテキストの色を白に設定します
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
          home: isFirstLaunch ? OnboardingScreen() : Home(),
        );
      },
    );
  }
}

//Introductionの下のドット
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color = AppColors.turquoiseBlue,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;

  Widget _buildDot(int index) {
    bool isSelected = controller.page?.round() == index;

    double width =
        isSelected ? 20.0 : 8.0; // 選択されているドットは24.0の幅に、そうでない場合は8.0の幅にします。

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0), // ここでドット間の間隔を調整します。
      height: 8.0,
      width: width,
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final divisionHeight = screenHeight / 5;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_1.png')),
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_2.png')),
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_3.png')),
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_4.png')),
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_5.png')),
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/introduction_6.png')),
              ),
              Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset('assets/images/introduction_7.png'),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.1, // 画面幅の5%の右マージン
                          bottom: MediaQuery.of(context).size.height * 0.3, // 画面高の5%の下マージン
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            // チュートリアル終了時に `isFirstLaunch` フラグを false に更新
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isFirstLaunch', false);

                            // ホーム画面に移動
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          },
                          child: Text('Get Started'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: DotsIndicator(
              controller: _controller,
              itemCount: 7,
              onPageSelected: (int page) {
                _controller.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
          ),
          //イントロダクションをスキップするためのボタンを配置
          // AnimatedBuilder(
          //   animation: _controller,
          //   builder: (context, child) {
          //     // ページコントローラの値に基づいて右のマージンを計算
          //     double rightMargin = 20 +
          //         (MediaQuery.of(context).size.width *
          //             (_controller.page ?? 0.0));
          //     return Positioned(
          //       top: 70,
          //       right: rightMargin,
          //       child: TextButton(
          //         onPressed: () {
          //           Navigator.pushReplacement(
          //             context,
          //             MaterialPageRoute(builder: (context) => Home()),
          //           );
          //         },
          //         child: Text(
          //           'skip',
          //           style: TextStyle(color: Colors.grey),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  Widget buildButton(
      BuildContext context, String text, Widget page, double fontSize,
      {Color color = Colors.blue}) {
    return SizedBox(
      width: 310,
      height: 100,
      child: ElevatedButton(
        onPressed: () => navigateTo(context, page),
        style: ElevatedButton.styleFrom(
          primary: color, // カスタム色を設定
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child:FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, Widget targetPage) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> buttonDataFullAccess = [
      ['1.Hotel', HotelPage(), 30.0, AppColors.turquoiseBlue], // 色を赤に指定
      ['Numbers', Numbers(), 30.0, AppColors.wakanaeiro], // 色を黄色に指定
      [
        '2.Restaurant',
        RestaurantPage(),
        30.0,
        AppColors.turquoiseBlue
      ], // 色を緑に指定
      [
        '3.Phone inquires',
        InquirebyphonePage2(),
        30.0,
        AppColors.turquoiseBlue
      ], // 色をオレンジに指定
      ['4.Shopping', Shopping(), 28.0, AppColors.turquoiseBlue],
      [
        '5.Food Takeaways',
        TakeawayPage(),
        28.0,
        AppColors.turquoiseBlue
      ], // 色を紫に指定
      [
        '6.Shopping2',
        Shopping2Page(),
        30.0,
        AppColors.turquoiseBlue
      ], // 色を茶色に指定
      [
        '7.Going to Kamakura',
        GotoKamakuraPage(),
        26.0,
        AppColors.turquoiseBlue
      ], // 色をシアンに指定
      [
        '8.Fast-food',
        FastfoodPage(),
        28.0,
        AppColors.turquoiseBlue
      ], // 色をブルーグレーに指定
      [
        '9.Asking for \nrecommendations',
        AskrecommendationPage(),
        27.0,
        AppColors.turquoiseBlue
      ],
      // ... 購入済みユーザー用の他のボタンデータ
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(
            padding: EdgeInsets.all(1.0),
            child: Image.asset(
              'assets/icon/onigiri_icon.png',
              color: Colors.white,
            )
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '9 situations for Travelers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.turquoiseBlue,
        elevation: 2,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var data in buttonDataFullAccess) ...[
                SizedBox(height: 25),
                buildButton(
                  context,
                  data[0] as String,
                  data[1] as Widget,
                  data[2] as double,
                  color: data[3] as Color,
                ),
              ],
              SizedBox(height: 25),
              SizedBox(
                width: 310,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4593A0),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => navigateTo(
                      context, Grammer()), // ここはあなたのGrammarPageウィジェットに置き換えてください
                  child: Text(
                    'Grammar PDF',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}


