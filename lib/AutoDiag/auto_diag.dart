import 'Question.dart';

class AutoDiag{

  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('dernièrement avez-vous eut une température supérieure à la normale (37°C) ?', false),
    Question('Ces derniers jours, avez-vous une toux ou une augmentation de votre toux habituelle ?', false),
    Question('Ces derniers jours, avez-vous noté une forte diminution ou perte de votre goût ou de votre odorat ?', false),
    Question('Ces derniers jours, avez-vous eu un mal de gorge et/ou des douleurs musculaires et/ou des courbatures inhabituelles ?', false),
    Question('Ces dernières 24 heures, avez-vous de la diarrhée ? Avec au moins 3 selles molles.', false),
    Question('Ces derniers jours, avez-vous une fatigue inhabituelle ?', false),
    Question(
        'Depuis 24 heures ou plus, êtes-vous dans l\'impossibilité de vous alimenter ou de boire ?',
        false),
    Question(
        'Ces dernières 24 heures, avez-vous noté un manque de souffle inhabituel lorsque vous parlez ou faites un petit effort ?',
        false),
    Question(
        'Avez-vous de l’hypertension artérielle mal équilibrée ?\nOu avez-vous une maladie cardiaque ou vasculaire ?\nOu prenez vous un traitement à visée cardiologique ?',
        false),
    Question(
        'Êtes-vous diabétique ?',
        false),
    Question('Avez-vous ou avez-vous eu un cancer ces trois dernières années ?', false),
    Question(
        'Avez-vous une maladie respiratoire ?\nOu êtes-vous suivi par un pneumologue ?',
        false),
    Question(
        'Avez-vous une insuffisance rénale chronique dialysée ?',
        false),
    Question('Avez-vous une maladie chronique du foie ?', false),
 Question('Êtes-vous enceinte ?', false),
   Question('Avez-vous une maladie connue pour diminuer vos défenses immunitaires ?', false),
   Question('Prenez-vous un traitement immunosuppresseur ?\nC’est un traitement qui diminue vos défenses contre les infections.\nVoici quelques exemples : corticoïdes, méthotrexate, ciclosporine, tacrolimus, azathioprine, cyclophosphamide (liste non exhaustive).', false),
  ];

  void nextQuestion(){
    if(_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText(){
    return _questionBank[_questionNumber].question;
  }

  bool getCorrectAnswer(){
    return _questionBank[_questionNumber].answer;
  }
}


