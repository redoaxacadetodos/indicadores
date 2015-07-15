<form id="modalForm" class="form-horizontal">
    <div class="form-group">
        <label for="texto" class="col-sm-2 control-label">Texto</label>

        <div class="col-sm-10">
            <textarea rows="8" cols="50" name="texto" id="texto" class="form-control"
                      required
                      data-fv-notempty-message="Requerido">
            </textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="href" class="col-sm-2 control-label">Liga</label>

        <div class="col-sm-10">
            <input type="text" name="href" id="href" class="form-control"
                   required
                   data-fv-notempty-message="Requerido"/>
        </div>
    </div>

    <div class="form-group">
        <label for="hrefLabel" class="col-sm-2 control-label">Etiqueta en la liga</label>

        <div class="col-sm-10">
            <input type="text" name="hrefLabel" id="hrefLabel" class="form-control"
                   required
                   data-fv-notempty-message="Requerido"/>
        </div>
    </div>

    <div class="form-group">
        <label for="abrirEnTab" class="col-sm-2 control-label">Abrir en pestaña</label>

        <div class="col-sm-10">
            <input type="checkbox" name="abrirEnTab" id="abrirEnTab" value="1"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">Imagen (400x400)</label>

        <div class="col-sm-10">
            <input type="file" id="imagen" name="imagen" accept="image/*" class="form-control"
                   required
                   data-fv-notempty-message="Requerido"/>
        </div>
    </div>

    <div class="form-group">
        <label for="indice" class="col-sm-2 control-label">Indice</label>

        <div class="col-sm-2">
            <input id="indice" type="number" min="1" class="form-control"
                   name="indice"
                   required
                   data-fv-greaterthan-message="Debe ser mayor a 0"
                   data-fv-notempty-message="Requerido"
                   data-fv-integer-message="Tiene que ser un numero entero"
                   data-fv-digits-message="Solo numeros"/>
        </div>
    </div>

    %{--<div style="display: none">--}%
        %{--<div class="form-group">--}%
            %{--<label for="Tema" class="col-sm-2 control-label">Tema</label>--}%

            %{--<div class="col-sm-10">--}%
                %{--<g:select id="tema" name="tema.id" from="${Tema.list()}" optionKey="id" required="" class="many-to-one form-control"/>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%

    <input type="hidden" id="domain-id" name="id" value=""/>
</form>

%{--<script>--}%
    %{--$(function () {--}%
        %{--$('#imagen').on('fileclear', function() {--}%
            %{--console.log("fileclear");--}%
        %{--});--}%

        %{--$('#imagen').on('filebrowse', function() {--}%
            %{--console.log("filebrowse");--}%
        %{--});--}%
    %{--});--}%
%{--</script>--}%

