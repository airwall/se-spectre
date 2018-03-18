<template lang="html">
  <a href="#" :class="this.cl" @click.prevent="destroy()">{{ cl == 'destroy' ? '' : 'Destroy' }}</a>
</template>

<script>
export default {
  props: ['id', 'cl'],
  methods: {
    destroy() {
      this.$emit('loader-on')
      if (this.cl == 'destroy') {
        var path = 'logins/' + this.id + '/destroy'
      } else {
        var path = this.id + '/destroy'
      }
      this.$http.post(path, {}).then(response => {
        setTimeout(() => {
          if (this.cl == 'destroy') {
            document.getElementById('login-' + this.id).remove()
          } else {
            window.location.href = '/logins'
          }
          this.$emit('loader-off')
        }, 3000)
      }, response => {
        this.$emit('loader-off')
      });
    }
  }
}
</script>

<style lang="css">
</style>
