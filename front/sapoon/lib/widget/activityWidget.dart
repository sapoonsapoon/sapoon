class Activity {
  int seq;
  String writer;
  String contents;
  double score1;
  double score2;
  double score3;
  double score4;
  double starScore;
  double totalScore;
  double rating;
  List<String> startTimes;
  String imgUrl;
  int dulleSeq;
  String userDulleWrite;

  Activity({
    this.seq,
    this.writer,
    this.contents,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
    this.starScore,
    this.rating,
    this.totalScore,
    this.startTimes,
    this.imgUrl,
    this.dulleSeq,
    this.userDulleWrite,
  });
}