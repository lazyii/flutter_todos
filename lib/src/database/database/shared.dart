export 'unsupported.dart'
    if (dart.library.html) 'web.dart'
    if (dart.library.io) 'application.dart';
// export if; import if 如何理解
// https://stackoverflow.com/questions/57973064/is-it-possible-to-compile-code-conditional-in-flutter
