import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class Number {
  final String title;
  final String image;
  Number(this.title, this.image);
}

List<Number> nums = <Number>[
  Number('1', 'assets/img/1-1.jpg'),
  Number('2', 'assets/img/2-1.jpg'),
];

List<Number> ones = <Number>[
  Number('1-2', 'assets/img/1-2.jpg'),
  Number('1-3', 'assets/img/1-3.jpg'),
  Number('1-4', 'assets/img/1-4.jpg'),
  Number('1-5', 'assets/img/1-5.jpg'),
];

List<Number> twos = <Number>[
  Number('2-2', 'assets/img/2-2.jpg'),
  Number('2-3', 'assets/img/2-3.jpg'),
  Number('2-4', 'assets/img/2-4.jpg'),
];

class MyModel extends Model {
  List<Number> _chosenNumber = ones;

  List<Number> get chosenNumber => _chosenNumber;

  void updateNumbersList(List<Number> type) {
    _chosenNumber = type;
    notifyListeners();
  }
}

class MyTabbedScopedModelApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab3 Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(title: 'Lab3 Tabbed and Scoped Model Demo'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyModel>(
      model: MyModel(),
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            NumbersCarousel(),
            NumbersList(),
          ],
        ),
      ),
    );
  }
}

class NumbersCarousel extends StatefulWidget {
  @override
  _NumbersCarouselState createState() => _NumbersCarouselState();
}

class _NumbersCarouselState extends State<NumbersCarousel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: nums.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _changeImage({int delta}) {
    var newTabIndex = _tabController.index + delta;
    print('begin $newTabIndex');
    if (newTabIndex >= nums.length) {
      newTabIndex = 0;
    } else if (newTabIndex < 0) {
      newTabIndex = nums.length - 1;
    }
    print('end $newTabIndex');
    _tabController.animateTo(
      newTabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4.0,
            color: Colors.black,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ScopedModelDescendant<MyModel>(
              rebuildOnChange: false,
              builder: (context, _, model) {
                return TabBarView(
                  controller: _tabController,
                  children: nums.map((numberType) {
                    return GestureDetector(
                      onTap: () {
                        var type;
                        switch (numberType.title) {
                          case '1':
                            type = ones;
                            break;
                          case '2':
                            type = twos;
                            break;
                          default:
                            throw '${numberType.title} type not recognized';
                        }
                        model.updateNumbersList(type);
                      },
                      child: NumbersCard(
                        instantsNumber: numberType,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabPageSelector(
                  controller: _tabController,
                  color: Colors.white,
                  indicatorSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.lightGreen,
                  size: 36,
                ),
                onPressed: () {
                  _changeImage(delta: -1);
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.lightGreen,
                  size: 36,
                ),
                onPressed: () {
                  _changeImage(delta: 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumbersCard extends StatelessWidget {
  final Number instantsNumber;

  const NumbersCard({Key key, this.instantsNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              instantsNumber.image,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class NumbersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
      builder: (context, _, model) {
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(6.0),
            children: model.chosenNumber.map((numberType) {
              return NumbersCard(
                instantsNumber: numberType,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
