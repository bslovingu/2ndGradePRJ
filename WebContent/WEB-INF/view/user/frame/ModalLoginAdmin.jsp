<%@page import="poly.util.EncryptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- crm -->
<div class="modal fade" id="crm_modal" tabindex="-1" role="dialog"
	aria-labelledby="crmLabel" aria-hidden="true" style="top:-100px;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="background-color: #1e1e2f;">
			<div class="modal-header">
				<h4 class="card-title" id="crmLabel">crm</h4>
				<button type="button" class="close" data-dismiss="modal" onclick="crm_reset()"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<div class="modal-body">
				<input id="pgNumValue" type="hidden" value=""> <input
					id="pgSearchValue" type="hidden" value="">
				<div class="row" style="margin: 0; margin-bottom: 1em;">
					<div class="select_box search_box">
						<select name="searchSelect"
							class="custom-select form-control search_form">
							<option value="userId">회원ID</option>
							<option value="userName">이름</option>
						</select>
					</div>
					<div class="search_box">
						<input id="searchCont" name="searchCont" type="search"
							class="form-control search_input" placeholder=""
							aria-controls="dataTable" style="width: 175px">

					</div>
					<div class="search_box">
						<button type="button" class="form-control btn btn-default" style="margin: 0;"
							onclick="searchUserList()">검색</button>
					</div>
				</div>
				<div id="user_list_table" style="border-collapse: collapse;">

				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="crm_reset()">Close</button>
				<button type="button" class="btn btn-default"
					 onclick="getUser()">정보 수정</button>
				<button type="button" class="btn btn-default"
					 onclick="modifyAuthor()">권한 변경</button>
				<button type="button" class="btn btn-default"
					 onclick="setDeleteConfirm()">회원
					탈퇴</button>
			</div>
		</div>
	</div>
</div>
<script>
	function crm_reset(){
		$('#searchCont').val('');
	}
	function getUser() {
		if (!$('input:radio[name=check_user]').is(':checked')) {
			$('#alert_modal_body').html('사용자를 체크해주세요.');
			$('#alert_modal').modal('show')
		}else if($('input:radio[name=check_user]:checked').val()=='<%=userId%>'){
			$('#alert_modal_body').html('mypage를 이용해주세요.');
			$('#alert_modal').modal('show')
		}else {
			$.ajax({
				url : "/getUserInfo.do",
				type : "post",
				dataType : "JSON",
				data : {
					'user_id' : $('input:radio[name=check_user]:checked').val()
				},
				success : function(json) {
					if (json.user_id == '로그인오류') {

					} else {
						$('#mypage_modal').modal('show')
						$('#user_mod_id').val(json.user_id);
						$('#user_mod_name').val(json.user_name);
						$('#user_mod_mail').val(json.user_mail);
					}
				}
			})
		}
	}
	function modifyAuthor() {
		if (!$('input:radio[name=check_user]').is(':checked')) {
			$('#alert_modal_body').html('사용자를 체크해주세요.');
			$('#alert_modal').modal('show')
		}else if($('input:radio[name=check_user]:checked').val()=='<%=userId%>'){
			$('#alert_modal_body').html('본인의 권한은 변경하실 수 없습니다.');
			$('#alert_modal').modal('show')
		}else {
			$.ajax({
				url : "/modifyAuthor.do",
				type : "post",
				data : {
					'user_id' : $('input:radio[name=check_user]:checked').val()
				},
				success : function(a) {
					if(a == '0'){
						$('#alert_modal_body').html('일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');	
					}else if(a=='1'){
						$('#alert_modal_body').html('관리자로 변경되었습니다.');
					}else if(a=='2'){
						$('#alert_modal_body').html('사용자로 변경되었습니다.');
					}
					
					$('#alert_modal').modal('show')
					getUserList(1, $('#searchCont').val());
					
				}
			})
		}
	}
	function setDeleteConfirm(){
		if (!$('input:radio[name=check_user]').is(':checked')) {
			$('#alert_modal_body').html('사용자를 체크해주세요.');
			$('#alert_modal').modal('show')
		}else if($('input:radio[name=check_user]:checked').val()=='<%=userId%>') {
			$('#alert_modal_body').html('본인은 탈퇴시킬 수 없습니다.');
			$('#alert_modal').modal('show')
		} else {
			$('#confirm_modal_body').html('회원을 탈퇴 시키시겠습니까?.');
			$('#confirm_btn').attr('onclick', 'deleteUser();');
			$('#confirm_modal').modal('show')
		}
	}
	function deleteUser() {
		$.ajax({
			url : "/deleteUserInfo.do",
			type : "post",
			data : {
				'user_id' : $('input:radio[name=check_user]:checked').val()
			},
			success : function(a) {
				if (a == '0') {
					$('#alert_modal_body').html(
							'일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');
				} else if (a == '1') {
					$('#alert_modal_body').html('회원이 삭제되었습니다.');
				}

				$('#alert_modal').modal('show')
				getUserList(1, $('#searchCont').val());

			}
		})
	}
	function searchUserList() {
		if ($('#searchCont').val() == '') {
			$('#alert_modal_body').html('검색어를 입력해 주세요.');
			$('#alert_modal').modal('show')
		} else {
			getUserList(1, $('#searchCont').val());
		}
	}
