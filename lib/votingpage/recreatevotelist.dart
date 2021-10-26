// import 'package:votingapp/votingpage/recreatevotelist.dart';

import '../model/votinghistorymodel.dart';
import '../model/usermodel.dart';

class ReCreateVoteList {
  ReCreateVoteList();
  // ReCreateVoteList(this._votingHistoryModel);

  // UserModel _userModel = UserModel();
  // VotingHistoryModel _votingHistoryModel = VotingHistoryModel();
  // VotingHistoryModel _votingHistoryModel;

  void reCreateVoteList(
      UserModel _userModel, VotingHistoryModel _votingHistoryModel) async {
    await _userModel.getUsers();
    // final res1 = await _userModel.getUsers();
    // UserModel _userModel = UserModel();

    List<Map<String, dynamic>> _userList =
        _userModel.getLatestUserList.map((e) => e.userModelInfo).toList();

    // List<String> _uidList = _userList.map((e) => e["uid"].toString()).toList();

    _votingHistoryModel.clearCurrentVoteList();

    for (var user in _userList) {
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "1");
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "2");
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "3");
    }

    // print("zzz1 : ${_userList.toString()}");
    // print("zzz2 : ${_uidList.toString()}");

    // print("zzz3 : ${_votingHistoryModel.currentVoteList.length}");
    // _votingHistoryModel.currentVoteList.forEach((element) {
    // print("currentVoteList : ${element.voteInfo.toString()}");
    // });
  }
}
