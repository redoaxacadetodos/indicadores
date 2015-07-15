package mx.gob.redoaxaca

class Valor {
    String campo
    String valor

    static constraints = {
        campo unique: true
    }
}
