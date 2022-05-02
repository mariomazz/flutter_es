function postMessageApp(message) {
  console.log(message);

  if (window.webkit && message != null) {
    window.webkit.messageHandlers.cordova_iab.postMessage(
      JSON.stringify({
        message: message,
      })
    );
  }
}
