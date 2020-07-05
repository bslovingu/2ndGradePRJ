<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userId = (String) session.getAttribute("userId");
	String userAuthor = (String) session.getAttribute("userAuthor");
%>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<title>개인 프로젝트</title>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800"
	rel="stylesheet" />
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<!-- Nucleo Icons -->
<link href="/css/nucleo-icons.css" rel="stylesheet" />
<!-- CSS Files -->
<link href="/css/black-dashboard.css?v=1.0.0" rel="stylesheet" />
<script type="text/javascript"
	src="https://ssl.gstatic.com/trends_nrtr/2213_RC01/embed_loader.js"></script>
<style type="text/css">
.block-27 ul {
	padding: 0;
	margin: 0;
}

.btn_alert {
	background-color: #F7CAC9;
	border-color: #F7CAC9;
}

.btn_alert:hover {
	background-color: #f7b6b5 !important;
	border-color: #f7b6b5 !important;
}

.block-27 ul li {
	display: inline-block;
	font-weight: 400;
}

.block-27 ul li a, .block-27 ul li span {
	color: dodgerblue;
	text-align: center;
	display: inline-block;
	width: 40px;
	height: 40px;
	line-height: 40px;
	border-radius: 50%;
	border: 1px solid #e6e6e6;
}

.block-27 ul li.active a, .block-27 ul li.active span {
	background: #E3F1FF;
	color: dodgerblue;
	border: 1px solid #e6e6e6;
}

h2 a:hover {
	color: aliceblue !important;
}

.div_content_container {
	display: table;
	table-layout: fixed;
	width: 100%;
	border: 1px solid #dee2e6;
}

.linkbody_content_container {
	display: table;
	table-layout: fixed;
	width: 100%;
	border-bottom: 1px solid #666666;
}

.linkheader_content_container {
	display: table;
	table-layout: fixed;
	width: 100%;
	border-top: 1px solid #666666;
	border-bottom: 1px solid #666666;
}

.linkdiv_content_box {
	display: table-cell;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	text-align: center;
}

.link_1st {
	width: 70%;
}

.div_content_box {
	display: table-cell;
	border: 1px solid #dee2e6;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	padding-top: 5px;
	padding-bottom: 5px;
	text-align: center;
}

.search_box {
	margin-right: 5px;
}

.table_1st {
	width: 8%;
}

.table_3rd {
	width: 15%;
}

.table_5th {
	width: 10%;
}

#ticker {
	float: left;
	width: 100%;
}

.navi {
	float: right;
}

.recommend_text {
	height: 30px;
	overflow: hidden;
	width: 200px;
}

.recommend_text ul, .recommend_text li {
	margin: 0;
	padding: 0;
	list-style: none;
}

.recommend_text li a {
	height: 30px;
	line-height: 30px;
	color: black;
	display: block;
	text-decoration: none;
	text-overflow: ellipsis;
}
</style>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

.jeju {
	font-family: 'Jeju Gothic', sans-serif;
}

::-webkit-scrollbar {
	width: 10px;
}

::-webkit-scrollbar-thumb {
	background-color: white;
	border-radius: 10px;
}

::-webkit-scrollbar-track {
	background-color: grey;
	border-radius: 10px;
	box-shadow: inset 0px 0px 5px white;
}

