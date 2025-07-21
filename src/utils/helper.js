export default {
  sleep(s, callback) {
    const delay = window.webpackHotUpdate ? 0 : s;
    setTimeout(() => {
      callback();
    }, delay * 1000);
  },
};
