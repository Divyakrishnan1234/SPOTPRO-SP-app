import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewForm extends StatefulWidget {


  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {

  final _formKey = GlobalKey<FormState>();
  String _reviewText = '';
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(

            decoration: InputDecoration(
              labelText: 'Write your review',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your review text';
              }
              return null;
            },
            onSaved: (value) {
              _reviewText = value!;
            },
          ),
          SizedBox(height: 16.0),

          //Text('Rating: $_rating'),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.deepPurple,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',style: TextStyle(color: Colors.deepPurple),),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitReview();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitReview() async {
    try {

      final reviewData = {
        'text': _reviewText,
        'rating': _rating,
        'SPid': '',
        'SCid':'',
        'createdAt': Timestamp.now(),
      };
      await FirebaseFirestore.instance

          .collection('reviews')
          .add(reviewData);
      Navigator.of(context).pop();
    } catch (e) {
      print('Error submitting review: $e');
    }
  }
}
