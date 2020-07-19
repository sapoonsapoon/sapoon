<%--
  Created by IntelliJ IDEA.
  User: wonhyeongcho
  Date: 2020-07-19
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>서울 지도</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://d3js.org/d3.v5.min.js"></script>
    <script src="https://d3js.org/topojson.v1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="map-wrapper">
</div>
</body>
<script>
    $(function(){
        initMap();
    });

    function initMap () {
        d3.json('https://storage.googleapis.com/map-geo-json/seoul_municipalities_topo_simple.json')
            .then(function(data) {

            var width = $(window).width(), height = $(window).height();
            var svg = d3.select('.map-wrapper')
                .append('svg')
                .attr('width', width).attr('height', height);

            var geojson = topojson.feature(data, data.objects.seoul_municipalities_geo);

            // 지도 레이어
            var map = svg.append('g').attr('id', 'map');

            var projection = d3.geoMercator()
                .scale(1)
                .translate([0, 0]);

            var path = d3.geoPath().projection(projection);
            var bounds = path.bounds(geojson);
            var widthScale = (bounds[1][0] - bounds[0][0]) / width;
            var heightScale = (bounds[1][1] - bounds[0][1]) / height;
            var scale = 1 / Math.max(widthScale, heightScale);
            var xoffset = width / 2 - scale * (bounds[1][0] + bounds[0][0]) / 2;
            var yoffset = height / 2 - scale * (bounds[1][1] + bounds[0][1]) / 2;
            var offset = [xoffset, yoffset];
            projection.scale(scale).translate(offset);

            function guClick (d) {
                // 색 칠하기
                d3.select(this).style('fill', '#ffd8df');
                sapoon.postMesseage(d.properties.SIG_KOR_NM);
            }

            function guMouseOver (d) {
                d3.select(this).style('fill', '#dfdfe8');
            }

            function guMouseOut (d) {
                d3.select(this).style('fill', '#efefef');
            }

            map
                .selectAll('path')
                .data(geojson.features)
                .enter()
                .append('path')
                .attr('d', path)
                .on('click', guClick)
                .on('mouseout', guMouseOut)
                .on('mouseover', guMouseOver);

            map
                .selectAll('text')
                .data(geojson.features)
                .enter()
                .append('text')
                .attr('transform', function (d) { return 'translate(' + path.centroid(d) + ')' })
                .attr('dx', '-1.5em')
                .attr('dy', '.35em')
                .attr('class', 'municipality-label')
                .text(function (d) { return d.properties.SIG_KOR_NM });
        });
    }
</script>
<style lang="css">
    /*.map-wrapper {*/
    /*    width: 512px;*/
    /*    height: 512px;*/
    /*}*/

    svg path {
        fill: #efefef;
        stroke: white;
    }

    #gu-button {
        background-color: #40A940;
        border: 1px solid #ff0000;
        width: 50px; height: 50px;
        border-radius:75px;
        text-align:center;

        font-size:10px; color:#000000;
        vertical-align:middle;
        line-height:100px;
    }
</style>
</html>
