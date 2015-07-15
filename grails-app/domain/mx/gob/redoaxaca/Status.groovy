package mx.gob.redoaxaca

class Status {

    Integer clave
    String descripcion

    static constraints = {
    }

    String toString() {
        return descripcion
    }
}
