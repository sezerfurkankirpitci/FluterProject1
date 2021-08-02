import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String position;
  final String company_logo_url;
  final String location;
  final List<String> tags;
  final String date;

  CardWidget(
    this.position,
    this.company_logo_url,
    this.location,
    this.tags,
    this.date,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Image.asset(company_logo_url),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    position,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          location,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(date),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: tags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child: Text(tags[index]));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
