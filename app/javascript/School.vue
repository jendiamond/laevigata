<template>
  <div>
    <label for="school">School</label>
    <select v-if="!this.sharedState.getSavedSchool()" id="school" class="form-control" v-model="selected" aria-required="true" v-on:change="sharedState.setValid('About Me', false, ['My Program', 'Embargo'])">
      <option v-for="school in this.sharedState.schools.options" v-bind:value="school.value" v-bind:key='school.value' :selected='school.selected' :disabled='school.disabled'>
        {{ school.text }}
      </option>
    </select>
    <input type="hidden" name="etd[school]" :value="this.sharedState.getSchoolText(this.sharedState.getSavedOrSelectedSchool())" />
    <div v-if="this.sharedState.getSavedSchool()">
      <input type="hidden" name="etd[school]" :value="this.sharedState.getSchoolText(this.sharedState.getSavedOrSelectedSchool())" />
      <div class="no-edit-school">
        <div class="no-edit-school-name well">
          <b>{{ this.sharedState.getSchoolText(this.sharedState.getSavedOrSelectedSchool()) }}</b>
        </div>
        <div v-if="this.sharedState.allowTabSave()">
          <button type="button" class="start-over-button btn btn-danger" @click="sharedState.showStartOver = true">Start Over With a New School</button>
        </div>
      </div>
    </div>
    <start-over-modal></start-over-modal>
  </div>
</template>

<script>
import _ from 'lodash'
import { formStore } from './formStore'
import StartOverModal from './components/StartOverModal'
export default {
  data() {
    return {
      sharedState: formStore,
      selected: ''
    }
  },
  components: {
    startOverModal: StartOverModal
  },
  methods: {
    fetchData() {
      var selectedSchool = this.sharedState.schools[this.selected]
      this.sharedState.setSelectedSchool(this.selected)
      this.sharedState.getDepartments(selectedSchool)
    },
    // this only executes when the change event fires (user selects something)
    clearDepartmentAndSubfields() {
      this.sharedState.clearDepartment()
      this.sharedState.clearSubfields()
    }
  },
  mounted: function() {
    this.$nextTick(function() {
      this.selected = this.sharedState.getSavedOrSelectedSchool()
    })
  },
  watch: {
    selected() {
      //this executes when the component is rendered the first time and when the change event fires (user selects something)
      this.fetchData()
    }
  }
}
</script>

<style>
select {
  margin-bottom: 1em;
}

.no-edit-school {
  display: inline-block;
}

.no-edit-school-name {
  margin-bottom: .5em;
}
</style>