.row {
	width: 100%;
	margin: 0 auto;
}
</style>
<script src="/js/core/jquery.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/dark.js"></script>
<script src="/js/jquery-3.5.0.min.js"></script>
<script src="/js/core/popper.min.js"></script>
<script src="/js/core/bootstrap.min.js"></script>
<script src="/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Google Maps Plugin    -->
<!-- Place this tag in your head or just before your close body tag. -->
<!--  Notifications Plugin    -->
<script src="/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="/js/black-dashboard.min.js?v=1.0.0"></script>
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
				result += (" ") + json;
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
		$.ajax({
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
					rank += (json[i].rank + ".  ");
					keyword += "<a href='javascript:void(0)' onclick='news({"
							+ '"keyword":' + '"' + json[i].keyword + '"' + "},"
							+ (i + 1) + ")'>" + json[i].keyword + "</a>";
					for (var j = 0; j < json[i].keyword_synonyms.length; j++) {
						if (j == 0) {
							keyword_synonyms += (" ");
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
</script>
</head>

<body class="">
	<%@include file="/WEB-INF/view/user/frame/ModalLoginAdmin.jsp"%>
	<%@include file="/WEB-INF/view/user/frame/TopbarLoginAdmin.jsp"%>
	<!-- End Navbar -->
	<div class="content">
		<!-- 탑바 -->
		<div class="row">
			<div class="col-12">
				<div class="card card-chart">
					<div class="card-header ">
						<div class="row">
							<div class="col-sm-10 text-left" style="margin: auto;">
								<h4 class="card-title jeju" style="float: left;">It's u,
									Issue!</h4>
								<%
									if (userAuthor.equals("1")) {
								%>
								<p class="card-category d-inline jeju"
									style="float: right; margin-right: 5px; margin-left: 5px;">
									<a href="javascript:void(0)" class="nav-link"
										onclick="getUserList(1,'')" data-toggle="modal"
										data-target="#crm_modal" data-backdrop="static">회원관리</a>
								</p>
								<%
									} else {
								%>
								<p class="card-category d-inline jeju"
									style="float: right; margin-right: 5px; margin-left: 5px;">
									<a href="javascript:void(0)" class="nav-link"
										onclick="getUserList(1,'')" data-toggle="modal"
										data-target="#contact_modal" data-backdrop="static">Contact</a>
								</p>
								<%
									}
								%>
								<p class="card-category d-inline jeju"
									style="float: right; margin-right: 5px; margin-left: 5px;">
									<a href="javascript:void(0)" class="nav-link"
										onclick="getUserInfo()" data-toggle="modal"
										data-target="#mypage_modal" data-backdrop="static">MYPAGE</a>
								</p>
								<p class="card-category d-inline jeju"
									style="float: right; margin-right: 5px; margin-left: 5px;">
									<a href="/Logoutbtn.do" class="nav-link">로그아웃</a>
								</p>

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-4 col-md-12">
				<div class="card ">
					<div class="card-header">
						<i class="tim-icons icon-bullet-list-67 text-warning"
							style="float: left;"></i>
						<p class="card-title jeju" style="float: left;">&nbsp;분류 선택</p>
						<p class="card-category d-inline jeju" style="float: right;">검색어
							설정</p>
					</div>
					<div class="card-body">
						<div class="table-full-width ">
							<!-- 여기서 검색어 설정 -->
							<form id="testForm">
								<div class="slidecontainer" style="width: 100%;">

									<div class="plat jeju text-white" style="text-align: center;">이슈별
										묶어보기</div>
									<input type="range" min="0" max="4" value="0"
										onchange="slider_change()" class="slider" id="myRange1"
										name="myRange1" style="width: 100%;">
								</div>
								<hr>
								<div class="slidecontainer jeju">
									<div class="plat jeju text-white" style="text-align: center;">이벤트/할인</div>
									<input type="range" min="-2" max="2" value="-2"
										onchange="slider_change()" class="slider" id="myRange2"
										name="myRange2" style="width: 100%;">
								</div>
								<hr>
								<div class="slidecontainer jeju">
									<div class="plat jeju text-white" style="text-align: center;">시사</div>
									<input type="range" min="-2" max="2" value="-2"
										onchange="slider_change()" class="slider" id="myRange3"
										name="myRange3" style="width: 100%;">
								</div>
								<hr>
								<div class="slidecontainer jeju">
									<div class="plat jeju text-white" style="text-align: center;">엔터테인먼트</div>
									<input type="range" min="-2" max="2" value="-2"
										onchange="slider_change()" class="slider" id="myRange4"
										name="myRange4" style="width: 100%;">
								</div>
								<hr>
								<div class="slidecontainer jeju">
									<div class="plat jeju text-white" style="text-align: center;">스포츠</div>
									<input type="range" min="-2" max="2" value="-2"
										onchange="slider_change()" class="slider" id="myRange5"
										name="myRange5" style="width: 100%;">
								</div>
								<hr>
								<div class="slidecontainer jeju">
									<div class="plat jeju text-white" style="text-align: center;">연령대</div>
									<input type="range" min="0" max="5" value="0"
										onchange="slider_change()" class="slider" id="myRange6"
										name="myRange6" style="width: 100%;">
								</div>
								<hr>

							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-8 col-md-12">
				<div class="card ">
					<div class="card-header ">
						<i class="tim-icons icon-zoom-split text-success"
							style="float: left;"></i>
						<p class="jeju text-success" style="float: left;">&nbsp;실시간
							급상승 검색어</p>
						<p class="card-category d-inline jeju" style="float: right;">검색어
							설정 참고</p>
					</div>
					<div class="card-body ">
						<div class="table-full-width"
							style="overflow: auto; height: 464px;">
							<table class="table">
								<tbody>
									<%
										for (int i = 1; i <= 20; i++) {
									%>
									<tr>
										<td>
											<p class="title">
											<div id="rank_list<%=i%>" style="float: left;" class="jeju"></div>
											<div id="keyword_list<%=i%>"
												style="float: left; font-size: 15pt;" class="jeju"></div> <br>
											<br>
											<div id="syn_start" style="float: left;"
												class="jeju text-primary">동의 검색어 :&nbsp;</div>
											<div id="keyword_synonyms_list<%=i%>"
												style="width: 91%; float: right;" class="jeju"></div> <br>
											<p class="text-muted">
											<div id="rel_start" style="float: left;"
												class="jeju text-primary">연관 검색어 :&nbsp;</div>
											<div id="rel_list<%=i%>" style="width: 91%; float: right;"
												class="jeju"></div>
										</td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card card-chart">
					<div class="card-header ">
						<div class="row">
							<div class="col-sm-6 text-left">
								<h5 class="card-category jeju">워드클라우드</h5>
								<i class="tim-icons icon-paper text-primary"
									style="float: left;"></i>
								<h4 class="card-title jeju" style="float: left;">&nbsp;뉴스
									본문</h4>
							</div>

						</div>
					</div>
					<div class="card-body" style="height: 430px;">
						<div class="chart-area" style="width: 75%; margin: 0 auto;">
							<div id="time_id"
								style="text-align: center; color: white; font-size: 160%;"></div>
							<div class="jeju " id="rel_char"
								style="height: 360px; text-align: center; color: white; font-size: 170%;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-4">
				<div class="card card-chart">
					<div class="card-header">
						<h5 class="card-category jeju">오피니언 마이닝</h5>
						<h4 class="card-title jeju">
							<i class="tim-icons icon-chat-33 text-success "></i>&nbsp;뉴스댓글
						</h4>
					</div>
					<div class="card-body" style="height: 600px;">
						<div class="chart-area">
							<div class="jeju"
								style="text-align: center; color: white; font-size: 160%;">신뢰도
								95%</div>
							<div class="jeju" id="part"
								style="text-align: center; color: white; font-size: 160%;"></div>
							<div class="jeju text-success" id="stat"
								style="text-align: center; font-size: 300%;"></div>
							<br>
							<div class="jeju" id="opin_char"
								style="height: 300px; text-align: center; color: white;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card card-chart">
					<div class="card-header">
						<h5 class="card-category jeju">구글 트렌드</h5>
						<h4 class="card-title jeju">
							<i class="tim-icons icon-time-alarm text-success "></i>&nbsp;시간별
							검색 현황
						</h4>
					</div>
					<div class="card-body">

						<div id="sampDiv_time"
							style="width: 90%; height: 100%; margin: 0px auto;"></div>

					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card card-chart">
					<div class="card-header">
						<h5 class="card-category jeju">구글 트렌드</h5>
						<h4 class="card-title jeju">
							<i class="tim-icons icon-map-big text-success "></i>&nbsp;지역별 검색
							현황
						</h4>
					</div>
					<div class="card-body">
						<!-- <div class="chart-area">
							<canvas id="chartLineGreen">
								
								</canvas> -->

						<!-- </div> -->
						<div id="sampDiv_map"
							style="width: 90%; height: 100%; margin: 0px auto;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--   Core JS Files   -->
	<script>
		function news(elem, num) {
			$('#search_modal').modal('show')
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
							var time_id = "";
							var rel_char = "";
							var com_opin = "";
							var opin_char = "";
							var stat = "";
							var part = "";
							if (json[0].real_time[0] == "뉴스 시간 : 최근에 등록된 뉴스가 없습니다.") {
								time_id = "최근에 등록된 뉴스가 없습니다.";
								$("#time_id").html(time_id);
								rel_char = "분석가능한 뉴스 본문이 없습니다.";
								$("#rel_char").html(rel_char);
								com_opin = "분석가능한 뉴스 댓글이 없습니다.";
								$("#com_opin").html(com_opin);
							} else {
								$("#rel_char").html('');
								$("#stat").html('');
								$("#part").html('');
								$("#time_id").html('');
								$("#com_opin").html('');
								$("#opin_char").html('');
								$("#sampDiv_time").html('');
								$("#sampDiv_map").html('');
								stat += json[0].stat;
								$("#stat").html(stat);
								part += json[0].part;
								$("#part").html(part);
								time_id += json[0].real_time[0];
								time_id += " ~ ";
								time_id += json[0].real_time[1];
								$("#time_id").html(time_id);
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
											series.colors = new am4core.ColorSet();
											series.colors.passOptions = {}; // makes it loop

										}); // end am4core.ready()

								am4core
										.ready(function() {

											// Themes begin
											am4core.useTheme(am4themes_dark);
											am4core
													.useTheme(am4themes_animated);
											// Themes end

											// Create chart instance
											var chart = am4core.create(
													"opin_char",
													am4charts.PieChart);

											// Add data
											chart.data = [
													{
														"specimen_count" : "긍정",
														"emotion_analysis" : json[0].posCnt
													},
													{
														"specimen_count" : "부정",
														"emotion_analysis" : json[0].negCnt
													} ];

											// Add and configure Series
											var pieSeries = chart.series
													.push(new am4charts.PieSeries());
											pieSeries.dataFields.value = "emotion_analysis";
											pieSeries.dataFields.category = "specimen_count";
											pieSeries.slices.template.stroke = am4core
													.color("#fff");
											pieSeries.slices.template.strokeWidth = 2;
											pieSeries.slices.template.strokeOpacity = 1;

											// This creates initial animation
											pieSeries.hiddenState.properties.opacity = 1;
											pieSeries.hiddenState.properties.endAngle = -90;
											pieSeries.hiddenState.properties.startAngle = -90;

										}); // end am4core.ready()

								var divElem_time = document
										.getElementById("sampDiv_time");
								trends.embed
										.renderExploreWidgetTo(
												divElem_time,
												"TIMESERIES",
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

								var divElem_map = document
										.getElementById("sampDiv_map");
								trends.embed
										.renderExploreWidgetTo(
												divElem_map,
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

							$('#search_modal').modal('hide')
						}
					});

		}
	</script>
	<!-- Black Dashboard DEMO methods, don't include it in your project! -->
</body>
</html>