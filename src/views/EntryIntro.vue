<template>
  <div class="modal" v-bind:class="{ active: modalOpen }">
    <div class="modal-container">
      <div class="modal-body">
        <center>
          <h4>Howdi! 🖐 Mein Name ist Eliot. </h4>
          <h5>Ich begleite dich ab jetzt hier.</h5>
          <img class="img-responsive" src="/assets/wimmel/eliot.png"/>
          <h5>Du kannst zu jeder Zeit die <i><b>h</b></i> Taste drücken.
            Ich komme dir dann zu Hilfe geeilt 🐢 💨</h5>
          <p>
            <br/>
            <button @click="next()" class="btn btn-lg btn-success">
              Klicke hier um zu starten!
            </button>
          </p>
        </center>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EntryIntro',

  data() {
    return {
      modalOpen: true,
    };
  },
  methods: {
    next() {
      this.$router.push({ name: 'EntryHomeTownSelect' });
    },

    modalClose() {
      this.modalOpen = false;
    },
  },
};
</script>
