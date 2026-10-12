// library_lab.dart  -  Campus Library System
// Name: Abrish Qayyum   Roll no: 04072313043

const String rollNo = '04072313043';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;   // tens digit
final int u = seed % 10;    // units digit

const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;      // publication year of titles[i]
final int feePerDay = 5 + t;                // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6;       // normal number of days late
final int daysBig = 10 + u;                 // a long overdue period
final int feeCap = 150 + 10 * t;            // no single fee may exceed this
final int renewLimit = 1 + t % 3;           // renewals allowed per item
final int renewAttempts = 2 + u;            // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4;            // items on the shelf in Steps 9-10
// ===========================================================================

//Step 1(Classes and extends)

//LibraryItem Class (abstract for Step 3)
abstract class LibraryItem {
  final String title;
  final int year;
  LibraryItem(this.title, this.year);

  //describe method
  String describe() => '$title ($year)';

  //abstract late fee
  int lateFee(int days);
}

//Book class
class Book extends LibraryItem {
  final int pages;
  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;
}

//Magazine class
class Magazine extends LibraryItem {
  final int issue;
  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

//Dvd class
class Dvd extends LibraryItem {
  final int minutes;
  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

//top-level ftn for main book
Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

//mainMagazine ftn
Magazine mainMagazine() {
  final i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

//mainDvd ftn
Dvd mainDvd() {
  final i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
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

void step1() {
  print('--- Step 1 ---');
  final b = mainBook();
  LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
  // Think: Why is item.pages a compile error even though the object really has pages?
  // Answer
  //item is declared as LibraryItem and that class has no pages field.Dart checks the type of the varibale,not the
 //real type of object,so item.pages is a compile error
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
  // Think: What would happen to the output if you forgot @override and mistyped
  // the method name as describe()?
  // Answer
  //If I forget @override and mistype the name, Then dart creates a NEW method in
  //the subclass instead of replacing the parent's
}

void step3() {
  print('--- Step 3 ---');
  final book = mainBook();
  final mag = mainMagazine();
  final dvd = mainDvd();
  print('Step 3: Book late fee for $daysLate days = ${book.lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${mag.lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${dvd.lateFee(daysLate)}');
  // Think: Temporarily try LibraryItem('x', 2000). Read the error. Why can
  // you not create an abstract class directly?
  // Answer
  //LibraryItem is abstract so it cannot be instantiated directly.Abstract classes exist only to be extended by concrete subclasses that implement
  //the abstract members
}

void step4() { print('--- Step 4 ---'); }
void step5() { print('--- Step 5 ---'); }
void step6() { print('--- Step 6 ---'); }
void step7() { print('--- Step 7 ---'); }
void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }