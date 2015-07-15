package mx.gob.redoaxaca

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Secured(['ROLE_ADMIN'])
class InfoElemController {

    def dataTablesHelperService

//    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        render(template: 'index')
    }

    @Transactional
    def save() {
        InfoElem infoElemInstance = new InfoElem()
        bindData(infoElemInstance, params, [exclude:['abrirEnTab']])

        if (infoElemInstance.hasErrors()) {
            println "-------------------------"
            println infoElemInstance.errors
            println "-------------------------"
            render(status: 422, errors: infoElemInstance.errors)
            return
        }

        String directorioImagenes = grailsApplication.config.imageindirect.basePath

        MultipartFile imagen = params.imagen
        String imgFileName = imagen.getOriginalFilename()

        File emptyImgFile = new File(directorioImagenes + imgFileName)

        if (!emptyImgFile.exists()) {
            emptyImgFile.mkdirs()
        }

        //Aqui se crea el archivo
        imagen.transferTo(emptyImgFile)

        infoElemInstance.imgFileName = imgFileName

        if (params.abrirEnTab) {
            infoElemInstance.abrirEnTab = true
        } else {
            infoElemInstance.abrirEnTab = false
        }

        infoElemInstance.save flush: true

        render(status: 201)

    }

    @Transactional
    def update() {
        InfoElem infoElemInstance = InfoElem.get(params?.id as Long)

        if (infoElemInstance == null) {
            notFound()
            return
        }

        if (infoElemInstance.hasErrors()) {
            render(status: 422)
            return
        }

        String dirImagenes = grailsApplication.config.imageindirect.basePath
        bindData(infoElemInstance, params, [exclude:['abrirEnTab']])

        if (params.imagen.getOriginalFilename()) {
            MultipartFile imagen = params.imagen
            String imgFileName = imagen.getOriginalFilename()
            File emptyImgFile = new File(dirImagenes + imgFileName)

            if (emptyImgFile.exists()) {
                emptyImgFile.delete()
            }

            emptyImgFile.mkdirs()

            imagen.transferTo(emptyImgFile)
            infoElemInstance.imgFileName = imgFileName
        }

        if (params.abrirEnTab) {
            println 'abrir tab true'
            infoElemInstance.abrirEnTab = true
        } else {
            println 'abrir tab false'
            infoElemInstance.abrirEnTab = false
        }

        infoElemInstance.save flush: true, failOnError: true

        render(status: 204)
    }

    @Transactional
    def delete() {
        InfoElem infoElemInstance = InfoElem.get(params?.id as Long)

        String dirImagenes = grailsApplication.config.imageindirect.basePath

        if (infoElemInstance == null) {
            notFound()
            return
        }

        File imgFile = new File(dirImagenes + infoElemInstance.imgFileName)
        imgFile.delete()

        infoElemInstance.delete(flush: true)

        render(status: 204)
    }

    def infoElemJSONData() {
        String columnaAOrdenar = params.get('order[0][column]');
        String formaDeOrdenar = params.get('order[0][dir]');

        String atributoAOrdenar = params.get("columns[" + columnaAOrdenar + "][data]");

        def parametrosCasteados = [max        : params?.length as Integer,
                                   offset     : params?.start as Integer,
                                   draw       : params?.draw as Integer,
                                   searchValue: params.get("search[value]") as String]

        def propertiesToRender = ['id', 'texto', 'imgFileName', 'indice']
        def propertiesToSearchIn = ['id', 'texto']

        def data = dataTablesHelperService.getData(
                InfoElem,
                parametrosCasteados,
                propertiesToRender,
                propertiesToSearchIn,
                atributoAOrdenar,
                formaDeOrdenar
        )

        render data as JSON
    }

    def infoElemData(Long id) {
        InfoElem infoElemInstance = InfoElem.get(id)
        render infoElemInstance as JSON
    }

    def fetchTemplate(String templateName) {
        render template: templateName
    }

    protected void notFound() {
        render(status: 404)
    }

    def validarIndice(Integer indice, Long id) {
        Boolean valid = true
        List indicesEnDB = InfoElem.executeQuery("select indice from InfoElem as i")
        List indicesNoPermitidos

        if (id) {
            Integer indiceDeLaEntidad = InfoElem.get(id).indice
            indicesNoPermitidos = indicesEnDB - indiceDeLaEntidad

        } else
            indicesNoPermitidos = indicesEnDB

        if (indicesNoPermitidos.contains(indice))
            valid = false;

        render([valid: valid] as JSON)
    }

    def updateSecondDelayInSlider(Integer seconds) {
        Valor segundos = Valor.findByCampo('segundosEntreImagenes')
        segundos.valor = seconds as String
        segundos.save(flush: true, failOnError: true)

//        grailsApplication.config.segundos.entre.imagenes = seconds
        render(status: 204)
    }

    def segundosEntreImagenes() {
        Valor segundos = Valor.findByCampo('segundosEntreImagenes')
        render([segundos: segundos.valor as Integer] as JSON)
    }
}
