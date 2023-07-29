
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateTimeFormate{
  Timestamp publishedDate;


  DateTimeFormate({
    required this.publishedDate
});

  getMontName(int month){
    switch(month){
      case 1:
        return "$month Jan";
      case 2:
        return "$month Fab";
      case 3:
        return "$month Mar";
      case 4:
        return "$month April";
      case 5:
        return "$month May";
      case 6:
        return "$month June";
      case 7:
        return "$month Jul";
      case 8:
        return "$month Aug";
      case 9:
        return "$month Sep";
      case 10:
        return "$month Oct";
      case 11:
        return "$month Nav";
      case 12:
        return "$month Dec";
    }
  }




  String getDateFormated(){
    int publishedYear = publishedDate.toDate().year;
    int publishedMonth = publishedDate.toDate().month;
    int publishedDay = publishedDate.toDate().day;
    int publishedHour = publishedDate.toDate().hour;
    int publishedMin = publishedDate.toDate().minute;
    int publishedSec = publishedDate.toDate().second;


    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;
    int currentMonth = currentDate.month;
    int currentDay = currentDate.day;
    int currentHour = currentDate.hour;
    int currentMin = currentDate.minute;
    int currentSec = currentDate.second;

    if(publishedYear==currentYear && publishedMonth==currentMonth &&
          publishedDay==currentDay && publishedHour==currentHour && publishedMin==currentMin){
      return "${currentSec=publishedSec} seconds ago";
    }else if(publishedYear==currentYear && publishedMonth==currentMonth &&
        publishedDay==currentDay && publishedHour==currentHour){
      return "${currentMin-publishedMin} minutes ago";
    }else if(publishedYear==currentYear && publishedMonth==currentMonth &&
        publishedDay==currentDay){
      return "${currentHour-publishedHour} hours ago";
    }else if(publishedYear==currentYear && publishedMonth==currentMonth &&
        (currentDay-publishedDay)<7){
      return "${currentDay-publishedDay} days ago";
    }else if(publishedYear==currentYear && publishedMonth==currentMonth){
      double week=(currentDay-publishedDay)/7;
      return "${week.toInt()} weeks ago";
    }else if(publishedYear==currentYear){
      return getMontName(publishedMonth);
    }else{
      int month = getMontName(publishedMonth);
      return " $publishedDay $month $publishedYear";
    }

  }

}