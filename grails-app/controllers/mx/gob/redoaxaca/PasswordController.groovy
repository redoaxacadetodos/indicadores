package mx.gob.redoaxaca

import grails.converters.JSON

class PasswordController {

    def springSecurityService

    def index() {
        render(template: 'index')
    }

    def validatePassword(){
        Usuario user = springSecurityService.getCurrentUser() as Usuario
        springSecurityService.passwordEncoder
        Boolean valid = true

        String password = params.password

        if (!springSecurityService.passwordEncoder.isPasswordValid(user.password, password, null /*salt*/)) {
            valid = false
        }

        render([valid: valid] as JSON)
    }

    def updatePassword(String newPassword, String newUsername){
        Usuario user = springSecurityService.getCurrentUser() as Usuario
        user.username = newUsername
        user.password = newPassword

        user.passwordExpired = false
        user.save(flush: true, failOnError: true) // if you have password constraints check them here

        render(status: 204)
    }
}
