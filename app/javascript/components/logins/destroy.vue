<template lang="html">
  <li>
    <a href="#" class="destroy" @click.prevent="destroy()"></a>
  </li>
</template>

<script>
export default {
  props: ['id'],
  methods: {
    destroy() {
      this.$emit('loader-on')
      this.$http.post('logins/' + this.id + '/destroy', {}).then(response => {
        setTimeout(() => {
          document.getElementById('login-' + this.id).remove()
          this.$emit('loader-off')
        }, 300)
      }, response => {
        this.$emit('loader-off')
      });
    }
  }
}
</script>

<style lang="css">
</style>
