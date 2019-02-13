document.addEventListener('DOMContentLoaded', function(event) {
  function fetchResults(pollUrl, url, text) {
    Rails.ajax({
      type: 'GET',
      url: url,
      data: 'location=' + text,
      contentType: 'json',
      success: function(response, status, xhr) {
        if (dataReady(response)) return;
        pollResults(pollUrl, response.key);
      }
    });
  };

  function dataReady(response) {
    return !response.key;
  };

  function pollResults(url, key) {
    var elem = document.getElementsByClassName('result-section')[0]
    elem.innerHTML = '<div>Request is being processed and results will be available shortly.</div>'
    var requestCounter = 0;
    window.pollInterval = setInterval(function() {
      Rails.ajax({
        type: 'GET',
        url: url,
        data: 'poll_key=' + key,
        success: function() {
          requestCounter += 1;
          if (!shouldRetry(requestCounter)) { stopRetry(elem) }
        }
      });
    }, 1000);
  }

  function shouldRetry(counter) {
    var maxRetries = 60;
    return counter < maxRetries;
  }

  function stopRetry(elem) {
    elem.innerHTML = '<div>The data is not available now, please try again in 10 min.</div>'
    clearInterval(window.pollInterval)
  }

  document.getElementById('search_button').addEventListener("click", function(e) {
    var url = this.dataset.url
    var pollUrl = this.dataset.pollUrl
    var textField = document.getElementById('search_input');
    var text = textField.value;
    fetchResults(pollUrl, url, text);
  });
});
