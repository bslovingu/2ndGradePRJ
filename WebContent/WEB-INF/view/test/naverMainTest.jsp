<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

.jeju {
	font-family: 'Jeju Gothic', sans-serif;
}

a {
	text-decoration: none;
}

a:hover {
	color: orange;
}

body {
	font-size: 16px;
}

.header, .content {
	width: 20rem;
	padding: 1rem;
	margin: 0 auto;
}

.header {
	position: relative;
}

h1 {
	padding: .5rem 1rem;
	margin: .5rem .5rem 0 .5rem;
	border-left: 0.1875rem solid #16a085;
	font-family: Helvetica, Arial, sans-serif;
	text-transform: uppercase;
	line-height: 130%;
}

.number {
	position: absolute;
	top: 2.1875rem;
	left: -1.25rem;
	color: #16a085;
	font-size: 2rem;
	font-family: Helvetiva, Arial, sans-serif;
}

.list {
	padding: .5rem 1rem;
	margin: .5rem .5rem 2rem .5rem;
	border-left: 0.1875rem solid #16a085;
}

.list__item {
	margin: 0 0 .5rem 0;
	padding: 0;
}

.label--checkbox, .label--radio {
	position: relative;
	margin: .5rem;
	font-family: Arial, sans-serif;
	line-height: 135%;
	cursor: pointer;
}

.checkbox {
	position: relative;
	top: -0.375rem;
	margin: 0 1rem 0 0;
	cursor: pointer;
}

.checkbox:before {
	-webkit-transition: -webkit-transform 0.4s
		cubic-bezier(0.45, 1.8, 0.5, 0.75);
	-moz-transition: -moz-transform 0.4s cubic-bezier(0.45, 1.8, 0.5, 0.75);
	transition: transform 0.4s cubic-bezier(0.45, 1.8, 0.5, 0.75);
	-webkit-transform: rotate(-45deg) scale(0, 0);
	-moz-transform: rotate(-45deg) scale(0, 0);
	-ms-transform: rotate(-45deg) scale(0, 0);
	-o-transform: rotate(-45deg) scale(0, 0);
	transform: rotate(-45deg) scale(0, 0);
	content: "";
	position: absolute;
	left: 0.1875rem;
	top: 0.125rem;
	z-index: 1;
	width: 0.75rem;
	height: 0.375rem;
	border: 2px solid #16a085;
	border-top-style: none;
	border-right-style: none;
}

.checkbox:checked:before {
	-webkit-transform: rotate(-45deg) scale(1, 1);
	-moz-transform: rotate(-45deg) scale(1, 1);
	-ms-transform: rotate(-45deg) scale(1, 1);
	-o-transform: rotate(-45deg) scale(1, 1);
	transform: rotate(-45deg) scale(1, 1);
}

.checkbox:after {
	content: "";
	position: absolute;
	top: -0.125rem;
	left: 0;
	width: 1rem;
	height: 1rem;
	background: #fff;
	border: 2px solid #f2f2f2;
	cursor: pointer;
}

.radio {
	position: relative;
	margin: 0 1rem 0 0;
	cursor: pointer;
}

.radio:before {
	-webkit-transition: -webkit-transform 0.4s
		cubic-bezier(0.45, 1.8, 0.5, 0.75);
	-moz-transition: -moz-transform 0.4s cubic-bezier(0.45, 1.8, 0.5, 0.75);
	transition: transform 0.4s cubic-bezier(0.45, 1.8, 0.5, 0.75);
	-webkit-transform: scale(0, 0);
	-moz-transform: scale(0, 0);
	-ms-transform: scale(0, 0);
	-o-transform: scale(0, 0);
	transform: scale(0, 0);
	content: "";
	position: absolute;
	top: 0;
	left: 0.125rem;
	z-index: 1;
	width: 0.75rem;
	height: 0.75rem;
	background: #16a085;
	border-radius: 50%;
}

.radio:checked:before {
	-webkit-transform: scale(1, 1);
	-moz-transform: scale(1, 1);
	-ms-transform: scale(1, 1);
	-o-transform: scale(1, 1);
	transform: scale(1, 1);
}

.radio:after {
	content: "";
	position: absolute;
	top: -0.25rem;
	left: -0.125rem;
	width: 1rem;
	height: 1rem;
	background: #fff;
	border: 2px solid #f2f2f2;
	border-radius: 50%;
}

.footer {
	position: relative;
}

