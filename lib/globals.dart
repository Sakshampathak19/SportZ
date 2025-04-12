library globals;

import 'package:firebase_auth/firebase_auth.dart';

var user;

String profile='';

Map<String, dynamic> team1 = {
  'Name': 'Team 1',
  'Player': [
    'Player1',
    'Player2',
    'Player3',
    'Player4',
    'Player5',
    'Player6',
    'Player7',
    'Player8',
    'Player9',
    'Player10',
    'Player11',
  ]
};

Map<String, dynamic> team2 = {
  'Name': 'Team 2',
  'Player': [
    'Player1',
    'Player2',
    'Player3',
    'Player4',
    'Player5',
    'Player6',
    'Player7',
    'Player8',
    'Player9',
    'Player10',
    'Player11',
  ]
};

int match_num=0,score_A=0,score_B=0;