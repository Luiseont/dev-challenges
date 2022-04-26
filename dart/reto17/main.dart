/*
 * Reto #17
 * LA CARRERA DE OBSTÁCULOS
 * Fecha publicación enunciado: 25/04/22
 * Fecha publicación resolución: 02/05/22
 * Dificultad: MEDIA
 *
 * Enunciado: Crea una función que evalúe si un/a atleta ha superado correctamente una
 * carrera de obstáculos.
 * - La función recibirá dos parámetros:
 *      - Un array que sólo puede contener String con las palabras "run" o "jump"
 *      - Un String que represente la pista y sólo puede contener "_" (suelo) o "|" (valla)
 * - La función imprimirá cómo ha finalizado la carrera:
 *      - Si el/a atleta hace "run" en "_" (suelo) y "jump" en "|" (valla) será correcto y no
 *        variará el símbolo de esa parte de la pista.
 *      - Si hace "jump" en "_" (suelo), se variará la pista por "x".
 *      - Si hace "run" en "|" (valla), se variará la pista por "/".
 * - La función retornará un Boolean que indique si ha superado la carrera.
 * Para ello tiene que realizar la opción correcta en cada tramo de la pista.
 * 
 */

void main() {
  var result = race(['run', 'jump', 'jump', 'run'], '__|_X');
  print(result);
}

Map<bool, String> race(List<String> actions, String obstacle) {
  //Sanatiza las props
  var newActions = actionsSanatizer(actions);
  var sanatizeString = stringSanatizer(obstacle);

  if (newActions.length == 0 || (sanatizeString.length != newActions.length)) {
    return {false: 'invalid parameters or race and obstacle missmach.'};
  } else {
    return receResult(actions, obstacle);
  }
}

/**
 * Sanatiza la string de obstaculos para evitar cualquier caracter no deseado y 
 * sustituye dichos caracteres con espacios en blanco
 */
String stringSanatizer(String obstacleRace) {
  List newObstacle = [];
  for (var char = 0; char < obstacleRace.length; char++) {
    if (obstacleRace[char] != '|' && obstacleRace[char] != '_') {
      newObstacle.add('');
    } else {
      newObstacle.add(obstacleRace[char]);
    }
  }

  return newObstacle.join().replaceAll(' ', '').trim();
}

/**
 * Sanatiza las acciones para limpiarlas de cualquier palabra/accion no valida.
 */

actionsSanatizer(List<String> actions) {
  var res = actions.asMap().values.where((element) =>
      element.toLowerCase() == 'jump' || element.toLowerCase() == 'run');

  return res;
}

/**
 * itera sobre las acciones y los obstaculos (validando que contengan la misma longitud)
 * retorna un mapa con el resultado bool de la carrera y la string resultante si falla al completar la carrera.
 */
Map<bool, String> receResult(List<String> actions, String obstacle) {
  bool result = true;
  List string = [];

  for (var pos = 0; pos < actions.length; pos++) {
    if ((actions[pos].toLowerCase() == 'run' &&
            obstacle[pos].toLowerCase() == '_') ||
        (actions[pos].toLowerCase() == 'jump' &&
            obstacle[pos].toLowerCase() == '|')) {
      string.add(obstacle[pos]);
    } else {
      if (actions[pos].toLowerCase() == 'run' &&
          obstacle[pos].toLowerCase() == '|') {
        string.add('/');
      }

      if (actions[pos].toLowerCase() == 'jump' &&
          obstacle[pos].toLowerCase() == '_') {
        string.add('X');
      }
      result = false;
    }
  }

  return {result: string.join()};
}
