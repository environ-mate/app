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
  <div class="modal modal-lg" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>
        <button @click="navBack" class="btn btn-action"><i class="icon icon-arrow-left"></i></button>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">
            {{ $t("intro_1") }}<br/>
            {{ $t("intro_2") }}<br/>
            {{ $t("intro_3", { homeTown: this.$parent.$data.homeTownName }) }}<br/>
          </div>
          <div class="column col-3 flex-centered">
            <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-9">
            <img class="img-responsive" src="/assets/example_graph.png"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EntryIntro',

  mounted() {

  },

  methods: {
    next() {
      this.$router.push({ name: 'A03-EntryHomeTownSelect' });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>

<style scoped>
</style>
