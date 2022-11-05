import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news/presentation/notifiers/news_change_notifier.dart';
import 'news/presentation/pages/news_page.dart';
import 'news/data/repositories/news_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsRepository()),
        child: NewsPage(),
      ),
    );
  }
}
