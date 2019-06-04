<i18n>
{
  "de": {
    "hello": "Howdi! Mein Name ist %{name}.",
    "hello_sub": "Ich begleite dich hier ab jetzt.",
    "help": "Du kannst zu jederzeit die <i><b>h</b></i> Taste drücken. Ich eile dir dann zu Hilfe!",
    "start": "Klicke hier um zu starten!"
  }
}
</i18n>

<template>
  <div class="modal modal-bottom" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-body">
        <center>
          <h5>{{ $t("hello", {'name': this.$parent.$data.tutor.name}) }}</h5>
          <h6>{{ $t("hello_sub") }}</h6>
          <img class="tutor" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          <h6>
            <span v-html="$t('help')"/> 🐢 💨
          </h6>
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
import Helper from '@/utils/helper';

export default {
  mounted() {
    // fly map to europe
    this.$parent.map.flyToBounds([
      [50.99995, 9.99995],
      [51.00005, 10.00005],
    ], this.$parent.$options.flyToOptions(4, 5, 1.0));

    this.$parent.map.once('moveend', () => {
      Helper.sleep(3, () => {
        this.$parent.$data.modalOpen = true;
      });
    });
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
