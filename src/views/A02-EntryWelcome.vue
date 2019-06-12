<i18n>
{
  "de": {
    "hello": "Howdi! Mein Name ist %{name}.",
    "hello_sub": "Ich begleite dich hier ab jetzt.",
    "journey": "Wir reisen nun gemeinsam über Europa in deine Heimatstadt.",
    "help": "Du kannst jederzeit die <span class='helpButton'>H</span> Taste drücken - ich eile dir dann zu Hilfe!",
    "start": "Klicke hier, um zu starten!"
  },
   "en": {
    "hello": "Howdi! My name is %{name}.",
    "hello_sub": "I will accompany you from here on.",
    "journey": "We now travel together across Europe to your hometown.",
    "help": "You can type the <span class='helpButton'>H</span> key at any time, and I'll come to assist you!",
    "start": "Press here to start!"
  }
}
</i18n>

<template>
  <div class="modal" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-body">
        <center>
          <h4>{{ $t("hello", {'name': this.$parent.$data.tutor.name}) }}</h4>
          <h6>{{ $t("hello_sub") }}</h6>
          <img class="tutor" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          <h6>{{ $t("journey") }}</h6>
          <p>
            <h6><span v-html="$t('help')"/> 🐢 💨</h6>
          </p>
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
  mounted() {
    this.$parent.$data.modalOpen = true;
  },

  methods: {
    next() {
      this.$router.push({ name: 'A03-EntryHomeTownSelect' });
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
