import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource'
Vue.use(VueResource)

import LoginDestroy from '../components/logins/destroy'
import Loader from '../components/loader'

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  var elem = document.getElementById('app')

  if (elem != null) {
    var app = new Vue({
      data() {
        return {
          loaderActive: false,
        }
      },
      el: elem,
      components: {
        'login-destroy':LoginDestroy,
        Loader
      }
    })
  }
})
