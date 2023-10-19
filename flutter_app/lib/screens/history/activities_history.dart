import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/widgets/history/activities_history_card.dart';
import 'package:provider/provider.dart';

class ActivitiesHistoryScreen extends StatefulWidget {
  static const String routeName = activitiesHistoryRouteName;

  const ActivitiesHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesHistoryScreen> createState() =>
      _ActivitiesHistoryScreenState();
}

class _ActivitiesHistoryScreenState extends State<ActivitiesHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de actividades'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: providerManager.activitiesHistory.length,
          itemBuilder: (BuildContext context, int index) {
            final act = providerManager.activitiesHistory[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ActivityHistoryCard(activityHistory: act),
            );
          },
        ),
      ),
    );
  }
}
