<template>
  <div class="kakao-map">
    <KakaoMap/>
  </div>
</template>

<script>
// @ is an alias to /src
import KakaoMap from '@/components/KakaoMap.vue'

export default {
  name: 'Kakao',
  components: {
    KakaoMap
  }
}
</script>
