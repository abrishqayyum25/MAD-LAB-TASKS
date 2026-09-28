//Week3.dart - Library Desk Assistant
//Name: Abrish Qayyum
//Roll no: 04072313043

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

//Part 1(functions and parameters)
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

String formatTitle(String title, [String? author]) {
  return author == null ? title : '$title by $author';
}

Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

bool isClassic(int year) => year < 2000;

//Part 2(closures, higher order functions and recursion)
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

int sumDigits(int n) {
  if (n < 10) return n;
  return (n % 10) + sumDigits(n ~/ 10);
}

//Part 3(collections (list, map and set))
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

//Part 4(generics)
class Box<T> {
  T value;
  Box(this.value);
}

T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) return fallback;
  return items.first;
}

class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

//Part 5(error handling)
class BookNotFoundException implements Exception {
  final String title;
  BookNotFoundException(this.title);

  @override
  String toString() => 'BookNotFoundException: $title';
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);

  @override
  String toString() => 'BookNotAvailableException: $title';
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }
  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere((b) => b['title'] == title);
}

//Part 6(future and async/await)
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

//main function
void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

//part 1
void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

//part 2
void part2() {
  print('--- Part 2 ---');

  var items = ['Dart in Action', 'Clean Code'];
  print(transformAll(items, (s) => s.toUpperCase()));
  print(transformAll(items, (s) => '$s!'));

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(1232)}');
}

//part 3
void part3() {
  print('--- Part 3 ---');

  var allTitles = books.map((b) => b['title'] as String).toList();
  print('Titles: $allTitles');

  var available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print('Available: $available');

  var totalCopies = books.fold<int>(0, (sum, b) => sum + (b['copies'] as int));
  print('Total copies: $totalCopies');

  var years = books.map((b) => b['year'] as int).toList();
  var oldest = years.reduce((a, b) => a < b ? a : b);
  print('Oldest year: $oldest');

  var sortedBooks = List.of(books);
  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  var sortedTitles = sortedBooks.map((b) => b['title'] as String).toList();
  print('By year: $sortedTitles');

  var stock = buildStock();
  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) print('Out of stock: $title');
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  Set<String> allTags = {for (var b in books) ...(b['tags'] as List<String>)};
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

//part 4
void part4() {
  print('--- Part 4 ---');

  var intBox = Box<int>(5);
  var strBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${strBox.value}');
  //intBox.value = 'hello'; //compile time error
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));
  print(Pair('Dart in Action', 3));
}

//part 5
void part5() {
  print('--- Part 5 ---');

  var stock = buildStock();
  var titles = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];
  for (var title in titles) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } catch (e) {
      print('Unexpected: $e');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');
  try {
    findBook('Missing');
  } catch (e) {
    print('Search failed: no such book');
  }
}

//part 6
Future<void> part6() async {
  print('--- Part 6 ---');
  print('Fetching...');
  var book = await fetchBookOfTheDay();
  print('Book of the day: $book');
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

//reflection
//1. When would you choose fold over reduce?
//I choose fold because I need a starting value, like 0 for sum as fold works on an empty list, but reduce throws an error.

//2.What does it mean that a closure "captures" a variable? Which variable was captured in makeCounter?
//It means the inner function remembers a variable from its outer function. In makeCounter, the captured variable is 'count'.

//3.Why must on BookNotAvailableException come before a general catch (e)?
// Because dart checks in order.If catch comes first, it catches everything and the specific on clause never runs.

//4.Why does forgetting await still compile, but give the wrong result?
//Without await, we get a future object,not the real value.It still compiles because Future is a valid object,but printing it shows "Instance of '_Future<String>'" instead of the actual value.
