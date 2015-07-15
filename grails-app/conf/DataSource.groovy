hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            loggingSql = false
            pooled = false
            driverClassName = "org.postgresql.Driver"
            username = "USERNAME"
            password = "PASS"
            url = "jdbc:postgresql://HOST:PORT/DB"

            dbCreate = "update"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
        dataSource {
            loggingSql = true
            pooled = false
            driverClassName = "org.postgresql.Driver"
            username = "USERNAME"
            password = "PASS"
            url = "jdbc:postgresql://HOST:PORT/DB"
            dbCreate = "validate"
        }
    }
}
