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

Expression getExpressionFromString(String expString) {
  switch (expString.toLowerCase()) {
    case "angry":
      return Expression.angry;
    case "disgusted":
      return Expression.disgusted;
    case "fearful":
      return Expression.fearful;
    case "happy":
      return Expression.happy;
    case "neutral":
      return Expression.neutral;
    case "sad":
      return Expression.sad;
    case "surprised":
      return Expression.surprised;
    default:
      throw ArgumentError("Unknown expression: $expString");
  }
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
