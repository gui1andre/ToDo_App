class Prioridade {
  int _prioridade;

  Prioridade(this._prioridade);
  int get prioridade => _prioridade;
  set prioridade(int newPrioridade) {
    if (newPrioridade >= 1 && newPrioridade <= 10) {
      _prioridade = newPrioridade;
    }
  }
}
