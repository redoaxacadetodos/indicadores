package mx.gob.redoaxaca
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(['ROLE_ADMIN'])
@Transactional
class IndicadorController{

    def dataTablesHelperService

    def index() {
        render(template: 'index')
    }

    def save() {
        Indicador indicadorInstance = new Indicador(params)

        if (indicadorInstance.hasErrors()) {
            render(status: 422, errors: indicadorInstance.errors)
            return
        }

        indicadorInstance.save flush:true

        render(status: 201)
    }

    def update() {
        Indicador indicadorInstance = Indicador.get(params?.id as Long)

        if (indicadorInstance == null) {
            notFound()
            return
        }

        if (indicadorInstance.hasErrors()) {
            render(status: 422, errors: indicadorInstance.errors)
            return
        }

        indicadorInstance.properties = params
        indicadorInstance.save()

        render(status: 204)
    }

    def delete() {
        Indicador indicadorInstance = Indicador.get(params?.id as Long)

        if (indicadorInstance == null) {
            notFound()
            return
        }

        Tema temaPadre = indicadorInstance.tema
        temaPadre.removeFromIndicadores(indicadorInstance)

        indicadorInstance.delete(flush: true)

        render(status: 204)
    }


    def indicadoresJSONData() {

        String columnaAOrdenar = params.get('order[0][column]');
        String formaDeOrdenar =  params.get('order[0][dir]');

        String atributoAOrdenar =  params.get("columns[" + columnaAOrdenar + "][data]");

        def parametrosCasteados = [max        : params?.length as Integer,
                                   offset     : params?.start as Integer,
                                   draw       : params?.draw as Integer,
                                   searchValue: params.get("search[value]") as String]

        def propertiesToRender = ['id', 'nombre', 'fuente', 'tema.nombre']
        def propertiesToSearchIn = ['nombre', 'fuente', 'tema.nombre']

        def data = dataTablesHelperService.getData(
                Indicador,
                parametrosCasteados,
                propertiesToRender,
                propertiesToSearchIn,
                atributoAOrdenar,
                formaDeOrdenar
        )


        render data as JSON
    }

    def indicadorData(Long id) {
        Indicador indicadorInstance = Indicador.get(id)
        render indicadorInstance as JSON
    }

    def fetchTemplate(String templateName) {
        render template: templateName
    }

    protected void notFound() {
        render(status: 404)
    }
}
