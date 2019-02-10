document.addEventListener('DOMContentLoaded', function(event) {
  document.getElementById('search_button').addEventListener("click", function(e) {
    var url = this.dataset.url
    var text_field = document.getElementById('search_input');
    var text = text_field.value;
    Rails.ajax({
      type: 'GET',
      url: url,
      data: 'location=' + text,
      success: function(response) {
        // console.log(response);
      },
      error: function(response) {
        // console.log(response);
      }
    });
  });
});
