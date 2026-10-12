# Campus Library System — Reflection

Name:Abrish Qayyum
Roll no:04072313043

## Q1:What can a subclass using extends use for free that a class using implements has to write itself?
extends gives the fields and methods of the parent for free.implements only
gives the method names, so we have to write all the method bodies ourselves.

## Q2:Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?
We use a mixin when different classes need the same code but are not related
(Book and Dvd renew, but Magazine should not). We use an abstract parent
class when the classes are a kind-of relationship and share state too.

## Q3:Why must you override hashCode whenever you override ==?
Sets and Maps use hashCode to find the bucket first, then == to compare. If
two equal objects have different hashCodes, they go to different buckets and
are treated as different. So equal objects must hash equally too.

## Q4:An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?
Extensions work at compile time and do not change the type. String is a
final core type, so Dart does not allow us to subclass it.