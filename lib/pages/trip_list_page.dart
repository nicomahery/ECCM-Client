import 'package:eccm_client/entities/trip.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/services/trip_service.dart';
import 'package:eccm_client/widgets/trip_summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../utils/get_it_instance.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({Key? key}) : super(key: key);
  static const String PATH = '/trips';
  static const int PAGE_SIZE = 10;
  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  final PagingController<int, Trip> _pagingController =
      PagingController(firstPageKey: 0);
  final TripService _tripService = locator<TripService>();

  @override
  void initState() {
    this._pagingController.addPageRequestListener((pageKey) async {
      try {
        List<Trip>? newTrips = await this._tripService.getAllTripsPagination(pageKey, TripListPage.PAGE_SIZE);
        if (newTrips == null) {
          throw('Something went wrong');
        }
        int newTripStartOffset = this._pagingController.itemList == null ? 0 : (this._pagingController.itemList!.length - 1);
        int newTripEndOffset = newTripStartOffset + TripListPage.PAGE_SIZE;
        if (newTrips.length < TripListPage.PAGE_SIZE) {
          this._pagingController.appendLastPage(newTrips.sublist(newTripStartOffset, newTripEndOffset));
        }
        else {
          this._pagingController.appendPage(newTrips.sublist(newTripStartOffset, newTripEndOffset), pageKey+1);
        }
      }
      catch (error) {
        this._pagingController.error = error;
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    this._pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Trip list'),
        actions: [
          IconButton(
              onPressed: () => context.push(SettingPage.PATH),
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: PagedListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        pagingController: this._pagingController,
        builderDelegate: PagedChildBuilderDelegate<Trip>(
          itemBuilder: (context, item, index) => TripSummaryCardWidget(trip: item),
        ),
      ),
    );
}


