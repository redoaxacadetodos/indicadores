package mx.gob.redoaxaca

class Dato {

    String tipo
    Integer anio
    String descripcion
    BigDecimal valor

    static belongsTo = [indicador: Indicador]

    static constraints = {
        tipo nullable: true
        descripcion nullable: true
    }

    String toString()  {
        return valor
    }
}
