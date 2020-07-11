<template>
  <div class="seoul-map">
    <SeoulMap/>
  </div>
</template>

<script>
// @ is an alias to /src
import SeoulMap from '@/components/SeoulMap.vue'

export default {
  name: 'Seoul',
  components: {
    SeoulMap
  }
}
</script>
