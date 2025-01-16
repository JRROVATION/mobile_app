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

getExpressionString(Expression exp) {
  List<String> expDict = [
    "angry",
    "disgusted",
    "fearful",
    "happy",
    "neutral",
    "sad",
    "surprised",
  ];
  return expDict[exp.index];
}

getExpressionStateStringID(Expression exp) {
  List<String> expDict = [
    "Marah",
    "Jijik",
    "Takut",
    "Senang",
    "Netral",
    "Sedih",
    "Kaget",
  ];
  return expDict[exp.index];
}

class ConditionData {
  bool drowsy = false;
  Expression expression = Expression.neutral;
}
