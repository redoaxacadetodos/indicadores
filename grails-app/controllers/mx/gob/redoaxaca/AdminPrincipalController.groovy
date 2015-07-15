package mx.gob.redoaxaca

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class AdminPrincipalController {

    def index() {
        render(view: 'index')
    }

//    def volverAIndicador(){
//        render(template: '/indicador/index', layout: 'main')
//    }
}
