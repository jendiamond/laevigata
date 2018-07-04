import Axios from 'axios'

export var formStore = {
  tabs: {
    about_me: {
      label: 'About Me',
      help_text: '',
      enabled: true,
      selected: true,
      completed: false,
      step: 1,
      inputs: {
        creator: { label: 'Student Name', value: [], required: true },
        school: { label: 'School', value: [] },
        graduation_date: { label: 'Graduation Date', value: [], required: true },
        post_graduation_email: { label: 'Post-Graduation Email', value: [], required: true }
      }
    },
    my_program: {
      label: 'My Program',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 2,
      inputs: {
        department: { label: 'Department', value: [] },
        partnering_agency: { label: 'Partnering Agency', value: [], required: true },
        subfield: { label: 'subfield', value: [], required: true },
        degree: { label: 'Degree', value: [], required: true },
        submitting_type: { label: 'Submitting Type', value: [], required: true }
      }
    },
    my_advisor: {
      label: 'My Advisor',
      help_text: '',
      description: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 3,
      inputs: {
        committee_chair: { label: 'Committee Chair', value: [], required: true },
        committee_members: { label: 'Committee Members', value: [], required: true }
      }
    },
    my_etd: {
      label: 'My Etd',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 4,
      inputs: {
        title: { label: 'Title', value: [], required: true },
        language: { label: 'Language', value: [], required: true },
        abstract: { label: 'Abstract', value: [], required: true, rich_text: true },
        table_of_contents: { label: 'Table of Contents', value: [], required: true, rich_text: true }
      }
    },
    keywords: {
      label: 'Keywords',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 5,
      inputs: {
        research_field: { label: 'Research Field', value: [], required: true },
        keyword: { label: 'Keyword', value: [], required: true },
        requires_permissions: {
          label: 'Requires Permissions Question',
          value: false,
          required: true
        },
        additional_copyrights: {
          label: 'Additional Copyrights Question',
          value: false,
          required: true
        },
        patents: {
          label: 'Patents Question',
          value: false,
          required: true
        }
      }
    },
    my_files: {
      label: 'My Files',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 6,
      inputs: {
        files: { label: 'files', value: [] }
      }
    },
    embargo: {
      label: 'Embargo',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 7,
      inputs: {
        embargo_length: { label: 'embargo_length', value: [], required: true },
        files_embargoed: { label: 'files_embargoed', value: [], required: true },
        abstract_embargoed: { label: 'abstract_embargoed', value: [], required: true },
        toc_embargoed: { label: 'toc_embargoed', value: [], required: true }
      }
    },
    submit: {
      label: 'Submit',
      help_text: '',
      enabled: false,
      selected: false,
      completed: false,
      step: 8
    }
  },
  departments: [],
  selectedDepartment: '',
  subfields: [],
  subfieldEndpoints: {
    'Biological and Biomedical Sciences': '/authorities/terms/local/biological_programs',
    'Biostatistics': '/authorities/terms/local/biostatistics_programs',
    'Business': '/authorities/terms/local/business_programs',
    'Environmental Sciences': '/authorities/terms/local/environmental_programs',
    'Epidemiology': '/authorities/terms/local/epidemiology_programs',
    'Psychology': '/authorities/terms/local/psychology_programs',
    'Executive Masters of Public Health - MPH': '/authorities/terms/local/executive_programs'
  },
  setSelectedDepartment (department) {
    this.selectedDepartment = department
  },
  getSelectedDepartment () {
    return this.selectedDepartment
  },
  getDepartments (selectedSchool) {
    Axios.get(selectedSchool).then(response => {
      this.departments = response.data
    })
  },
  getSubfields () {
    Axios.get(this.subfieldEndpoints[this.selectedDepartment]).then(response => {
      this.subfields = response.data
    })
  },
  toggleSelected (index) {
    this.tabs[index].selected = !this.tabs[index].selected
  }
}
