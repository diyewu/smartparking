<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>map</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="../echarts/js/jquery.js"></script>
	<script src="../echarts/js/echarts.min.js"></script>
	<script src="../echarts/js/echarts-gl.min.js"></script>
  </head>
  
  <body>
     <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 600px;height:400px;"></div>
  </body>
  <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var option = {
                title: {
                    text: 'ECharts 入门示例'
                },
                tooltip: {},
                legend: {
                    data:['销量']
                },
                xAxis: {
                    data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
                },
                yAxis: {},
                series: [{
                    name: '销量',
                    type: 'bar',
                    data: [5, 20, 36, 10, 10, 20]
                }]
            };
        // 指定图表的配置项和数据
        var option1 = {
        	    backgroundColor: '#000',
        	    globe: {
        	        baseTexture: '../echarts/img/data-1491890179041-Hkj-elqpe.jpg',
        	        heightTexture: '../echarts/img/data-1491889019097-rJQYikcpl.jpg',

        	        displacementScale: 0.1,

        	        shading: 'lambert',
        	        
        	        environment: '../echarts/img/data-1491837999815-H1_44Qtal.jpg',
        	        
        	        light: {
        	            ambient: {
        	                intensity: 0.1
        	            },
        	            main: {
        	                intensity: 1.5
        	            }
        	        },

        	        layers: [{
        	            type: 'blend',
        	            blendTo: 'emission',
        	            texture: '../echarts/img/data-1491890291849-rJ2uee5ag.jpg'
        	        }, {
        	            type: 'overlay',
        	            texture: '../echarts/img/data-1491890092270-BJEhJg96l.png',
        	            shading: 'lambert',
        	            distance: 5
        	        }]
        	    },
        	    series: []
        	}

        // 使用刚指定的配置项和数据显示图表。
        $(document).ready(function () { 
        	alert(123);
        	myChart.setOption(option1);
        });
    </script>
</html>
