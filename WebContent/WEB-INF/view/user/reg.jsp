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
						<h5 class="card-category jeju">Sign up</h5>
						<h4 class="card-title jeju">It's u, Issue!</h4>
					</div>
					<div class="card-body">
						<form id="reg_form" name="f" class="user" method="post">

							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									id="user_reg_id" name="user_id" oninput="checkId()"
									placeholder="ID" required="required">
								<div id="wrongId"
									style="display: none; color: red; font-size: 12px;">5~16자의
									영문 소문자,숫자만 사용 가능합니다.</div>
								<div id="failId"
									style="display: none; color: red; font-size: 12px;">사용하실
									수 없는 아이디입니다.</div>
								<div id="successId"
									style="display: none; color: dodgerblue; font-size: 12px;">사용하실
									수 있는 아이디입니다.</div>
							</div>
							<div class="form-group">
								<input type="text" class="form-control form-control-user"
									id="user_reg_name" name="user_name" placeholder="이름"
									required="required">
							</div>
							<div class="form-group">
								<input type="password" class="form-control form-control-user"
									id="user_reg_password" name="password" maxlength="16"
									oninput="checkPw()" placeholder="비밀번호"
									style="ime-mode: disabled;" required="required">
							</div>
							<div class="form-group">
								<input type="password" class="form-control form-control-user"
									name="RepeatPassword" oninput="checkPw2()"
									placeholder="비밀번호 재입력" style="ime-mode: disabled;"
									required="required">
							</div>

							<div id="wrongPw"
								style="display: none; color: red; font-size: 12px; margin-left: 20px;">6~16자의
								비밀번호를 사용해주세요.</div>
							<div id="wrongPw2"
								style="display: none; color: red; font-size: 12px; margin-left: 20px;">비밀번호가
								일치하지 않습니다.</div>

							<div class="form-group">
								<input type="email" class="form-control form-control-user"
									id="user_reg_mail" name="user_mail" oninput="checkMail()"
									placeholder="Email" required="required">
								<div id="wrongMail"
									style="display: none; color: red; font-size: 12px;">잘못된
									이메일 형식입니다.</div>
								<div id="successMail"
									style="display: none; color: dodgerblue; font-size: 12px;">사용
									가능한 Email입니다.</div>
								<div id="failMail"
									style="display: none; color: red; font-size: 12px;">이미
									등록된 Email입니다.</div>
							</div>
							<button id="submitbtn" type="button" onclick="userReg()"
								class="btn btn-primary btn-user btn-block">회원 가입</button>

						</form>
						<div class="text-center">
							<a class="small" href="/main_login.do">로그인</a>
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
		var idCheck = 0;
		var pwCheck = 0;
		var emailCheck = 0;
		function reset_reg_form() {
			$("#reg_form")[0].reset();
			$('#wrongId').hide();
			$('#failId').hide();
			$('#successId').hide();
			$('#wrongPw').hide();
			$('#wrongPw2').hide();
			$('#successMail').hide();
			$('#failMail').hide();
			$('#wrongMail').hide();

		}
		function checkId() {
			var inputed = f.user_id.value;
			var CheckForm = /^[a-z0-9]{5,16}$/;
			if (!CheckForm.test(inputed)) {
				$('#wrongId').show();
				$('#failId').hide();
				$('#successId').hide();
				idCheck = 0;
			} else {
				$.ajax({
					data : {
						user_id : inputed
					},
					url : "checkId.do",
					success : function(data) {
						if (inputed == "" && data == '0') {
							$('#wrongId').hide();
							$('#failId').show();
							$('#successId').hide();
							idCheck = 0;
						} else if (data == '0') {
							$('#wrongId').hide();
							$('#failId').hide();
							$('#successId').show();
							idCheck = 1;
						} else if (data == '1') {
							$('#wrongId').hide();
							$('#failId').show();
							$('#successId').hide();
							idCheck = 0;
						}
					}
				})
			}
		}
		function checkPw() {
			var inputed = f.password.value;
			if (inputed.length < 6) {
				$('#wrongPw').show();
				$('#wrongPw2').hide();
			} else {
				$('#wrongPw').hide();
				$('#wrongPw2').hide();
			}
		}
		function checkPw2() {
			var inputed = f.password.value;
			var inputed2 = f.RepeatPassword.value;
			if (inputed != inputed2) {
				$('#wrongPw2').show();
			} else {
				$('#wrongPw2').hide();
			}
		}
		function checkMail() {
			var inputed = f.user_mail.value;
			var CheckForm = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if (!CheckForm.test(inputed)) {
				$('#successMail').hide();
				$('#failMail').hide();
				$('#wrongMail').show();
				emailCheck = 0;
			} else {
				$.ajax({
					data : {
						user_mail : inputed
					},
					url : "checkMail.do",
					success : function(data) {
						if (inputed == "" && data == '0') {
							$('#successMail').hide();
							$('#failMail').show();
							$('#wrongMail').hide();
							emailCheck = 0;
						} else if (data == '0') {
							$('#successMail').show();
							$('#failMail').hide();
							$('#wrongMail').hide();
							emailCheck = 1;
						} else if (data == '1') {
							$('#successMail').hide();
							$('#failMail').show();
							$('#wrongMail').hide();
							emailCheck = 0;
						}
					}
				})
			}
		}
		function userReg() {
			if (doRegUserCkeck(document.getElementById('reg_form'))) {
				$.ajax({
					url : "/insertUserInfo.do",
					type : "post",
					data : {
						'user_id' : $('#user_reg_id').val(),
						'user_name' : $('#user_reg_name').val(),
						'password' : $('#user_reg_password').val(),
						'user_mail' : $('#user_reg_mail').val()
					},
					success : function(a) {
						console.log(a);
						reset_reg_form();
						if (a == 0) {
							$('#alert_modal_body').html('회원가입되었습니다.');
							$('#alert_modal').modal('show')
							$('#alert_modal').on('hide.bs.modal', function(e) {
								location.href = "/main_login.do";
							});
						} else if (a == 1) {
							$('#alert_modal_body').html('이미 가입된 회원입니다.');
							$('#alert_modal').modal('show');
							reset_reg_form();
						} else if (a == 2) {
							$('#alert_modal_body').html(
									'일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');
							$('#alert_modal').modal('show');
							reset_reg_form();
						}
					}
				})
			}
		}

		function doRegUserCkeck(f) {
			if (idCheck == 0) {
				$('#alert_modal_body').html('사용하실수 없는 아이디 입니다.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (emailCheck == 0) {
				$('#alert_modal_body').html('사용하실수 없는 이메일 입니다.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.password.value.length < 6) {
				$('#alert_modal_body').html('6~16자의 비밀번호를 사용해주세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.password.value.length > 16) {
				$('#alert_modal_body').html('6~16자의 비밀번호를 사용해주세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.user_id.value == "") {
				$('#alert_modal_body').html('아이디를 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.user_name.value == "") {
				$('#alert_modal_body').html('이름을 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.password.value == "") {
				$('#alert_modal_body').html('비밀번호를 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.RepeatPassword.value == "") {
				$('#alert_modal_body').html('비밀번호 재입력을 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.user_mail.value == "") {
				$('#alert_modal_body').html('Email을 입력하세요.');
				$('#alert_modal').modal('show')
				return false;
			}
			if (f.password.value != f.RepeatPassword.value) {
				$('#alert_modal_body').html('비밀번호가 같지 않습니다.');
				$('#alert_modal').modal('show')
				return false;
			}
			return true;
		}
	</script>

	<!--   Core JS Files   -->
	<!-- Black Dashboard DEMO methods, don't include it in your project! -->
</body>
</html>