import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:coffee_store_app/model/DrinkType.dart';

List<DrinkType> mainTypes = <DrinkType>[
  DrinkType('Coffee', 'assets/img/black-coffee.jpeg', 4.12),
  DrinkType('Tea', 'assets/img/black-tea.jpeg', 4.12),
  DrinkType('Juice', 'assets/img/lemon.jpeg', 4.12),
  DrinkType('Smoothie', 'assets/img/apple-smoothie.jpeg', 4.12),
];

List<DrinkType> coffeeTypes = <DrinkType>[
  DrinkType('Black Coffee', 'assets/img/black-coffee.jpeg', 4.12),
  DrinkType('Cappuccino', 'assets/img/cappuccino.jpeg', 4.12),
  DrinkType('Espresso', 'assets/img/espresso.jpeg', 4.12),
  DrinkType('Latte', 'assets/img/latte.jpeg', 4.12),
];

List<DrinkType> teaTypes = <DrinkType>[
  DrinkType('Black Tea', 'assets/img/black-tea.jpeg', 4.12),
  DrinkType('Brown Tea', 'assets/img/brown-tea.jpeg', 4.12),
  DrinkType('English Tea', 'assets/img/english-tea.jpeg', 4.12),
  DrinkType('Herbal Tea', 'assets/img/herbal-tea.jpeg', 4.12),
  DrinkType('Mint Tea', 'assets/img/mint-tea.jpeg', 4.12),
];

List<DrinkType> juiceTypes = <DrinkType>[
  DrinkType('Lemon Juice', 'assets/img/lemon.jpeg', 4.12),
  DrinkType('Lime Juice', 'assets/img/lime.jpeg', 4.12),
  DrinkType('Pink Grape Juice', 'assets/img/pink-grape.jpeg', 4.12),
  DrinkType('Plum Juice', 'assets/img/plum.jpeg', 4.12),
  DrinkType('Tomato Juice', 'assets/img/tomato.jpeg', 4.12),
];

List<DrinkType> smoothieTypes = <DrinkType>[
  DrinkType('Apple Smoothie', 'assets/img/apple-smoothie.jpeg', 4.12),
  DrinkType('Blackberry Smoothie', 'assets/img/black-smoothie.jpeg', 4.12),
  DrinkType('Kiwi Fruit Smoothie', 'assets/img/kiwi-smoothie.jpeg', 4.12),
  DrinkType('Raspberry Smoothie ', 'assets/img/rasberry-smoothie.jpeg', 4.12),
];

class MyModel extends Model {
  List<DrinkType> _chosenNumber = coffeeTypes;

  List<DrinkType> get chosenNumber => _chosenNumber;

  void updateNumbersList(List<DrinkType> type) {
    _chosenNumber = type;
    notifyListeners();
  }
}

class MyTabbedScopedModelApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab3',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: HomePage(title: ''),
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
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text('Store Home', style: TextStyle(color: Colors.white)),
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
    _tabController = TabController(length: mainTypes.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _changeImage({int delta}) {
    var newTabIndex = _tabController.index + delta;
    print('begin $newTabIndex');
    if (newTabIndex >= mainTypes.length) {
      newTabIndex = 0;
    } else if (newTabIndex < 0) {
      newTabIndex = mainTypes.length - 1;
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
                  children: mainTypes.map((numberType) {
                    return GestureDetector(
                      onTap: () {
                        var type;
                        switch (numberType.title) {
                          case 'Coffee':
                            type = coffeeTypes;
                            break;
                          case 'Tea':
                            type = teaTypes;
                            break;
                          case 'Juice':
                            type = juiceTypes;
                            break;
                          case 'Smoothie':
                            type = smoothieTypes;
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
                  color: Colors.white,
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
                  color: Colors.white,
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
  final DrinkType instantsNumber;

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
            Container( 
                alignment: Alignment.topCenter,
                child: Text(instantsNumber.title, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold), ),
            )
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
