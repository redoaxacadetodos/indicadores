package mx.gob.redoaxaca

class Indicador {

    String nombre
    String descripcion
    String tituloGrafica
    String metodoCalculo
    String formula
    String unidadMedida
    String sentido
    String unidadExpresion
    String fuente
    //Integer valorDelTacometro = 50

    static belongsTo = [tema: Tema]
    static hasMany = [datos: Dato]

    static constraints = {
        descripcion nullable: true
        formula nullable: true
        //valorDelTacometro nullable: true
    }

    static mapping = {
        descripcion type: 'text'
    }

    String toString() {
        return nombre
    }
}
