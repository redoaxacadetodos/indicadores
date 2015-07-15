import mx.gob.redoaxaca.Rol
import mx.gob.redoaxaca.Status
import mx.gob.redoaxaca.Usuario
import mx.gob.redoaxaca.UsuarioRol
import mx.gob.redoaxaca.Valor

class BootStrap {

    def init = { servletContext ->
        Valor.findByCampo('segundosEntreImagenes')?: new Valor(campo: 'segundosEntreImagenes', valor: '8').save(flush: true)

        Status.findByDescripcion('ACTIVO') ?: new Status(clave: 1, descripcion: 'ACTIVO').save()
        Status.findByDescripcion('INACTIVO') ?: new Status(clave: 0, descripcion: 'INACTIVO').save()

        def rolAdministrador = Rol.findByAuthority('ROLE_ADMIN') ?: new Rol(authority: 'ROLE_ADMIN').save(flush: true)

        def testUser = Usuario.findByUsername('admin') ?: new Usuario(username: 'admin', password: 'admin').save(flush: true, failOnError: true)


        UsuarioRol.create testUser, rolAdministrador, true

        assert Usuario.count() == 1
        assert Rol.count() == 1
        assert UsuarioRol.count() == 1
    }
    def destroy = {
    }
}
