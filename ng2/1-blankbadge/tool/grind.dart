import 'dart:async';

import 'package:grinder/grinder.dart';
import 'package:git/git.dart';

void main(List<String> args) {
  grind(args);
}

@Task('Format all dart source files')
void format() {
  DartFmt.format(existingSourceDirs);
}

@Task('Update demo at gh-pages')
Future updateDemo() async {
  await Pub.run('peanut');
  await runGit(['push', 'origin', 'gh-pages']);
}