.btn {
	-webkit-transition: background 0.3s ease-in-out;
	-moz-transition: background 0.3s ease-in-out;
	transition: background 0.3s ease-in-out;
	position: absolute;
	top: 0;
	right: 4.5rem;
	padding: .5rem;
	background: #16a085;
	color: #fff;
	font-family: Helvetica, Arial, sans-serif;
	text-decoration: none;
}

.btn:hover {
	background: #138a72;
}

.btn--twitter {
	right: 2rem;
	background: #2980b9;
}

.btn--twitter:hover {
	background: #2472a4;
}

.slider {
	-webkit-appearance: none;
	width: 40%;
	height: 20px;
	border-radius: 5px;
	background: #d3d3d3;
	outline: none;
	opacity: 0.7;
	-webkit-transition: .2s;
	transition: opacity .2s;
}

.slider::-webkit-slider-thumb {
	-webkit-appearance: none;
	appearance: none;
	width: 25px;
	height: 25px;
	border-radius: 50%;
	background: #4CAF50;
	cursor: pointer;
}

.slider::-moz-range-thumb {
	width: 25px;
	height: 25px;
	border-radius: 50%;
	background: #4CAF50;
	cursor: pointer;
}
</style>
<script src="/js/jquery-3.5.0.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script type="text/javascript"
	src="https://ssl.gstatic.com/trends_nrtr/2213_RC01/embed_loader.js"></script>

