<!DOCTYPE html>
<html>
<head>
    <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
    <meta name="layout" content="publico">
    <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
</head>
<body>
<g:if env="development">
    <g:renderException exception="${exception}" />
</g:if>
<g:else>
    <ul class="errors">
        <li>Ha ocurrido un error</li>
    </ul>
</g:else>
</body>
</html>
