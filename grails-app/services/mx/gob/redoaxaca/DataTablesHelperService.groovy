package mx.gob.redoaxaca

import grails.transaction.Transactional

@Transactional
class DataTablesHelperService {

    def getData(Class clase, def params, List<String> propertiesToRender, List<String> propertiesToSearchIn, String attributeToOrder, String orderBy) {

        Integer total = clase.count()
        def instances
        Integer recordsFiltered
        String selectQuery = createSelectQueryFrom(propertiesToRender) + "from ${clase.getName()} as c "
        String searchValue = params.searchValue

        if (searchValue) {
            List<String> filters = []
            searchValue = "%$searchValue%"
            propertiesToSearchIn.each { prop -> filters << "lower(cast (c.${prop} as string)) like lower(:searchValue)" }
            String searchFilter = filters.join(" or ")

            selectQuery += "where $searchFilter "
            selectQuery += "order by c.$attributeToOrder $orderBy"
            instances = clase.executeQuery(selectQuery, [max: params.max, offset: params.offset, searchValue: searchValue])

            recordsFiltered = clase.executeQuery(selectQuery, [searchValue: searchValue]).size()
        } else {
            selectQuery += "order by c.$attributeToOrder $orderBy"
            instances = clase.executeQuery(selectQuery, [max: params.max, offset: params.offset])
            recordsFiltered = total
        }

        def allData = ["data": instances, "recordsTotal": total, "recordsFiltered": recordsFiltered, "draw": params.draw + 1]

        return allData
    }

    String createSelectQueryFrom(List<String> propertiesToRender) {
        String selectQuery = "select new map("
        propertiesToRender.each { atributo ->

            String atributoSinPunto = atributo
            if (atributoSinPunto.contains('.')) {
                atributoSinPunto = atributo.split("\\.")[0];
            }

            selectQuery += "cast(c.$atributo as text) as $atributoSinPunto "

            if (propertiesToRender.last() == atributo) {
                selectQuery += ") "
            } else
                selectQuery += ", "
        }

        return selectQuery
    }

    def getDatosForDataTables(String searchValue, Integer max, Integer offset, Integer draw) {

        def total = Dato.count()
        String hql = "from Dato as d "
        if (searchValue) {
            hql += "where " +
                    "upper(cast(d.valor as string)) like '%${searchValue.toUpperCase()}%' or " +
                    "upper(cast(d.indicador.nombre as string)) like '%${searchValue.toUpperCase()}%' or " +
                    "upper(cast(d.anio as string)) like '%${searchValue.toUpperCase()}%'"
        }

        def datos = Dato.executeQuery(hql, [max: max, offset: offset])
        def datosList = []

        datos.each { dato ->
            def indicadorMap = [:]

            indicadorMap.put('id', dato?.id)
            indicadorMap.put('tipo', dato?.tipo)
            indicadorMap.put('anio', dato?.anio)
            indicadorMap.put('descripcion', dato?.descripcion)
            indicadorMap.put('valor', dato?.valor)
            indicadorMap.put('indicador', dato?.indicador?.toString())

            datosList.add(indicadorMap)
        }

        def allData = ["data": datosList, "recordsTotal": total, "recordsFiltered": total, "draw": draw + 1]
        return allData
    }
//------------------------------------------//
// La misma funcion pero usando relfexion...//
//------------------------------------------//

//    def getData(Class clase, def params, def propertiesToRender, def propertiesToSearchIn) {
//
//        def total = clase.count()
//        def instances
//        def criteria = clase.createCriteria()
//        String searchValue = params.searchValue
//
//        if (searchValue) {
//            instances = criteria.list(max: params.max, offset: params.offset) {
//                or {
//                    propertiesToSearchIn.each {
//                        if (NumberUtils.isNumber(searchValue)) {
//                            eq(it, params.searchValue)
//                        } else
//                            ilike(it, "%${params.searchValue}%")
//                    }
//                }
//            }
//        } else {
//            instances = clase.findAll()
//        }
//
//        def domainClassesList = getDomainPropertiesAsMap(instances, propertiesToRender)
//
//        def allData = ["data": domainClassesList, "recordsTotal": total, "recordsFiltered": domainClassesList.size(), "draw": params.draw + 1]
//
//        return allData
//    }
//
//    def getDomainPropertiesAsMap(instancesList, propertiesToRender) {
//        def domainClassesList = []
//
//        instancesList.each { domain ->
//            def domainMap = [:]
//
//            propertiesToRender.each { String property ->
//                Method method = domain.getClass().getMethod("get${property.capitalize()}")
//
//                domainMap.put(property, method.invoke(domain))
//            }
//
//            domainClassesList.add(domainMap)
//        }
//        return domainClassesList
//    }
}
