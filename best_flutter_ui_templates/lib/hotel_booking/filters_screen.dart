import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'range_slider_view.dart';
import 'slider_view.dart';
import 'hotel_app_theme.dart';
import 'model/popular_filter_list.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    priceBarFilter(),
                    const Divider(height: 1),
                    popularFilter(),
                    const Divider(height: 1),
                    distanceViewUI(),
                    const Divider(height: 1),
                    allAccommodationUI(),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Type of Accommodation',
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < accomodationListData.length; i++) {
      final PopularFilterListData data = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data.titleTxt,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: data.isSelected
                        ? HotelAppTheme.buildLightTheme().primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: data.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(height: 1));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      // Check if all items except index 0 are selected
      bool allSelected = accomodationListData.skip(1).every((d) => d.isSelected);
      for (int i = 1; i < accomodationListData.length; i++) {
        accomodationListData[i].isSelected = !allSelected;
      }
      accomodationListData[0].isSelected = !allSelected;
    } else {
      accomodationListData[index].isSelected = !accomodationListData[index].isSelected;

      // Update "Select All" item based on rest
      bool allSelected = accomodationListData.skip(1).every((d) => d.isSelected);
      accomodationListData[0].isSelected = allSelected;
    }
  }

  Widget distanceViewUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Distance from city center',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChangedistValue: (double value) {
            setState(() {
              distValue = value;
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Popular filters',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;

    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int j = 0; j < columnCount; j++) {
        if (count >= popularFilterListData.length) break;

        final PopularFilterListData data = popularFilterListData[count];
        listUI.add(Expanded(
          child: Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  onTap: () {
                    setState(() {
                      data.isSelected = !data.isSelected;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          data.isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: data.isSelected
                              ? HotelAppTheme.buildLightTheme().primaryColor
                              : Colors.grey.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(data.titleTxt),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
        count++;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Price (for 1 night)',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        RangeSliderView(
          values: _values,
          onChangeRangeValues: (RangeValues values) {
            setState(() {
              _values = values;
            });
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 8,
          right: 8,
        ),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: const Icon(Icons.close),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filter',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
