import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabbar_example/interbanc_benef.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _bloc = TabsBloc();

  @override
  void initState() {
    _bloc.init(this);
  }

  @override
  Widget build(BuildContext context) {
    //TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: AnimatedBuilder(
          animation: _bloc,
          builder: (_, __) => Column(
            children: [
              Container(
                color: Colors.red,
                height: 100,
              ),
              TabBar(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                //labelColor: Colors.red,
                //unselectedLabelColor: Colors.purple,
                onTap: _bloc.onCategorySelected,
                controller: _bloc.tabController,
                indicatorWeight: 0.1,
                tabs: _bloc.tabs.map((e) => _TabsAvancesBA(e)).toList(),
              ),
              Expanded(
                  child: Container(
                color: Colors.blue,
              ))
            ],
          ),
        ));
  }
}

class _TabsAvancesBA extends StatelessWidget {
  const _TabsAvancesBA(this.tabCategory);
  final CategTabBenef tabCategory;
  
  @override
  Widget build(Object context) {
    return Card(
      color:tabCategory.selected?Colors.yellow:Colors.white,
      child: Text(
        tabCategory.categoria,
        style: TextStyle(
            color: tabCategory.selected ? Colors.blue : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13),
      ),
    );
  }
}

class TabsBloc with ChangeNotifier {
  TabController? tabController;
  bool? selectedTab;
  static const categoriasBenf = ['BANCO DEL AUSTRO', 'INTERBANCARIOS'];
  List<String> selectedOption = ['true','false'];
  List<CategTabBenef> tabs = [];

  void init(TickerProvider ticker) {
    tabController = TabController(length: categoriasBenf.length, vsync: ticker);
    for (int i = 0; i < categoriasBenf.length; i++) {
      tabs.add(
        CategTabBenef(categoria: categoriasBenf[i], selected: (i == 0)),
      );
    }
  }

  void onCategorySelected(int index) {
    final selected = tabs[index];
    for (int i = 0; i < tabs.length; i++) {
      tabs[i] = tabs[i].copyWith(selected.categoria == tabs[i].categoria);
      /*final tabCategory = tabs[i];
      if(selected == tabCategory){
        tabs[i] = tabs[i].copyWith(true);
      }*/
    }
    notifyListeners();
  }
}

class CategTabBenef {
  CategTabBenef({required this.categoria, required this.selected});
  final String categoria;
  final bool selected;
  CategTabBenef copyWith(bool selected) =>
      CategTabBenef(categoria: categoria, selected: selected);
}
