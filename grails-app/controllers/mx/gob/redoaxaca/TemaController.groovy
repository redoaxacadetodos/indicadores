package mx.gob.redoaxaca
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])

@Transactional
class TemaController {

    def dataTablesHelperService

    def index() {
        render(template: 'index')
    }

    def save() {
        Tema temaInstance = new Tema(params)

        if (temaInstance.hasErrors()) {
            render(status: 422, errors: temaInstance.errors)
            return
        }


        temaInstance.save flush:true

        render(status: 201)
    }

    def update() {
        Tema temaInstance = Tema.get(params?.id as Long)

        if (temaInstance == null) {
            notFound()
            return
        }

        if (temaInstance.hasErrors()) {
            render(status: 422, errors: temaInstance.errors)
            return
        }

        temaInstance.properties = params
        temaInstance.save flush: true

        render(status: 204)
    }

    def delete() {
        Tema temaInstance = Tema.get(params?.id as Long)

        if (temaInstance == null) {
            notFound()
            return
        }

        Eje ejePadre = temaInstance.eje
        ejePadre.removeFromTemas(temaInstance)

        temaInstance.delete(flush: true)

        render(status: 204)
    }

    def temasJSONData() {
        String columnaAOrdenar = params.get('order[0][column]');
        String formaDeOrdenar =  params.get('order[0][dir]');

        String atributoAOrdenar =  params.get("columns[" + columnaAOrdenar + "][data]");

        def parametrosCasteados = [max        : params?.length as Integer,
                                   offset     : params?.start as Integer,
                                   draw       : params?.draw as Integer,
                                   searchValue: params.get("search[value]") as String]

        def propertiesToRender = ['id', 'nombre', 'eje.nombre', 'descripcion']
        def propertiesToSearchIn = ['id', 'nombre', 'eje.nombre', 'descripcion']

        def data = dataTablesHelperService.getData(
                Tema,
                parametrosCasteados,
                propertiesToRender,
                propertiesToSearchIn,
                atributoAOrdenar,
                formaDeOrdenar
        )

        render data as JSON
    }

    def temaData(Long id) {
        Tema temaInstance = Tema.get(id)
        render temaInstance as JSON
    }

    def fetchTemplate(String templateName) {
        render template: templateName
    }

    protected void notFound() {
        render(status: 404)
    }
}
