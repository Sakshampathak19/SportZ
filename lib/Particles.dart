import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';

List<Particle> particle() {
  Random r = Random();

  double size() {
    return (r.nextDouble()) * 4;
  }

  double sign() {
    return r.nextBool() == true ? 1 : -1;
  }

  double vel() {
    return sign() * r.nextDouble() * 100;
  }

  List<Particle> paricles = [];

  for (int i = 0; i < 250; i++) {
    paricles.add(Particle(
        color: const Color(0xff1f8be3),
        size: size(),
        velocity: Offset(vel(), vel())));
  }

  return paricles;
}
