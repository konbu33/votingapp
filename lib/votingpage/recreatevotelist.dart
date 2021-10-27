import '../model/votinghistorymodel.dart';
import '../model/usermodel.dart';

class ReCreateVoteList {
  ReCreateVoteList();

  void reCreateVoteList(
      UserModel _userModel, VotingHistoryModel _votingHistoryModel) async {
    await _userModel.getUsers();

    List<Map<String, dynamic>> _userList =
        _userModel.getLatestUserList.map((e) => e.userModelInfo).toList();

    _votingHistoryModel.clearCurrentVoteList();

    for (var user in _userList) {
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "1");
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "2");
      await _votingHistoryModel.reCreateCurrentVoteList(user["uid"], "3");
    }
  }
}
