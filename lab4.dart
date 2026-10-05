//Name:Abrish Qayyum
//Roll no:04072313043

const String rollNo = '04072313043';

// ======= Seeded settings (generated from YOUR roll number). Do not edit. =======
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees

final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

//Part 1:Dish class
class Dish {
  late String name;
  late int price;
}

// Part 2 and 3: MenuItem class
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  MenuItem.free(this.name) : price = 0;

  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);

  @override
  String toString() => '$name (Rs $price)';
}
//we cannot declare price as final bcz its value chnage in constructor
//floor logic did not run in free() bcz free() is a different named constructor with price = 0

// Part 4: OrderLog singleton
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}
//_instance and _internal start from underscore bcz they are private

// Part 5 and 6: OrderLine class
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty) * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');

  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
}
//initializer list cannot read another field of the same object bcz the object does not exist yet so I calculate total again from item.price * qty
//line.grand = 5; fails because grand is a getter. A getter is read-only, we cannot assign a value to it. To make it legal, we would have to add a setter.

// Part 7: StudentCard class
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}
//setter fixes a bad value so the other option is to throw error when the value is bad

// Part 5: mainOrder function
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

// Part 8: buildMenu function
List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

// Part 1: Classes and Objects
void step1() {
  print('--- Step 1 ---');
  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);
  int idx2 = (u + 1) % 10;
  Dish item2 = Dish();
  item2.name = menu[idx2];
  item2.price = priceOf(idx2);
  item2.price = item2.price - u;
  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

// Part 2: Constructors and this. shorthand
void step2() {
  print('--- Step 2 ---');
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u);
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}

// Part 3: Named Constructors
void step3() {
  print('--- Step 3 ---');
  MenuItem freebie = MenuItem.free('Water');
  int i = (u + 2) % 10;
  MenuItem parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

// Part 4: Factory Constructors
void step4() {
  print('--- Step 4 ---');
  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();
  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

// Part 5: Initializer Lists and Assertions
void step5() {
  print('--- Step 5 ---');
  OrderLine line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');
  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

// Part 6: Getters
void step6() {
  print('--- Step 6 ---');
  OrderLine line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

// Part 7: Setters
void step7() {
  print('--- Step 7 ---');
  StudentCard card = StudentCard('$seed');
  card.balance = seed * 10 + 50;
  print('Step 7: topped up ->${card.balance}');
  card.balance = -seed - 1;
  print('Step 7: bad value ->${card.balance}');
  card.balance = balanceCap - u;
  print('Step 7: reset ->${card.balance}');
  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order ->${card.balance}');
}

// Part 8: A Menu Built from Text
void step8() {
  print('--- Step 8 ---');
  List<MenuItem> items = buildMenu();
  MenuItem priciest = items.reduce((a, b) => a.price > b.price ? a : b);
  int sum = items.fold(0, (total, item) => total + item.price);
  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

// Part 9: Building a Receipt
void step9() {
  print('--- Step 9 ---');
}

// Part 10: Capstone, Discount Coupons
void step10() {
  print('--- Step 10 ---');
}
