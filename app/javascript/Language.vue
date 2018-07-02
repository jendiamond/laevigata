<template>
    <div>
        <label>Language</label>
        <select name="etd[language]" class="form-control" id="language">
            <option v-for="language in languages" v-bind:value="language.id" v-bind:key='language.id' v-if="language.active">
                {{ language.label }}
            </option>
        </select>
    </div>
</template>

<script>
import Axios from "axios"
export default {
  data() {
    return {
      languageEndpoint: "/authorities/terms/local/languages_list",
      languages: {}
    }
  },
  methods: {
    fetchData() {
      Axios.get(this.languageEndpoint).then(response => {
        this.languages = response.data
      });
    }
  },
  created() {
    this.fetchData()
  }
}
</script>