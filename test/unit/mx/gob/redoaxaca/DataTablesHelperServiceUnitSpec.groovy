package mx.gob.redoaxaca

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@TestFor(DataTablesHelperService)
@Mock([Eje, Dato])
class DataTablesHelperServiceUnitSpec extends Specification {
    def params
    def propertiesToRender
    ArrayList<String> propertiesToSearchIn

    def setup() {
        this.params = [
                max        : 10,
                offset     : 0,
                draw       : 0,
                searchValue: ''
        ]
        this.propertiesToRender = []


    }

    void "findsAll Instances"() {
        given:
        new Eje(nombre: 'eje 1', prefijo: 'J', status: 1).save(failOnError: true)
        new Eje(nombre: 'eje 2', prefijo: 'J', status: 1).save(failOnError: true)
        new Eje(nombre: 'eje 3', prefijo: 'J', status: 1).save(failOnError: true)

        this.propertiesToRender = ['nombre']
        this.propertiesToSearchIn = ['nombre']


        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()

        def expectedDataMap = [
                data           : [
                        [nombre: 'eje 1'],
                        [nombre: 'eje 2'],
                        [nombre: 'eje 3']
                ],
                recordsTotal   : size,
                recordsFiltered: size,
                draw           : this.params.draw + 1

        ]
        then:
        actualData == expectedDataMap
    }

    void "finds by name"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
        this.params.searchValue = eje1.nombre
        this.propertiesToRender = ['nombre']
        this.propertiesToSearchIn = ['nombre']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()

        def expectedDataMap = [
                data           : [
                        [nombre: eje1.nombre]
                ],
                recordsTotal   : Eje.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]

        then:
        actualData == expectedDataMap

    }

    void "renders a property"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
        this.propertiesToRender = ['id']

        when:
        def instancesAsMap = service.getDomainPropertiesAsMap([eje1], propertiesToRender)

        then:
        instancesAsMap == [
                ['id': 1]
        ]

    }

    void "renders 2 properties"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
        this.propertiesToRender = ['id', 'nombre']

        when:
        def instancesAsMap = service.getDomainPropertiesAsMap([eje1], propertiesToRender)

        then:
        instancesAsMap == [
                [
                        'id'    : 1,
                        'nombre': 'primer eje'
                ]
        ]

    }

    void "finds by name and 3 properties"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
        def eje2 = new Eje(nombre: 'primerisimo eje', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = 'primer'
        this.propertiesToRender = ['nombre', 'prefijo', 'status']
        this.propertiesToSearchIn = ['nombre']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje2.nombre,
                                prefijo: eje2.prefijo,
                                status : eje2.status
                        ],
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ]

                ],
                recordsTotal   : Eje.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]


        then:
        actualData == expectedDataMap

    }

    void "searches by 1 property"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', descripcion: 'yo soy el primero', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = eje1.descripcion
        this.propertiesToRender = ['nombre', 'prefijo', 'status']
        this.propertiesToSearchIn = ['descripcion']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ]

                ],
                recordsTotal   : Eje.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]

        then:
        actualData == expectedDataMap

    }

    void "searches by 2 properties"() {
        given:
        def eje1 = new Eje(nombre: 'Eje A', descripcion: 'yo soy el primero - Eje B', prefijo: 'J', status: 1).save(failOnError: true)
        def eje2 = new Eje(nombre: 'Eje B', descripcion: 'yo soy el segundo - Eje A', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = 'Eje A'
        this.propertiesToRender = ['nombre', 'prefijo', 'status']
        this.propertiesToSearchIn = ['descripcion', 'nombre']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje2.nombre,
                                prefijo: eje2.prefijo,
                                status : eje2.status
                        ],
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ]

                ],
                recordsTotal   : Eje.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]

        then:
        actualData == expectedDataMap

    }

    void "searches by id"() {
        given:
        def eje1 = new Eje(nombre: 'Eje A', descripcion: 'yo soy el primero - Eje B', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = eje1.id as String
        this.propertiesToRender = ['nombre', 'prefijo', 'status']
        this.propertiesToSearchIn = ['id', 'nombre', 'descripcion']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ]

                ],
                recordsTotal   : Eje.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]

        then:
        actualData == expectedDataMap

    }

    void "searches by decimal number"() {
        given:
        Indicador indicador = new Indicador(
                nombre: 'X',
                descripcion: 'X',
                tituloGrafica: 'X',
                metodoCalculo: 'X',
                formula: 'X',
                unidadMedida: 'X',
                sentido: 'X',
                unidadExpresion: 'X',
                fuente: 'X'
        )
        Dato dato = new Dato(tipo: 'dato', anio: 2014, valor: 215.15, indicador: indicador).save(failOnError: true)

        this.params.searchValue = dato.valor as String
        this.propertiesToRender = ['tipo', 'anio', 'valor']
        this.propertiesToSearchIn = ['valor']

        when:
        def actualData = service.getData(Dato, params, propertiesToRender, propertiesToSearchIn)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                tipo : dato.tipo,
                                anio : dato.anio,
                                valor: dato.valor
                        ]

                ],
                recordsTotal   : Dato.count,
                recordsFiltered: size,
                draw           : this.params.draw + 1
        ]

        then:
        actualData == expectedDataMap
    }
}
