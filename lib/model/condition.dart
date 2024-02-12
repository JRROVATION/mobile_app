//{0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}
enum Expression {
  angry,
  disgusted,
  fearful,
  happy,
  neutral,
  sad,
  surprised,
}

GetExpressionString(Expression exp) {
  List<String> exp_dict = [
    "angry",
    "disgusted",
    "fearful",
    "happy",
    "neutral",
    "sad",
    "surprised",
  ];
  return exp_dict[exp.index];
}

GetExpressionStateStringID(Expression exp) {
  List<String> exp_dict = [
    "Marah",
    "Jijik",
    "Takut",
    "Senang",
    "Netral",
    "Sedih",
    "Kaget",
  ];
  return exp_dict[exp.index];
}

class ConditionData {
  bool drowsy = false;
  Expression expression = Expression.neutral;
}
