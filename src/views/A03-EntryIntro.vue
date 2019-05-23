<i18n>
{
  "de": {
    "intro_1": "Du hast sicher schon mal vom Klimawandel gehört.",
    "intro_2": "Was hat es damit eigentlich auf sich?",
    "intro_3": "In deiner Heimatstadt %{homeTown} bla bla bla"
  }
}
</i18n>

<template>
  <div class="modal modal-lg" v-bind:class="{ active: modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-9">
            {{ $t("intro_1") }}<br/>
            {{ $t("intro_2") }}<br/>
            {{ $t("intro_3", { homeTown: homeTownName }) }}<br/>
            <img class="img-responsive tutor" src="/assets/example_graph.png"/>
          </div>
          <div class="column col-3"><img class="img-responsive tutor" src="/assets/wimmel/eliot.png"/></div>
        </div>
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
      homeTownName: null,
    };
  },

  mounted() {
    this.homeTownName = this.$parent.$data.homeTownName;
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
</style>
