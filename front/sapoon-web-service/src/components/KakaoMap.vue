<template>
  <div id="map" style="width:700px; height:700px;"></div>
</template>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=606e4bc81886e03a0099da6432430def&libraries=services"></script>
<script>
export default {
  name: 'KaKaoMap',
  mounted() {
    window.kakao && window.kakao.map ? this.initMap() : this.addScript();
  },
  methods: {
    addScript() {
      const script = document.createElement('script');
      script.onload = () => kakao.maps.load(this.initMap);
      // script.src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=606e4bc81886e03a0099da6432430def";
      script.src = "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=606e4bc81886e03a0099da6432430def&libraries=services";
      document.head.appendChild(script);
    },
    initMap() {
      var container = document.getElementById('map');

      // 마커 클릭 시 장소명 표출
      var infoWindow = new kakao.maps.InfoWindow({zIndex:1});

      var options = {
        // 지도의 중심 좌표
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
      }
      var map = new kakao.maps.Map(container, options);

      // 장소 검색 객체
      var ps = new kakao.maps.services.Places();
      ps.keywordSearch('석촌호수산책길', placesSearchCB);

      function placesSearchCB(data, status, pagination) {
        if(status === kakao.maps.services.Status.OK) {
          // 검색된 장소로 지도 범위 재설정
          var bounds = new kakao.maps.LatLngBounds();

          for(var i = 0; i < data.length; i++) {
            displayMarker(data[i]);
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
          }
          map.setBounds(bounds);
        }
      }

      function displayMarker(place) {
        var marker = new kakao.maps.Marker({
          map: map,
          position: new kakao.maps.LatLng(place.y, place.x)
        });

        kakao.maps.event.addListener(marker, 'click', function() {
          infoWindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
          infoWindow.open(map, marker);
        });
      }
    }
  }
}
</script>
