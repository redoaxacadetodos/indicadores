package mx.gob.redoaxaca

class InfoElem {
    String texto
    String href
    String hrefLabel
    String imgFileName //400x400
    Integer indice
    Boolean abrirEnTab

    static constraints = {
        imgFileName nullable: true
        indice nullable: true
        abrirEnTab nullable: true
    }

    static mapping = {
        texto type: 'text'
    }
}
