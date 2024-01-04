import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/depression.jpg'),
                        fit: BoxFit.cover)),
              ),
              ArticleCard(title: 'm', content: 'e'),

            ],
          ),
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String content;
  const ArticleCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Introduction',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Depression is a formidable adversary that affects millions of people worldwide, transcending age, gender, and socioeconomic boundaries. However, in the face of this seemingly insurmountable challenge, individuals can embark on a journey of resilience and self-discovery to overcome depression and reclaim their lives. This article explores the multifaceted aspects of overcoming depression, offering insights and strategies for those navigating this challenging terrain.',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textDirection: TextDirection.ltr,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
