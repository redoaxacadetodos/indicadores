package mx.gob.redoaxaca
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification
/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)

class HibernateHQLTest extends Specification {

    def setup() {

    }

    void "obtiene datos"() {
        given:
        def propertiesToRender = ['nombre']

        when:
        String selectQuery = "select new map("
        propertiesToRender.each {
            if (propertiesToRender.last() == it)
                selectQuery += "c.$it as $it) "
            else
                selectQuery += "c.$it, as $it "
        }

        then:
        selectQuery == "select new map(c.nombre as nombre) "

    }
}
