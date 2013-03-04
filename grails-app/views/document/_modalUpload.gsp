
<!-- Modal Upload -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Upload your files</h3>
    </div>
    <div class="modal-body">
        <div id="progress" class="progress">
            <div class="bar" style="width: 0%;height: 18px"></div>
        </div>
        <table id="fileUploader" class="table table-bordered table-condensed"></table>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        <span class="btn btn-primary fileinput-button">
            <i class="icon-plus icon-white"></i>
            <span>Add files...</span>
            <input id="fileupload" type="file" name="files[]" data-url="fileupload" multiple>
        </span>
    </div>
</div>

<r:script>
    $(function () {
        $.ajax({
            url: "${createLink(controller:"document",action:"ajaxGetFiles")}"
        }).done(function(data) {
                    $('#fileContainer').html('');
                    $.each(data, function (index, file) {
                        $('<p/>').text(file.name + " ("+file.size+")").appendTo("#fileContainer");
                    });
                });

        $('#fileupload').fileupload({
            dataType: 'json',
            //maxFileSize: 5000000,       //5MB
            //acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,

            add: function (e, data) {
                $.each(data.files, function (index, file) {
                    $('#fileUploader').append('<tr data-file="'+file.name+'"><td>'+file.name + ' ('+file.size+')'+'</td></tr>');
                });
                data.submit();
            },
            done: function (e, data) {
                $.each(data.result, function (index, file) {
                    $('#fileUploader tr[data-file="'+file.name+'"]')
                            .addClass('success')
                            .html('<td>'+file.name + ' ('+file.size+')'+'<span class="pull-right"><i class="icon-ok"></i></span></td>')

                });
            },
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('#progress')
                        .attr('aria-valuenow', progress)
                        .find('.bar').css(
                                'width',
                                progress + '%'
                        );
            }
        });
    });

</r:script>