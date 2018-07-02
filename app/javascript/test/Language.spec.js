/* global describe */
/* global it */
/* global expect */
import { shallowMount } from '@vue/test-utils'
import Language from '../Language'

describe('Language.vue', () => {
  it('renders a form', () => {
    const wrapper = shallowMount(Language, {
    })
    expect(wrapper.findAll('select')).toHaveLength(1)
  })

  it('has a label that contains Submission Type', () => {
    const wrapper = shallowMount(Language, {
    })
    console.log(wrapper.html())
    expect(wrapper.findAll('label')).toHaveLength(1)
  })

  it('has the correct html', () => {
    const wrapper = shallowMount(Language, {
    })
    console.log(wrapper.html())
    expect(wrapper.html()).toEqual(`<div><label>Language</label> <select name="etd[language]" id="language" class="form-control"></select></div>`)
  })
})
