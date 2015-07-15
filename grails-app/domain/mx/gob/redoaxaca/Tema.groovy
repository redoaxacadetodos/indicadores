package mx.gob.redoaxaca

class Tema {

    String nombre
    String descripcion

    static belongsTo = [eje: Eje]

    static hasMany = [indicadores: Indicador]

    static constraints = {
        descripcion nullable: true
    }


    String toString() {
        return nombre
    }
}
