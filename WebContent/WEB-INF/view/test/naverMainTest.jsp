<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<style>
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

</head>
<body>
	<form id="testForm">
		<div class="slidecontainer">
			<div class="plat">이슈별 묶어보기</div>
			<input type="range" min="0" max="4" value="0"
				onchange="slider_change()" class="slider" id="myRange1"
				name="myRange1">
		</div>
		<hr>
		<div class="slidecontainer">
			<div class="plat">이벤트/할인</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange2"
				name="myRange2">
		</div>
		<hr>
		<div class="slidecontainer">
			<div class="plat">시사</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange3"
				name="myRange3">
		</div>
		<hr>
		<div class="slidecontainer">
			<div class="plat">엔터테인먼트</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange4"
				name="myRange4">
		</div>
		<hr>
		<div class="slidecontainer">
			<div class="plat">스포츠</div>
			<input type="range" min="-2" max="2" value="-2"
				onchange="slider_change()" class="slider" id="myRange5"
				name="myRange5">
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
					result += ("---> ") + json;
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
			/* myRange6 : $('#myRange6').val() */
			};
			$
					.ajax({
						dataType : 'json',
						contentType : 'application/json; charset=utf-8',
						type : 'post',
						url : '/cssTest.do', // <<-- 처리 요청 URL
						data : JSON.stringify(data),
						success : function(json) {
							for (var i = 0; i < json.length; i++) {
								var result = "";
								var div_id = "#result_list" + (i + 1);
								var parm = {
									"keyword" : json[i].keyword
								};
								rel_func(parm, i);
								result += (json[i].rank + ". ");
								result += (json[i].keyword);
								for (var j = 0; j < json[i].keyword_synonyms.length; j++) {
									if (j == 0) {
										result += (" : ");
									}
									if (j != 0) {
										result += (", ");
									}
									result += (json[i].keyword_synonyms[j]);
								}
								$(div_id).html(result);
							}
						}
					});
		}
	</script>
	<section class="content">
		<ul class="list">
			<li class="list__item"><label class="label--radio"> <input
					type="radio" class="radio" checked name="foo"> Item 1
			</label></li>
			<li class="list__item"><label class="label--radio"> <input
					type="radio" class="radio" name="foo"> Item 2
			</label></li>
			<li class="list__item"><label class="label--radio"> <input
					type="radio" class="radio" name="foo"> Item 3
			</label></li>
			<li class="list__item"><label class="label--radio"> <input
					type="radio" class="radio" name="foo"> Item 4
			</label></li>
		</ul>
	</section>

	<div id=result_list1></div>
	<div id=rel_list1></div>
	<br>

	<div id=result_list2></div>
	<div id=rel_list2></div>
	<br>

	<div id=result_list3></div>
	<div id=rel_list3></div>
	<br>

	<div id=result_list4></div>
	<div id=rel_list4></div>
	<br>

	<div id=result_list5></div>
	<div id=rel_list5></div>
	<br>

	<div id=result_list6></div>
	<div id=rel_list6></div>
	<br>

	<div id=result_list7></div>
	<div id=rel_list7></div>
	<br>

	<div id=result_list8></div>
	<div id=rel_list8></div>
	<br>

	<div id=result_list9></div>
	<div id=rel_list9></div>
	<br>

	<div id=result_list10></div>
	<div id=rel_list10></div>
	<br>

	<div id=result_list11></div>
	<div id=rel_list11></div>
	<br>

	<div id=result_list12></div>
	<div id=rel_list12></div>
	<br>

	<div id=result_list13></div>
	<div id=rel_list13></div>
	<br>

	<div id=result_list14></div>
	<div id=rel_list14></div>
	<br>

	<div id=result_list15></div>
	<div id=rel_list15></div>
	<br>

	<div id=result_list16></div>
	<div id=rel_list16></div>
	<br>

	<div id=result_list17></div>
	<div id=rel_list17></div>
	<br>

	<div id=result_list18></div>
	<div id=rel_list18></div>
	<br>

	<div id=result_list19></div>
	<div id=rel_list19></div>
	<br>
	<div id=result_list20></div>
	<div id=rel_list20></div>


</body>
</html>