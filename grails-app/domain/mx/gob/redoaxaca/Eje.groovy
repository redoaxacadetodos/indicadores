package mx.gob.redoaxaca

class Eje {

    String nombre
    String descripcion
    String prefijo
    Integer indice

    Integer status

    static hasMany = [temas: Tema]

    static constraints = {
        descripcion nullable: true
        indice nullable: true
    }

    static mapping = {
        status defaultValue: 0
    }

    String toString()  {
        return nombre
    }
}
