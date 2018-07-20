<template>
  <div>
    <label for="subfield">Subfield</label>
    <select id="subfield" name="etd[subfield]" class="form-control">
      <option v-for="option in sharedState.subfields"  v-bind:value="option.value" v-bind:key='option.value'
      :selected='option.selected' :disabled='option.disabled'>
        {{ option.id }}
      </option>
    </select>
  </div>
</template>

<script>
import Vue from "vue"
import App from "./App"
import { formStore } from './formStore'

export default {
  data() {
    return {
      sharedState: formStore,
      selected: ''
    }
  },
  mounted: function(){
    this.$nextTick(function () {
      // you should only have both options and selected if there's a selected options
      if(this.sharedState.getSubfield() !== undefined){
        //okay, we need all of the subfields, not just the one selected guy, but we need him to be selected
        //this.sharedState.getSubfields()
        this.selected = this.sharedState.getSubfield()
      }
    })
  }
}
</script>

<style>
select {
  margin-bottom: 1em;
}
</style>
