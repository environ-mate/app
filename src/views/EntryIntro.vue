<i18n>
{
  "de": {
    "hello": "Howdi! 🖐 Mein Name ist Eliot.",
    "helloSub": "Ich begleite dich ab jetzt hier.",
    "help": "Du kannst zu jeder Zeit die <i><b>h</b></i> Taste drücken. Ich komme dir dann zu Hilfe geeilt 🐢 💨",
    "start": "Klicke hier um zu starten!"
  }
}
</i18n>

<template>
  <div class="modal" v-bind:class="{ active: modalOpen }">
    <div class="modal-container">
      <div class="modal-body">
        <center>
          <h5>{{ $t("hello") }}</h5>
          <h6>{{ $t("helloSub") }}</h6>
          <img class="img-responsive tutor" src="/assets/wimmel/eliot.png"/>
          <h6 v-html="$t('help')"></h6>
          <p>
            <br/>
            <button @click="next()" class="btn btn-lg btn-success">
              {{ $t("start") }}
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
      modalOpen: false,
    };
  },

  mounted() {
    this.$parent.map.once('moveend', () => this.modalOpen = true );
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

<style scoped>
  @media screen and (max-height: 640px) {
    .tutor {
      height: 85px;
    }
  }

  @media screen and (min-height: 640px) and (max-height: 667px) {
    .tutor {
      height: 100px;
    }
  }

  @media screen and (min-height: 667px) and (max-height: 736px) {
    .tutor {
      height: 220px;
    }
  }

  @media screen and (min-height: 736px) and (max-height: 768px) {
    .tutor {
      height: 280px;
    }
  }
</style>
