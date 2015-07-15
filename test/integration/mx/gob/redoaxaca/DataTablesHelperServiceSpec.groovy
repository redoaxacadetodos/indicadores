package mx.gob.redoaxaca

import grails.test.mixin.TestFor
import spock.lang.*

/**
 *
 */
@TestFor(DataTablesHelperService)
class DataTablesHelperServiceSpec extends Specification {
//    void "test"() {
//        given:
//        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
//        def eje2 = new Eje(nombre: 'eje 2', prefijo: 'primer', status: 1).save(failOnError: true)
//
//        when:
//        def instances = Eje.executeQuery(
//                "select new map(e.nombre as nombre, e.prefijo as prefijo) from Eje as e " +
//                        "where e.nombre like :searchValue or e.prefijo like :searchValue ",    [searchValue: '%primer%']
//        )
//
//        println instances
//
//        then:
//        instances == [eje1, eje2]
//
//
//    }
    def params
    def propertiesToRender
    String order
    ArrayList<String> propertiesToSearchIn

    def setup() {
        this.params = [
                max        : 10,
                offset     : 0,
                draw       : 0,
                searchValue: ''
        ]
        this.propertiesToRender = []
        order = 'nombre'
    }


    void "findsAll Instances"() {
        given:
        new Eje(nombre: 'eje 1', prefijo: 'J', status: 1).save(failOnError: true)
        new Eje(nombre: 'eje 2', prefijo: 'J', status: 1).save(failOnError: true)
        new Eje(nombre: 'eje 3', prefijo: 'J', status: 1).save(failOnError: true)

        this.propertiesToRender = ['nombre']
        this.propertiesToSearchIn = ['nombre']


        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
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
        new Eje(nombre: 'segundo eje', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = eje1.nombre
        this.propertiesToRender = ['nombre']
        this.propertiesToSearchIn = ['nombre']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
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

    void "finds by name and 3 properties"() {
        given:
        def eje1 = new Eje(nombre: 'primer eje', prefijo: 'J', status: 1).save(failOnError: true)
        def eje2 = new Eje(nombre: 'primerisimo eje', prefijo: 'J', status: 1).save(failOnError: true)

        this.params.searchValue = 'primer'
        this.propertiesToRender = ['nombre', 'prefijo', 'status']
        this.propertiesToSearchIn = ['nombre']

        when:
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ],
                        [
                                nombre : eje2.nombre,
                                prefijo: eje2.prefijo,
                                status : eje2.status
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
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
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
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
        def size = actualData.data.size()
        def expectedDataMap = [
                data           : [
                        [
                                nombre : eje1.nombre,
                                prefijo: eje1.prefijo,
                                status : eje1.status
                        ],
                        [
                                nombre : eje2.nombre,
                                prefijo: eje2.prefijo,
                                status : eje2.status
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
        def actualData = service.getData(Eje, params, propertiesToRender, propertiesToSearchIn, order)
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
        Eje eje = new Eje(nombre: 'X', descripcion: 'X', prefijo: 'X', status: 1).save(failOnError: true)

        Tema tema = new Tema(nombre: 'X', descripcion: 'X', eje: eje).save(failOnError: true)

        Indicador indicador = new Indicador(
                tema: tema,
                nombre: 'X',
                descripcion: 'X',
                tituloGrafica: 'X',
                metodoCalculo: 'X',
                formula: 'X',
                unidadMedida: 'X',
                sentido: 'X',
                unidadExpresion: 'X',
                fuente: 'X'
        ).save(failOnError: true)

        Dato dato = new Dato(tipo: 'dato', anio: 2014, valor: 215, indicador: indicador).save(failOnError: true)
        Dato dato2 = new Dato(tipo: 'dato2', anio: 2015, valor: 216, indicador: indicador).save(failOnError: true)

        this.params.searchValue = '215'
        this.propertiesToRender = ['tipo', 'anio', 'valor']
        this.propertiesToSearchIn = ['valor']

        when:
        def actualData = service.getData(Dato, params, propertiesToRender, propertiesToSearchIn, order)
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
