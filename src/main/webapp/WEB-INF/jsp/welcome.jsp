<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<script type="text/javascript" src = "/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src = "/echarts.min.js"></script>
</head>

<script type="text/javascript">

$(function(){
	 var mapChart;  
     var option;  
     $.get('./Beijing_TZQ_TOWN.json', function (beijingJson) {  
           echarts.registerMap('北京', beijingJson);   
           mapChart = echarts.init(document.getElementById('map-wrap'));   
           option = {  
               title:{  
                   text: '北京市通州区各镇分布图',  
                   left: 'center'  
               },  
               tooltip: {  
                   trigger: 'item',  
                   formatter: '{b}<br/>{c} (个)'  
               },  
               toolbox: {  
                  show: true,  
                  orient: 'vertical',  
                  left: 'right',  
                  top: 'center',  
                  feature: {  
                      dataView: {readOnly: false},  
                      restore: {},  
                      saveAsImage: {}  
                  }  
               },  
               visualMap: {  
                       min: 0,  
                       max: 0,  
                       text:['高','低'],  
                       realtime: false,  
                       calculable: true,  
                       inRange: {  
                           color: ['lightskyblue','yellow', 'orangered']  
                       }  
               },  
               series:[  
                   {  
                   	   name: '通州区各镇xxx统计图',  
                       type: 'map',  
                       map: '北京', // 自定义扩展图表类型  
                       aspectScale: 1.0, //地图长宽比. default: 0.75  
                       zoom: 1.1, //控制地图的zoom，动手自己更改下 看看什么效果吧  
                       roam: true,  
                       itemStyle:{  
                           normal:{label:{show:true}},  
                           emphasis:{label:{show:true}}  
                       },
                       data: []
                   }  
               ]  
           }  
           mapChart.setOption(option);      
     });
     
     $.ajax({
    	 method: 'POST',
    	 data: {},
    	 url: 'http://localhost:8080/getMapData.do',
    	 success: function(result){
    		 	console.info(result);
				if(result){
					//get max and series data
					var jsonObj = $.parseJSON(result);
					mapChart.setOption({
						
			     		visualMap: {
				           	min: 0,
				          	max: jsonObj.maxRange,
				           	text:['高','低'],
				           	realtime: false,
				           	calculable: true,
				           	inRange: {
				               color: ['lightskyblue','yellow', 'orangered']
				           	}
			     		},
						series:[{
				     				name: '通州区各镇xxx统计图',
				            	 	type: 'map',
				            	 	map: '北京', // 自定义扩展图表类型
				            	 	aspectScale: 1.0, //长宽比 default: 0.75
				            	 	zoom: 1.1,
				            	 	roam: true,
				               		itemStyle:{
				                   		normal:{label:{show:true}},
				                   		emphasis:{label:{show:true}}
				               	},
				      			data: jsonObj.data //json对象中的data, data为JSONArray
			     			}
			     		]
			 		});
		  		} 
    	 }
     })
})
</script>

<body>
	<nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Spring Boot</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="starter-template">
			<h1 style="color: #4EE2EC">Spring Boot + JSP + Echarts 制作地图示例</h1>
			<h3 style="color: #ED594E">系列三: ${message}</h3>
		</div>
		<div id="map-wrap" style="height: 500px;">

  		</div>
  		<div>
			<h3>欢迎关注微信公众号：ThinkingInGIS</h3>
			<img alt="微信公众号" src="/qrcode_for_thinkingingis.png">
		</div>
	</div>
	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>