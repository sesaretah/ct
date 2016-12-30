
  var sendFile;

  sendFile = function(file, toSummernote) {
    var data;
    data = new FormData;
    data.append('upload[image]', file);
    return $.ajax({
      data: data,
      type: 'POST',
      url: '/upload',
      cache: false,
      contentType: false,
      processData: false,
      success: function(data) {
        console.log('file uploading...');
        return toSummernote.summernote("insertImage", data.url);
      }
    });
  };

  $(document).ready(function() {
    $('#note_content').each(function() {
      return $(this).summernote({
        height: 300,
        toolbar: [
      ['style', ['bold', 'italic', 'underline', 'clear']],
      ['fontsize', ['fontsize']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert',['ltr','rtl']],
      ['insert', ['link','picture']]
  ],
        codemirror: {
          lineWrapping: true,
          lineNumbers: true,
          tabSize: 2,
          theme: 'solarized'
        },
        callbacks: {
          onImageUpload: function(files) {
            return sendFile(files[0], $(this));
          }
        }
      });
    });
  });
