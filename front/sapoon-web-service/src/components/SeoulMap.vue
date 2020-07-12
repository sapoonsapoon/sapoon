<template>
  <div class="map-wrapper">
  </div>
</template>

<script>

import * as d3 from 'd3'
import * as topojson from 'topojson'

export default {
  name: 'SeoulMap',
  mounted () {
    this.initMap()
  },
  methods: {
    initMap () {
      const seoulMap = require('../seoul_municipalities_topo_simple.json')
      const geojson = topojson.feature(seoulMap, seoulMap.objects.seoul_municipalities_geo)
      d3.geoCentroid(geojson)

      const width = 1000
      const height = 1000
      const svg = d3
        .select('.map-wrapper')
        .append('svg')
        .attr('width', width).attr('height', height)

      // 지도 레이어
      const map = svg.append('g').attr('id', 'map')

      const projection = d3.geoMercator()
        .scale(1)
        .translate([0, 0])

      const path = d3.geoPath().projection(projection)
      const bounds = path.bounds(geojson)
      const widthScale = (bounds[1][0] - bounds[0][0]) / width
      const heightScale = (bounds[1][1] - bounds[0][1]) / width
      const scale = 1 / Math.max(widthScale, heightScale)
      const xoffset = width / 2 - scale * (bounds[1][0] + bounds[0][0]) / 2 + 10
      const yoffset = height / 2 - scale * (bounds[1][1] + bounds[0][1]) / 2 + 80
      const offset = [xoffset, yoffset]
      projection.scale(scale).translate(offset)

      function guClick (d) {
        // 색 칠하기
        d3.select(this).style('fill', '#ffd8df')
        console.log('123')

        console.log('456')
      }

      function guMouseOver (d) {
        d3.select(this).style('fill', '#dfdfe8')
      }

      function guMouseOut (d) {
        d3.select(this).style('fill', '#efefef')
      }

      map
        .selectAll('path')
        .data(geojson.features)
        .enter()
        .append('path')
        .attr('d', path)
        .on('click', guClick)
        .on('mouseout', guMouseOut)
        .on('mouseover', guMouseOver)

      map
        .selectAll('text')
        .data(geojson.features)
        .enter()
        .append('text')
        .attr('transform', function (d) { return 'translate(' + path.centroid(d) + ')' })
        .attr('dx', '-1.5em')
        .attr('dy', '.35em')
        .attr('class', 'municipality-label')
        .text(function (d) { return d.properties.SIG_KOR_NM })
    }
  }
}
</script>

<style lang="stylus">
svg path {
  fill: #efefef
  stroke: white
}

#gu-button {
  background-color: #40A940
  border: 1px solid #ff0000
  width: 50px; height: 50px
  border-radius:75px
  text-align:center

  font-size:10; color:#000000
  vertical-align:middle
  line-height:100px
}
</style>
