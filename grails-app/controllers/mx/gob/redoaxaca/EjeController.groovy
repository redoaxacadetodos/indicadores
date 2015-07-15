package mx.gob.redoaxaca

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional
class EjeController {

    def dataTablesHelperService

    def index() {
        render(template: 'index')
    }

    def save() {
        Eje ejeInstance = new Eje(params)

        if (ejeInstance.hasErrors()) {
            render(status: 422, errors: ejeInstance.errors)
            return
        }

        ejeInstance.save flush:true

        render(status: 201)
    }

    def update() {
        Eje ejeInstance = Eje.get(params?.id as Long)
        if (ejeInstance == null) {
            notFound()
            return
        }

        if (ejeInstance.hasErrors()) {
            render(status: 422, errors: ejeInstance.errors)
            return
        }

        ejeInstance.properties = params
        ejeInstance.save flush: true

        render(status: 204)
    }

    def delete() {
        Eje ejeInstance = Eje.get(params?.id as Long)

        if (ejeInstance == null) {
            notFound()
            return
        }

        ejeInstance.delete(flush: true)

        render(status: 204)
    }

    def ejeJSONData() {
        String columnaAOrdenar = params.get('order[0][column]');
        String formaDeOrdenar =  params.get('order[0][dir]');

        String atributoAOrdenar =  params.get("columns[" + columnaAOrdenar + "][data]");

        def parametrosCasteados = [max        : params?.length as Integer,
                                   offset     : params?.start as Integer,
                                   draw       : params?.draw as Integer,
                                   searchValue: params.get("search[value]") as String]

        def propertiesToRender = ['id', 'nombre', 'descripcion']
        def propertiesToSearchIn = ['id', 'nombre', 'descripcion']

        def data = dataTablesHelperService.getData(
                Eje,
                parametrosCasteados,
                propertiesToRender,
                propertiesToSearchIn,
                atributoAOrdenar,
                formaDeOrdenar
        )

        render data as JSON
    }

    def ejeData(Long id) {
        Eje ejeInstance = Eje.get(id)
        render ejeInstance as JSON
    }

    def fetchTemplate(String templateName) {
        render template: templateName
    }

    protected void notFound() {
        render(status: 404)
    }
}
