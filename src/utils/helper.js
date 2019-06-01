export default {
  sleep(s, callback) {
    setTimeout(() => {
      callback();
    }, s * 1000);
  },
};
