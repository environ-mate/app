export default {
  sleep(s, callback) {
    if (window.webpackHotUpdate) {
      //s = 0;
    }
    setTimeout(() => {
      callback();
    }, s * 1000);
  },
};
