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

//Book class (implements Borrowable + Renewable mixin)
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() => _out = true;

  @override
  void giveBack() => _out = false;
}

//Magazine class (no Renewable mixin)
class Magazine extends LibraryItem {
  final int issue;
  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

//Dvd class
class Dvd extends LibraryItem with Renewable {
  final int minutes;
  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

//Borrowable interface
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

//Renewable mixin
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) return false;
    renewals++;
    return true;
  }
}

//Step 6:MemberType enum
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent) ~/ 100;
}

//Step 7:Extensions
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) => fold(0, (sum, i) => sum + i.lateFee(days));
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

void step4() {
  print('--- Step 4 ---');
  final book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');
  final items = <LibraryItem>[book, mainMagazine(), mainDvd()];
  for (final item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }
// Think: You wrote all three method bodies yourself. What would extends
// Borrowable have given you for free, and why is that not what you wanted?
// Answer
//extends Borrowable would give method bodies for free but Book already
//extends LibraryItem (only one parent allowed in Dart) and I wanted only a
//contract not the inherited code
}

void step5() {
  print('--- Step 5 ---');
  final book = mainBook();
  var ok = 0;
  for (var i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) ok++;
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
  // Think: Book and Dvd need the same renew code but Magazine must not have
  // it. Why is a mixin a better fit than putting renew in LibraryItem?
  // Answer
  //A mixin shares code only with the classes that need it.If renew were in
  //LibraryItem,Magazine would also get it which is wrong here
}

void step6() {
  print('--- Step 6 ---');
  final type = MemberType.values[seed % 3];
  final fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');
  // Think: Why is MemberType.student safer than the string 'student'?
  // Answer
//MemberType.student is safer because the compiler checks it.A typing mistake in a String like 'studnet' would compile but fail at runtime,a typo in the
  //enum like MemberType.studnet is caught at compile time
}

void step7() {
  print('--- Step 7 ---');
  final type = MemberType.values[seed % 3];
  final discounted = type.applyDiscount(mainBook().lateFee(daysLate));
  final shelf = <LibraryItem>[mainBook(), mainMagazine(), mainDvd()];
  print('Step 7: ${discounted.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print('Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}');
  // Think: You could have written plain functions rs(int x). What do you gain
  // by writing 72.rs instead?
  // Answer
   //72.rs is shorter and reads better than rs(72),so the code is cleaner

}

void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }