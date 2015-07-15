package mx.gob.redoaxaca

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional
class DatoController {
    def dataTablesHelperService

    def index() {
        render(template: 'index')
    }

    def save() {
        Dato datoInstance = new Dato(params)
        datoInstance.valor = params.valor.toDouble()

        if (datoInstance.hasErrors()) {
            render(status: 422, errors: datoInstance.errors)
            return
        }

        datoInstance.save flush:true

        render(status: 201)
    }

    def update() {
        Dato datoInstance = Dato.get(params?.id as Long)

        if (datoInstance == null) {
            notFound()
            return
        }

        if (datoInstance.hasErrors()) {
            render(status: 422, errors: datoInstance.errors)
            return
        }

        datoInstance.properties = params
        datoInstance.valor = params.valor.toDouble()
        datoInstance.save flush:true

        render(status: 204)
    }

    def delete() {
        Dato datoInstance = Dato.get(params?.id as Long)
        if (datoInstance == null) {
            notFound()
            return
        }

        Indicador indicadorPadre = datoInstance.indicador
        indicadorPadre.removeFromDatos(datoInstance)

        datoInstance.delete(flush: true)

        render(status: 204)
    }

    def datosJSONData() {
        String columnaAOrdenar = params.get('order[0][column]');
        String formaDeOrdenar = params.get('order[0][dir]');

        String atributoAOrdenar = params.get("columns[" + columnaAOrdenar + "][data]");

        def parametrosCasteados = [max        : params?.length as Integer,
                                   offset     : params?.start as Integer,
                                   draw       : params?.draw as Integer,
                                   searchValue: params.get("search[value]") as String]

        def propertiesToRender = ['id', 'anio', 'valor', 'indicador.nombre']
        def propertiesToSearchIn = ['anio', 'valor', 'indicador.nombre']

        def data = dataTablesHelperService.getData(
                Dato,
                parametrosCasteados,
                propertiesToRender,
                propertiesToSearchIn,
                atributoAOrdenar,
                formaDeOrdenar
        )

        render data as JSON
    }

    def datoData(Long id) {
        Dato datoInstance = Dato.get(id)
        render datoInstance as JSON
    }

    def validarAnio(Integer anio, String indicadorId) {
        Boolean valid = true
        def anios = Dato.executeQuery("select anio from Dato as d where d.indicador = ${indicadorId}")

        if (anios.contains(anio))
            valid = false;

        render ([valid : valid] as JSON)
    }

    def fetchTemplate(String templateName) {
        render template: templateName
    }

    protected void notFound() {
        render(status: 404)
    }
}
