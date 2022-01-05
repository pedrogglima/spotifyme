import { Controller } from '@hotwired/stimulus'
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = ['entries', 'pagination']
  static values = { fetching: Boolean }  
  
  async scroll() {
    const next_page = this.paginationTarget.querySelector("a[rel='next']")
    if (next_page == null) { return }

    let url = next_page.href
    let body = document.body, html = document.documentElement, bottomTrashold = 250;

    var height = Math.max( body.scrollHeight, 
      body.offsetHeight, 
      html.clientHeight, 
      html.scrollHeight, 
      html.offsetHeight 
    );

    const reachBottom = window.pageYOffset >= height - window.innerHeight - bottomTrashold
     
    if (reachBottom && this.fetchingValue == false) {
      this.fetchingValue = true

      await this.loadContent(url)
    }
  }

  async loadContent(url) {
    const request = new FetchRequest("get", url, { responseKind: 'json' })
    const response = await request.perform()
    
    if (response.ok) {
      const data = await response.json
      
      this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
      this.paginationTarget.innerHTML = data.pagination
      this.fetchingValue = false
    } else {
      // TODO: handle error
      this.fetchingValue = false
    }
  }
}