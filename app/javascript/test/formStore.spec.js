/* global describe */
/* global it */
/* global expect */

import { formStore } from '../formStore'

window.localStorage = jest.fn()
window.localStorage.getItem = jest.fn()
window.localStorage.setItem = jest.fn()

formStore.getSavedOrSelectedSchool = jest.fn(() => {return 'Emory College'})
describe('formStore', () => {
  it('returns the correct embargo length based on the selected school', () => {
    formStore.setSelectedSchool('Emory College')
    expect(formStore.getEmbargoLengths()).toEqual([{ value: 'None - open access immediately', selected: 'selected' },
    { value: '6 months' }, { value: '1 year' }, { value: '2 years' }])
  })

  it('returns the correct embargo contents', () => {
    expect(formStore.getEmbargoContents()).toEqual([{
      text: 'Files',
      value: 'files_embargoed',
      disabled: false
    },
    {
      text: 'Files and Table of Contents',
      value: 'files_embargoed, toc_embargoed',
      disabled: false
    },
    {
      text: 'Files and Table of Contents and Abstract',
      value: 'files_embargoed, toc_embargoed, abstract_embargoed',
      disabled: false
    }
    ])
  })
})
