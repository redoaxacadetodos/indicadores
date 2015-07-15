package mx.gob.redoaxaca

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class PublicoController {
    def grailsApplication
    def exportService

    def index() {
        Valor segundos = Valor.findByCampo('segundosEntreImagenes')
        Integer configSegundos = segundos.valor as Integer

        def ejesInfo = []

        Eje.list(sort: 'indice').each {
            ejesInfo.add([
                    eje        : it,
                    indicadores: Indicador.executeQuery(
                            "select new map(i.id as id, i.nombre as nombre) from Eje as e, Tema as t, Indicador as i where e.id = t.eje and t.id = i.tema and e.id = ${it.id as String}"
                    ).sort { it.nombre }
            ])
        }
        return [ejesInfo: ejesInfo, segundos: configSegundos * 1000]
    }

    def mostrarEje(Eje eje) {
        def temas = eje.temas.sort { it.nombre }

        return [temas: temas, eje: eje]
    }

    def mostrarIndicador(Indicador indicadorInstance) {
        def datos = indicadorInstance?.datos?.sort { it?.anio }

        List listaDeAnios = []
        datos.each { listaDeAnios.push(it.anio) }

        def categories = []
        def chartData = []

        datos.each {
            categories.add(it.anio)
            chartData.add(it.valor)
        }

        println datos

        return [
                indicadorInstance: indicadorInstance,
                categories       : categories as JSON,
                chartData        : chartData as JSON,
                datos            : datos,
                listaDeAnios     : listaDeAnios
        ]

    }

    def descargarIndicadoresEnFormatos() {
        Indicador indicadorInstance = Indicador.get(params?.id as Long)

        def datos = indicadorInstance?.datos?.sort { it?.anio }
        List listaDeAnios = []
        datos.each { listaDeAnios.push(it.anio) }

        if (params?.format && params.format != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=datos-indicador.${params.extension}")

            List fields = ["nombre", "fuente", "metodoCalculo", "sentido", "unidadExpresion", "formula"]

            Map labels = [
                    "nombre"         : "Nombre",
                    "fuente"         : "Fuente",
                    "metodoCalculo"  : "Método de cálculo",
                    "sentido"        : "Sentido esperado",
                    "unidadExpresion": "Unidad de expresión",
                    "formula"        : "Fórmula"
            ]
            def indicador = [:]

            listaDeAnios.eachWithIndex{ it, index ->
                fields.add(it.toString())
                labels.put(it.toString(), it.toString())
                indicador.put(it.toString(), datos[index])
            }

            indicador.put('nombre', indicadorInstance.nombre)
            indicador.put('fuente', indicadorInstance.fuente)
            indicador.put('metodoCalculo', indicadorInstance.metodoCalculo)
            indicador.put('sentido', indicadorInstance.sentido)
            indicador.put('unidadExpresion', indicadorInstance.unidadExpresion)
            indicador.put('fuente', indicadorInstance.formula)

            Map parameters = [title: indicadorInstance.nombre]

            exportService.export(params.format, response.outputStream, [indicador], fields, labels, [:], parameters)
        }
    }
}