</script>


<!-- mypage -->
<div class="modal fade" id="mypage_modal" tabindex="-1" role="dialog"
	data-backdrop="static" aria-labelledby="mypageLabel" aria-hidden="true">
	<div class="modal-dialog ">
		<div class="modal-content" style="background-color: #1e1e2f;">
			<div class="modal-header">
				<h4 class="card-title" id="mypageLabel">Mypage</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close" onclick="reset_form()">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="modify_form" name="f" method="post">
				<div class="modal-body">
					<div class="form-group">
						<input type="text" class="form-control form-control-user"
							id="user_mod_id" name="user_id" placeholder="ID" value=""
							readonly required="required">
					</div>
					<div class="form-group">
						<input type="text" class="form-control form-control-user"
							id="user_mod_name" name="user_name" placeholder="이름" value=""
							required="required">
					</div>
					<div class="form-group">
						<input type="password" class="form-control form-control-user"
								id="user_mod_password" name="password" maxlength="16"
								oninput="checkPw()" placeholder="비밀번호"
								style="ime-mode: disabled;" required="required">
					</div>
					<div class="form-group">
						<input type="password" class="form-control form-control-user"
								id="RepeatPassword" name="RepeatPassword" oninput="checkPw2()"
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
							id="user_mod_mail" name="user_mail" placeholder="Email" value=""
							readonly required="required">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="reset_form()">Close</button>
					<button type="button" onclick="setDeleteInfoConfirm()"
						class="btn btn_alert" style="color: #fff;">회원 탈퇴</button>
					<button type="button" onclick="UserModify()"
						class="btn btn-default">회원정보
						수정</button>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	var pwCheck1 = 0;
	var pwCheck2 = 0;
	function reset_form() {
		$('#wrongPw').hide();
		$('#wrongPw2').hide();
		$('#user_mod_id').val('');
		$('#user_mod_name').val('');
		$('#user_mod_password').val('');
		$('#RepeatPassword').val('');
		$('#user_mod_mail').val('');
	}
	function checkPw() {
		var inputed = f.password.value;
		if (inputed.length < 6) {
			$('#wrongPw').show();
			$('#wrongPw2').hide();
		} else {
			pwCheck1 = 1;
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
			pwCheck2 = 1;
			$('#wrongPw2').hide();
		}
	}
	function UserModify() {
		if (doModifyUserCheck(document.getElementById('modify_form'))) {
			$.ajax({
				url : "/updateUserInfo.do",
				type : "post",
				data : {
					'user_id' : $('#user_mod_id').val(),
					'user_name' : $('#user_mod_name').val(),
					'password' : $('#user_mod_password').val()
				},
				success : function(a) {
					console.log(a);
					if (a == 1) {
						$('#alert_modal_body').html('회원정보 수정에 성공하였습니다.');
					} else if (a == 0) {
						$('#alert_modal_body').html('회원정보 수정에 실패하였습니다.');
					}
					reset_form();
					$('#alert_modal').modal('show')
					$('#mypage_modal').modal('hide');
					getUserList(1, $('#searchCont').val());
				}
			})
		}
	}
	function doModifyUserCheck(f) {
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
	function setDeleteInfoConfirm(){
		$('#confirm_modal_body').html('탈퇴하시겠습니까?');
		$('#confirm_btn').attr('onclick', 'deleteUserInfo();');
		$('#confirm_modal').modal('show')
	}
	function deleteUserInfo() {
		$.ajax({
			url : "/deleteUserInfo.do",
			type : "post",
			data : {
				'user_id' : $('#user_mod_id').val()
			},
			success : function(a) {
				if (a == '0') {
					$('#alert_modal_body').html(
							'일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');
				} else if (a == '1') {
					$('#alert_modal_body').html('회원이 삭제되었습니다.');
				}
				$('#mypage_modal').modal('hide');
				$('#alert_modal').modal('show');
				$('#alert_modal').on('hide.bs.modal', function (e) {
					location.href="/Logoutbtn.do";
				});
				
			}
		})
	}
</script>
<div class="modal fade" id="confirm_modal" tabindex="-1" role="dialog"
	data-backdrop="static" aria-labelledby="confirmLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="confirmLabel">CA.</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close" onclick="reset_confirm_modal()">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<div id="confirm_modal_body" class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"
					onclick="reset_confirm_modal()">취소</button>

				<button type="button" id="confirm_btn" class="btn btn-primary"
					 data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<script>
	function reset_confirm_modal() {
		$('#confirm_modal_body').html('');
		$('#confirm_btn').removeAttr('onclick');
	}
</script>
<div class="modal fade" id="contact_modal" tabindex="-1" role="dialog"
	aria-labelledby="contactLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="background-color: #1e1e2f;">
			<div class="modal-header">
				<h4 class="modal-title" id="contactLabel">Contact</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>

			</div>
			<form class="" method="post">
				<div class="modal-body">
					<div class="col-md-12" style="margin: auto;">
						<div class="control-group form-group">
							<div class="controls">
								<label>Full Name:</label> <input class="form-control"
									id="contactName" name="contactName" required type="text">
								<p class="help-block"></p>
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Phone Number:</label> <input class="form-control"
									id="contactTel" name="contactTel" required type="tel" onkeyup="phoneNumberFormat(this)">
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Email Address:</label> <input class="form-control"
									id="contactEmail" name="contactEmail" required type="email">
							</div>
						</div>
						<div class="control-group form-group">
							<div class="controls">
								<label>Message:</label>
								<textarea class="form-control" cols="100" name="contactMessage"
									id="contactMessage" maxlength="999" required rows="10"
									style="resize: none"></textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="contact_btn" onclick="sendContact()"
						class="btn btn-default">Send
						Message</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	function phoneNumberFormat(obj) {
		obj.value = obj.value.replace(/[^0-9\-]/g, "");
		var number = obj.value.replace(/[^0-9]/g, "");
		var tel = "";

		// 서울 지역번호(02)가 들어오는 경우
		if (number.substring(0, 2).indexOf('02') == 0) {
			$("#user_tel").attr("maxlength", "12")
			if (number.length < 3) {
				return number;
			} else if (number.length < 6) {
				tel += number.substr(0, 2);
				tel += "-";
				tel += number.substr(2);
			} else if (number.length < 10) {
				tel += number.substr(0, 2);
				tel += "-";
				tel += number.substr(2, 3);
				tel += "-";
				tel += number.substr(5);
			} else {
				tel += number.substr(0, 2);
				tel += "-";
				tel += number.substr(2, 4);
				tel += "-";
				tel += number.substr(6);
			}

			// 서울 지역번호(02)가 아닌경우
		} else {
			$("#user_tel").attr("maxlength", "13")
			if (number.length < 4) {
				return number;
			} else if (number.length < 7) {
				tel += number.substr(0, 3);
				tel += "-";
				tel += number.substr(3);
			} else if (number.length < 11) {
				tel += number.substr(0, 3);
				tel += "-";
				tel += number.substr(3, 3);
				tel += "-";
				tel += number.substr(6);
			} else {
				tel += number.substr(0, 3);
				tel += "-";
				tel += number.substr(3, 4);
				tel += "-";
				tel += number.substr(7);
			}
		}

		obj.value = tel;
		$(obj).focusout();
	}
	function sendContact() {
		if ($('#contactName').val() == '') {
			$('#alert_modal_body').html('이름을 입력해주세요.');
			$('#alert_modal').modal('show')
		} else if ($('#contactTel').val() == '') {
			$('#alert_modal_body').html('전화번호를 입력해주세요.');
			$('#alert_modal').modal('show')
		} else if ($('#contactEmail').val() == '') {
			$('#alert_modal_body').html('이메일을 입력해주세요.');
			$('#alert_modal').modal('show')
		} else if ($('#contactMessage').val() == '') {
			$('#alert_modal_body').html('문의내용을 입력해주세요.');
			$('#alert_modal').modal('show')
		} else {
			$('#contact_btn').attr('disabled', true);
			$.ajax({
				url : "/contactSend.do",
				type : "post",
				data : {
					'contactName' : $('#contactName').val(),
					'contactTel' : $('#contactTel').val(),
					'contactEmail' : $('#contactEmail').val(),
					'contactMessage' : $('#contactMessage').val()
				},
				success : function(a) {
					$('#contact_btn').attr('disabled', false);
					if (a == "1") {
						$('#alert_modal_body').html('문의메일이 발송되었습니다.');
						$('#alert_modal').modal('show');
						$('#contact_modal').modal('hide');
						$('#contactName').val('');
						$('#contactTel').val('');
						$('#contactEmail').val('');
						$('#contactMessage').val('');
					} else if (a == "0") {
						$('#alert_modal_body').html(
								'일시적 오류가 발생하였습니다. 나중에 다시 시도해주세요.');
						$('#alert_modal').modal('show');
						$('#contact_modal').modal('hide');
						$('#contactName').val('');
						$('#contactTel').val('');
						$('#contactEmail').val('');
						$('#contactMessage').val('');
					}
				}
			})
		}
	}
</script>
