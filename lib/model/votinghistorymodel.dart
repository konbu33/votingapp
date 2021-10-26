import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vote {
  Map<String, dynamic> voteInfo;

  Vote(this.voteInfo);

  factory Vote.latest(Map<String, dynamic> data) {
    return Vote(data);
  }
}

class VotingHistoryModel with ChangeNotifier {
  VotingHistoryModel();

  CollectionReference votingHistory =
      FirebaseFirestore.instance.collection('votinghistory');

  List<Vote> currentVoteList = [];
  int count = 1;

  void clearCurrentVoteList() {
    currentVoteList = [];
    // notifyListeners();
  }

  List<Vote> get getCurrentVoteList => currentVoteList;
  set setCurrentVoteList(Vote data) {
    currentVoteList.add(data);
    notifyListeners();
  }

  String _selectRankNum = "";
  String get getSelectRankNum => _selectRankNum;
  set setSelectRankNum(String num) {
    _selectRankNum = num;
    // notifyListeners();
  }

  Future<String> addVotingHisotry(
      String uid, String nameId, String selectRankNum, String photoUrl) async {
    try {
      Map<String, dynamic> data = {
        "createAt": FieldValue.serverTimestamp(),
        "uid": uid,
        "nameId": nameId,
        "selectRankNum": selectRankNum,
        "photoUrl": photoUrl,
      };

      await votingHistory.add(data);
      return "addVotingHisotry Success.";
    } on FirebaseException catch (e) {
      return "addVotingHisotry Error : ${e.message}";
    } catch (e) {
      return "addVotingHisotry Error : ${e.toString()}";
    }
  }

  Future<void> reCreateCurrentVoteList(String uid, String rankNum) async {
    QuerySnapshot querySnapshot = await votingHistory
        .where('uid', isEqualTo: uid)
        .where('selectRankNum', isEqualTo: rankNum)
        .orderBy('createAt', descending: true)
        .limit(1)
        .get();

    List<QueryDocumentSnapshot> queryDocumentSnapshotList = querySnapshot.docs;

    queryDocumentSnapshotList.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      // currentVoteList.add(Vote.latest(data));
      setCurrentVoteList = Vote.latest(data);
      // notifyListeners();
    });
  }

  Stream<Vote?> getCurrentVote(String uid, String rankNum) {
    StreamController<Vote> _voteController = StreamController<Vote>();

    // String uid = '0GekrpJFODRYDCvkVB3CkXErSel2';
    // String uid = 'SvgYxYIFAebwG7BrtDyyLMt95KT2';
    // String rankNum = '1'
    // String rankNum = '2'
    // String rankNum = '3'

    Stream<QuerySnapshot> querySnapshot = votingHistory
        .where('uid', isEqualTo: uid)
        .where('selectRankNum', isEqualTo: rankNum)
        .orderBy('createAt', descending: true)
        .limit(1)
        .snapshots();

    querySnapshot.listen((event) {
      List<QueryDocumentSnapshot> eventList = event.docs;
      eventList.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        _voteController.sink.add(Vote.latest(data));
      });
    });

    _voteController.stream.listen((event) {
      // notifyListeners();

      print("count ${count.toString()}: ${event.voteInfo.toString()}");
      if (event.voteInfo["createAt"] == {}) {
      } else if (event.voteInfo["createAt"] == null) {
      } else {
        currentVoteList.add(event);
      }

      count++;
    });

    return _voteController.stream;
  }

  Stream<QuerySnapshot> get getVotingHistory => votingHistory
      .where('uid', isEqualTo: '0GekrpJFODRYDCvkVB3CkXErSel2')
      // .where('uid', isEqualTo: 'SvgYxYIFAebwG7BrtDyyLMt95KT2')
      .where('selectRankNum', isEqualTo: '2')
      .orderBy('createAt', descending: true)
      .limit(1)
      .snapshots();
}