</head>
<body>
	<form id="testForm">
		<div class="slidecontainer">
			<div class="plat jeju">이슈별 묶어보기</div>
			<input type="range" min="0" max="4" value="0"
				onchange="slider_change()" class="slider" id="myRange1"
				name="myRange1">
		</div>
		<hr>
		<div class="slidecontainer jeju">
			<div class="plat">이벤트/할인</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange2"
				name="myRange2">
		</div>
		<hr>
		<div class="slidecontainer jeju">
			<div class="plat">시사</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange3"
				name="myRange3">
		</div>
		<hr>
		<div class="slidecontainer jeju">
			<div class="plat">엔터테인먼트</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange4"
				name="myRange4">
		</div>
		<hr>
		<div class="slidecontainer jeju">
			<div class="plat">스포츠</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange5"
				name="myRange5">
		</div>
		<hr>
		<div class="slidecontainer jeju">
			<div class="plat">연령대</div>
			<input type="range" min="0" max="5" value="0"
				onchange="slider_change()" class="slider" id="myRange6"
				name="myRange6">
		</div>
		<hr>

	</form>

	<script>
		$(document).ready(function() {
			slider_change();
		});
		function rel_func(elem, num) {

			$.ajax({
				url : '/relTest.do',
				type : 'post',
				dataType : 'json',
				data : elem,
				success : function(json) {
					console.log(num);
					console.log(json);
					var result = "";
					result += ("----------> ") + json;
					var div_id = "#rel_list" + (num + 1);
					$(div_id).html(result);
				}
			});
		}
		function slider_change() {
			var result = "";
			var data = {
				myRange1 : $('#myRange1').val(),
				myRange2 : $('#myRange2').val(),
				myRange3 : $('#myRange3').val(),
				myRange4 : $('#myRange4').val(),
				myRange5 : $('#myRange5').val(),
				myRange6 : $('#myRange6').val()
			};
			$
					.ajax({
						dataType : 'json',
						contentType : 'application/json; charset=utf-8',
						type : 'post',
						url : '/cssTest.do', // <<-- 처리 요청 URL
						data : JSON.stringify(data),
						success : function(json) {
							console.log("개같은 값들 : " + JSON.stringify(json));
							for (var i = 0; i < json.length; i++) {
								var rank = "";
								var rank_id = "#rank_list" + (i + 1);
								var keyword = "";
								var keyword_id = "#keyword_list" + (i + 1);
								var keyword_synonyms = "";
								var keyword_synonyms_id = "#keyword_synonyms_list"
										+ (i + 1);
								var parm = {
									"keyword" : json[i].keyword
								};
								rel_func(parm, i);
								rank += (json[i].rank + ". ");
								keyword += "<a href='javascript:void(0)' onclick='news({"
										+ '"keyword":'
										+ '"'
										+ json[i].keyword
										+ '"'
										+ "},"
										+ (i + 1)
										+ ")'>"
										+ json[i].keyword + "</a>";
								for (var j = 0; j < json[i].keyword_synonyms.length; j++) {
									if (j == 0) {
										keyword_synonyms += (" : ");
									}
									if (j != 0) {
										keyword_synonyms += (", ");
									}
									keyword_synonyms += (json[i].keyword_synonyms[j]);
								}
								$(rank_id).html(rank);
								$(keyword_id).html(keyword);
								$(keyword_synonyms_id).html(keyword_synonyms);
							}
						}
					});
		}

		function news(elem, num) {
			console.log(num);
			$
					.ajax({
						url : '/infoTest.do',
						type : 'post',
						dataType : 'json',
						data : elem,
						success : function(json) {
							console.log(json);
							var Arr = [];
							if (json.length > 100) {
								for (var i = 0; i < 100; i++) {
									Arr.push(json[i])
								}
							} else {
								for (var i = 0; i < json.length; i++) {
									Arr.push(json[i])
								}
							}
							console.log("개같은 값들 : " + json.length);
							var time = "";
							var rel_char = "";
							var com_opin = "";
							if (json[0].real_time[0] == "뉴스 시간 : 최근에 등록된 뉴스가 없습니다.") {
								var time_id = "최근에 등록된 뉴스가 없습니다.";
								$("#time_id").html(time_id);
								var rel_char = "분석가능한 뉴스 본문이 없습니다.";
								$("#rel_char").html(rel_char);
								var com_opin = "분석가능한 뉴스 댓글이 없습니다.";
								$("#com_opin").html(rel_char);
							} else {
								$("#rel_char").html('');
								$("#time_id").html('');
								$("#com_opin").html('');
								$("#sampDiv").html('');
								time += json[0].real_time[0];
								time += " ~ ";
								time += json[0].real_time[1];
								$("#time_id").html(time);
								com_opin += json[0].posCnt;
								com_opin += " / ";
								com_opin += json[0].negCnt;
								$("#com_opin").html(com_opin);
								am4core
										.ready(function() {
											// Themes begin
											am4core
													.useTheme(am4themes_animated);
											// Themes end
											var chart = am4core
													.create(
															"rel_char",
															am4plugins_wordCloud.WordCloud);
											var series = chart.series
													.push(new am4plugins_wordCloud.WordCloudSeries());
											series.randomness = 0.1;
											series.maxCount = 100;
											series.labels.template.tooltipText = "{word}: {cnt}";
											series.fontFamily = "Courier New";
											series.data = Arr;
											series.dataFields.word = "word";
											series.dataFields.value = "cnt";

										}); // end am4core.ready()

								var divElem = document
										.getElementById("sampDiv");
								trends.embed
										.renderExploreWidgetTo(
												divElem,
												"GEO_MAP",
												{
													"comparisonItem" : [ {
														"keyword" : json[0].keyword,
														"geo" : "KR",
														"time" : "now 1-H"
													} ],
													"category" : 0,
													"property" : ""
												},
												{
													"exploreQuery" : "date=now%201-H&geo=KR&q=%EB%85%B8%EB%AC%B4%ED%98%84,%EA%B5%AC%EB%AF%B8%20%EC%97%98%EB%A6%BC%EA%B5%90%ED%9A%8C,%EA%B2%80%EC%A0%95%EA%B3%A0%EC%8B%9C,%EC%96%B4%EB%A6%B0%EC%9D%B4%20%EA%B4%B4%EC%A7%88",
													"guestPath" : "https://trends.google.co.kr:443/trends/embed/"
												});
							}

						}
					});
		}
	</script>

	<div id="time_id" style="float: left;"></div>
	<br>
	<div id="com_opin" style="float: left;"></div>
	<div id="rel_char"></div>
	<hr>
	<%
		for (int i = 1; i <= 20; i++) {
	%>
	<div>
		<div id="rank_list<%=i%>" style="float: left;" class="jeju"></div>
		<div id="keyword_list<%=i%>" style="float: left; font-size: 15pt;"
			class="jeju"></div>
		<br>
		<div id="keyword_synonyms_list<%=i%>" style="float: left;"
			class="jeju"></div>
	</div>
	<br>
	<div id="rel_list<%=i%>" class="jeju"></div>
	<br>
	<hr>
	<%
		}
	%>

	<script type="text/javascript"
		src="https://ssl.gstatic.com/trends_nrtr/1328_RC04/embed_loader.js">
		
	</script>
	<div id='sampDiv'></div>
</body>
</html>