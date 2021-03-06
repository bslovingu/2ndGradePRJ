<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<div class="modal fade" id="search_modal" tabindex="-1" role="dialog" data-keyboard="false"
	data-backdrop="static" aria-labelledby="searchLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="background-color: #1e1e2f;">
			<div class="modal-header">
				<h4 class="card-title" id="searchLabel">It's u, Issue!</h4>
			</div>
			<div id="search_modal_body" class="modal-body">검색중입니다.
			</div>
		</div>
	</div>
</div>
<script>
	function getUserInfo(){
		$.ajax({
			url:"/getUserInfo.do",
			type :"post",
			dataType : "JSON",
			data : {'user_id' : '<%=userId%>'
			},
			success : function(json) {
				if (json.user_id == '로그인오류') {
					
				} else {
					$('#user_mod_id').val(json.user_id);
					$('#user_mod_name').val(json.user_name);
					$('#user_mod_mail').val(json.user_mail);
				}
			}
		})
	}
	
	function getUserList(pgNum,searchCont){
		$.ajax({
			url:"/getUserList.do",
			type : "post",
			dataType : "JSON",
			data : {'user_author' : '<%=userAuthor%>','user_id' : '<%=userId%>',
						'pgNum' : pgNum,
						'searchCont' : searchCont,
						'searchSelect' : $('select[name=searchSelect]').val()
					},
					success : function(a) {
						$('#pgNumValue').val(pgNum);
						$('#pgSearchValue').val(searchCont);
						console.log(a);
						var Result = "";
						Result += '<div class="div_content_container" style="color: #666666; font-weight: bold;">';
						Result += '<div style="display: table-row;">';
						Result += '<div class="table_1st div_content_box"></div>';
						Result += '<div class="table_2nd div_content_box">회원ID</div>';
						Result += '<div class="table_3rd div_content_box">이름</div>';
						Result += '<div class="table_4th div_content_box">이메일</div>';
						Result += '<div class="table_5th div_content_box">권한</div>';
						Result += '</div></div></div>';
						if (a.uList.length == 0) {
							Result += '<div class="div_content_container" style="color: #666666; font-weight: bold;"> <div style="display: table-row;"> <div class="div_content_box" style="text-align: center;">회원 정보가 없습니다.</div></div></div>';
						} else {
							for (var i = 0; i < a.uList.length; i++) {
								Result += '<div class="div_content_container">';
								Result += '<div style="display: table-row;">';
								Result += '<div class="table_1st div_content_box">';
								Result += '<input type="radio" class="" name="check_user" value="'+a.uList[i].user_id+'"> </div>';
								Result += '<div class="table_2nd div_content_box">'
										+ a.uList[i].user_id + '</div>';
								Result += '<div class="table_3rd div_content_box">'
										+ a.uList[i].user_name + '</div>';
								Result += '<div class="table_4th div_content_box">'
										+ a.uList[i].user_mail + '</div>';
								Result += '<div class="table_5th div_content_box">'
										+ a.uList[i].user_author + '</div>';
								Result += '</div></div>';
							}
						}
						Result += '<div class="row" style="margin-top:1em;"><div class="col text-center"><div class="block-27"><ul>';
						if (a.pgNum == 1) {
							Result += '<li><a href="javascript:void(0)">&lt;</a></li>';
						} else {
							Result += '<li><a href="javascript:void(0)" onclick="getUserList('
									+ ($('#pgNumValue').val() - 1)
									+ ','
									+ $('#searchValue').val()
									+ ')">&lt;</a></li>';
						}
						if (a.totalPg < 5) {
							for (var i = 1; i <= a.totalPg; i++) {
								if (a.pgNum == i) {
									Result += '<li class="active"><span>' + i
											+ '</span></li>';
								} else {
									Result += '<li class="active"><a href="javascript:void(0)"  onclick="getUserList('
											+ i
											+ ','
											+ $('#searchValue').val()
											+ ')>' + i + '</a></li>';
								}
							}
						} else {
							if (a.pgNum < 4) {
								for (var i = 1; i < 6; i++) {
									if (a.pgNum == i) {
										Result += '<li class="active"><span>'
												+ i + '</span></li>';
									} else {
										Result += '<li class="active"><a href="javascript:void(0)"  onclick="getUserList('
												+ i
												+ ','
												+ $('#searchValue').val()
												+ ')>' + i + '</a></li>';
									}
								}
							} else if (a.totalPg - 1 == a.pgNum) {
								for (var i = a.pgNum - 3; i <= a.totalPg; i++) {
									if (a.pgNum == i) {
										Result += '<li class="active"><span>'
												+ i + '</span></li>';
									} else {
										Result += '<li class="active"><a href="javascript:void(0)"  onclick="getUserList('
												+ i
												+ ','
												+ $('#searchValue').val()
												+ ')>' + i + '</a></li>';
									}
								}
							} else if (a.totalPg == a.pgNum) {
								for (var i = a.pgNum - 4; i <= a.totalPg; i++) {
									if (a.pgNum == i) {
										Result += '<li class="active"><span>'
												+ i + '</span></li>';
									} else {
										Result += '<li class="active"><a href="javascript:void(0)"  onclick="getUserList('
												+ i
												+ ','
												+ $('#searchValue').val()
												+ ')>' + i + '</a></li>';
									}
								}
							} else {
								for (var i = a.pgNum - 2; i < a.pgNum + 3; i++) {
									if (a.pgNum == i) {
										Result += '<li class="active"><span>'
												+ i + '</span></li>';
									} else {
										Result += '<li class="active"><a href="javascript:void(0)"  onclick="getUserList('
												+ i
												+ ','
												+ $('#searchValue').val()
												+ ')>' + i + '</a></li>';
									}
								}
							}
						}
						if (a.totalPg == a.pgNum) {
							Result += '<li><a href="javascript:void(0)">&gt;</a></li>';
						} else {
							Result += '<li><a href="javascript:void(0)" onclick="getUserList('
									+ ($('#pgNumValue').val() + 1)
									+ ','
									+ $('#searchValue').val()
									+ ')">&gt;</a></li>';
						}
						Result += '</ul></div></div></div>';

						$('#user_list_table').html(Result);
					}
				})
	}
</script>