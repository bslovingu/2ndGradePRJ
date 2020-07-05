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
			<div class="col-lg-4" style="margin: auto; margin-top: 50px;">
				<div class="card card-chart">
					<div class="card-header">
						<h5 class="card-category jeju">find</h5>
						<h4 class="card-title jeju">It's u, Issue!</h4>
					</div>
					<div class="card-body">
						<div class="col-lg-12">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-2">아이디/비밀번호 찾기</h1>
							</div>
							<form name="findID" method="post" class="user">
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="find_id_name" name="user_name" placeholder="이름"
										required="required">
								</div>
								<div class="form-group">
									<input type="email" class="form-control form-control-user"
										id="find_id_mail" name="user_mail" placeholder="Email"
										required="required">
								</div>
								<button type="button" onclick="IDFind()"
									class="btn btn-primary btn-user btn-block">아이디 찾기</button>
							</form>
							<hr>
							<form name="findPW" method="post" class="user">
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="find_pw_name" name="user_name" placeholder="이름"
										required="required">
								</div>
								<div class="form-group">
									<input type="text" class="form-control form-control-user"
										id="find_pw_id" name="user_id" placeholder="아이디"
										required="required">
								</div>
								<div class="form-group">
									<input type="email" class="form-control form-control-user"
										id="find_pw_mail" name="user_mail" placeholder="Email"
										required="required">
								</div>
								<button id="PwFindBtn" type="button" onclick="PwFind()"
									class="btn btn-primary btn-user btn-block">비밀번호 찾기</button>
							</form>
						</div>

						<div class="text-center">
							<a class="small" href="/main_login.do">로그인</a>
						</div>
						<div class="text-center">
							<a class="small" href="/main_reg.do">회원가입</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		function IDFind() {
			if ($('#find_id_name').val() == '') {
				$('#alert_modal_body').html('이름을 입력해주세요.');
				$('#alert_modal').modal('show')
			} else if ($('#find_id_mail').val() == '') {
				$('#alert_modal_body').html('이메일을 입력해주세요.');
				$('#alert_modal').modal('show')
			} else {
				$.ajax({
					url : "/findID.do",
					type : "post",
					data : {
						'user_name' : $('#find_id_name').val(),
						'user_mail' : $('#find_id_mail').val()
					},
					success : function(a) {
						if (a.user_id == null) {
							$('#alert_modal_body').html('가입된 아이디가 없습니다.');
							$('#alert_modal').modal('show');
							$('#find_id_name').val('');
							$('#find_id_mail').val('');
						} else {
							$('#alert_modal_body').html(
									'가입된 아이디는 ' + a.user_id + ' 입니다.');
							$('#alert_modal').modal('show');
							$('#find_id_name').val('');
							$('#find_id_mail').val('');
						}
					}
				})
			}
		}
		function PwFind() {
			if ($('#find_pw_name').val() == '') {
				$('#alert_modal_body').html('이름을 입력해주세요.');
				$('#alert_modal').modal('show')
			} else if ($('#find_pw_id').val() == '') {
				$('#alert_modal_body').html('아이디를 입력해주세요.');
				$('#alert_modal').modal('show')
			} else if ($('#find_pw_mail').val() == '') {
				$('#alert_modal_body').html('이메일을 입력해주세요.');
				$('#alert_modal').modal('show')
			} else {
				$('#PwFindBtn').attr('disabled', true);
				$.ajax({
					url : "/findPW.do",
					type : "post",
					data : {
						'user_name' : $('#find_pw_name').val(),
						'user_id' : $('#find_pw_id').val(),
						'user_mail' : $('#find_pw_mail').val()
					},
					success : function(a) {
						$('#PwFindBtn').attr('disabled', false);
						if (a == "0") {
							$('#alert_modal_body').html('가입된 아이디가 없습니다.');
							$('#alert_modal').modal('show');
							$('#find_pw_name').val('');
							$('#find_pw_id').val('');
							$('#find_pw_mail').val('');
						} else if (a == "1") {
							$('#alert_modal_body').html(
									'일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');
							$('#alert_modal').modal('show');
							$('#find_pw_name').val('');
							$('#find_pw_id').val('');
							$('#find_pw_mail').val('');
						} else if (a == "2") {
							$('#alert_modal_body').html(
									'새로운 비밀번호가 이메일로 발송되었습니다.');
							$('#alert_modal').modal('show');
							$('#find_pw_name').val('');
							$('#find_pw_id').val('');
							$('#find_pw_mail').val('');
						}
					}
				})
			}
		}
	</script>


	<!--   Core JS Files   -->
	<!-- Black Dashboard DEMO methods, don't include it in your project! -->
</body>
</html>