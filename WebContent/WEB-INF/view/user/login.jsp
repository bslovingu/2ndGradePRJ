<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
</script>
</head>

<body class="">
	<div class="modal fade" id="alert_modal" tabindex="-1" role="dialog"
		aria-labelledby="alertLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="alertLabel">It's u, Issue!</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div id="alert_modal_body" class="modal-body"></div>
			</div>
		</div>
	</div>
	<!-- End Navbar -->
	<div class="content">
		<div class="row">
			<div class="col-lg-4" style="margin: auto; margin-top: 200px;">
				<div class="card card-chart">
					<div class="card-header">
						<h5 class="card-category jeju">Login</h5>
						<h4 class="card-title jeju">It's u, Issue!</h4>
					</div>
					<div class="card-body">
						<form class="user" id="login_form">
							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									id="user_login_id" name="user_id" placeholder="ID"
									required="required">
							</div>
							<div class="form-group">
								<input type="password" class="form-control form-control-user"
									id="user_login_password" name="password" placeholder="Password"
									style="ime-mode: disabled;" required="required">
							</div>
							<div class="form-group">
								<div class="custom-control custom-checkbox small">
									<input type="checkbox" class="custom-control-input"
										id="customCheck" name="userCheck"> <label
										class="custom-control-label" for="customCheck">ID 기억하기</label>
								</div>
							</div>
							<button type="button" onclick="loginUser()"
								class="btn btn-primary btn-user btn-block">Login</button>
						</form>

						<div class="text-center">
							<a class="small" href="/main_reg.do">회원가입</a>
						</div>
						<div class="text-center">
							<a class="small" href="/main_find.do">아이디/비밀번호 찾기</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		function loginUser() {
			if (doModifyUserCheck(document.getElementById('login_form'))) {
				$.ajax({
					url : "/Loginbtn.do",
					type : "post",
					data : {
						'user_id' : $('#user_login_id').val(),
						'password' : $('#user_login_password').val()
					},
					success : function(a) {
						console.log(a);
						if (a == 1) {
							$('#alert_modal_body').html('관리자 로그인에 성공하였습니다.');
							$('#alert_modal').modal('show')
							$('#alert_modal').on('hide.bs.modal', function(e) {
								location.href = "/test/finalPage.do";
							});
						} else if (a == 0) {
							$('#alert_modal_body').html(
									'없는 아이디 또는 잘못된 비밀번호입니다.');
							$('#alert_modal').modal('show')
						} else if (a == 2) {
							$('#alert_modal_body').html('로그인되었습니다.');
							$('#alert_modal').modal('show')
							$('#alert_modal').on('hide.bs.modal', function(e) {
								location.href = "/test/finalPage.do";
							});
						}

					}
				})
			}
		}
		function doModifyUserCheck(f) {
			if (f.user_id.value == "") {
				$('#alert_modal_body').html('아이디를 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.password.value == "") {
				$('#alert_modal_body').html('비밀번호를 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			return true;
		}
	</script>
	<!-- 쿠키 저장 및 로드 -->
	<script>
		window.onload = function() {
			var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
			$('input[name=user_id]').val(userInputId);

			if ($('input[name=user_id]').val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩
				// 아이디 저장하기 체크되어있을 시,
				$('input[name=userCheck]').attr("checked", true); // ID 저장하기를 체크 상태로 두기.
			}

			$('input[name=userCheck]').change(function() { // 체크박스에 변화가 발생시
				if ($('input[name=userCheck]').is(":checked")) { // ID 저장하기 체크했을 때,
					var userInputId = $('input[name=user_id]').val();
					setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
				} else { // ID 저장하기 체크 해제 시,
					deleteCookie("userInputId");
				}
			});

			// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
			$('input[name=user_id]').keyup(function() { // ID 입력 칸에 ID를 입력할 때,
				if ($('input[name=userCheck]').is(":checked")) { // ID 저장하기를 체크한 상태라면,
					var userInputId = $('input[name=user_id]').val();
					setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
				}
			});
		};

		function setCookie(cookieName, value, exdays) {
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var cookieValue = escape(value)
					+ ((exdays == null) ? "" : "; expires="
							+ exdate.toGMTString());
			document.cookie = cookieName + "=" + cookieValue;
		}

		function deleteCookie(cookieName) {
			var expireDate = new Date();
			expireDate.setDate(expireDate.getDate() - 1);
			document.cookie = cookieName + "= " + "; expires="
					+ expireDate.toGMTString();
		}

		function getCookie(cookieName) {
			cookieName = cookieName + '=';
			var cookieData = document.cookie;
			var start = cookieData.indexOf(cookieName);
			var cookieValue = '';
			if (start != -1) {
				start += cookieName.length;
				var end = cookieData.indexOf(';', start);
				if (end == -1)
					end = cookieData.length;
				cookieValue = cookieData.substring(start, end);
			}
			return unescape(cookieValue);
		}
	</script>

	<!--   Core JS Files   -->
	<!-- Black Dashboard DEMO methods, don't include it in your project! -->
</body>
</html>