<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.5.0.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/wordCloud.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script type="text/javascript">
	$(window).on("load", function() {
		getRank();
	});

	function getRank() {
		$.ajax({
			url : "/rtest.do",
			type : "post",
			dataType : "JSON",
			success : function(json) {
				am4core.ready(function() {
					   // Themes begin
					   am4core.useTheme(am4themes_animated);
					   // Themes end
					   var chart = am4core.create("chartdiv", am4plugins_wordCloud.WordCloud);
					   var series = chart.series.push(new am4plugins_wordCloud.WordCloudSeries());
					   series.randomness = 0.1;
					   series.labels.template.tooltipText = "{word}: {cnt}";
					   series.fontFamily = "Courier New";
					   series.data = json;
					   series.dataFields.word = "word";
					   series.dataFields.value = "cnt";

					}); // end am4core.ready()
			}
		})
	}
</script>
</head>
<body>
	<div id="chartdiv"></div>
</body>
</html>