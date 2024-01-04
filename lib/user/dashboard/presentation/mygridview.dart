import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/article.dart';

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10, // Space between columns
        mainAxisSpacing: 10, // Space between rows
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4, // Number of items in the grid
      itemBuilder: (BuildContext context, int index) {
        // Build each grid item
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ArticlePage()));
              },
              child: Container(
                width: 145,
                height: 135,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/a.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Dealing with depression',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        );
      },
    );
  }
}
