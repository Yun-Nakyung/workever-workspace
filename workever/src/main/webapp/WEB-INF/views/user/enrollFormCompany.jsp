<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common/links.jsp" />

<style>
	body {
		margin: 0;
	}

	div {
		box-sizing: border-box;
	}

	.enrollform-company-area {

		margin: 50px 550px 50px 550px;
	}

	#enroll-company-title {
		text-align: center;
		margin-bottom: 50px;
	}

	#company-code {
		width: 77%;
		display: inline-block;
	}

	.form-group button {
		width: 150px;
		height: 35px;
		border: none;
		background-color: lightgray;
		border-radius: 3%;
		margin-left: 20px;
	}

	.enroll-check {
		margin-top: 60px;
		margin-bottom: 40px;
		padding-left: 190px;
		padding-right: 170px;
	}

	.form-check-label {
		font-size: 13px;
	}

	.btn-sub {
		text-align: center;
		margin-bottom: 50px;
	}

	.btn-sub button {
		width: 150px;
		height: 35px;
		border: none;
		background-color: rgb(78, 115, 223);
		color: white;
		font-weight: bold;
		border-radius: 3%;
	}

	#btn-checkCode{
		width: 170px; height: 38px;
		border: none;
		background-color: lightgray;
		border-radius: 2px;
		
	}
</style>
</head>

<body>

	<jsp:include page="startHeader.jsp"></jsp:include>

	<div class="enrollform-company-area">

		<div id="enroll-company-title">
			<h3 style="font-weight: 600;">Workever 비즈니스 계정 생성</h3>
		</div>

		<div class="card card-light">

			<!-- form start -->
			<form>
				<div class="card-body">
					<div class="form-group">
						<label for="company-email">이메일</label>
						<input type="email" class="form-control" id="company-email" placeholder="Enter email">
						<div id="checkEmail">

						</div>
					</div>
					<div class="form-group">
						<label for="company-adminname">이름</label>
						<input type="text" class="form-control" id="company-adminname" placeholder="Password">
						<div id="checkName">

						</div>
					</div>
					<div class="form-group">
						<label for="company-pwd">비밀번호</label>
						<input type="password" class="form-control" id="company-pwd" placeholder="Password">
						<div id="checkPwd">

						</div>
					</div>
					<div class="form-group">
						<label for="company-pwdcheck">비밀번호 확인</label>
						<input type="password" class="form-control" id="company-pwdcheck" placeholder="Password">
						<div id="checkPwd-check">

						</div>
					</div>
					<div class="form-group">
						<label for="company-name">회사명</label>
						<input type="text" class="form-control" id="company-name" placeholder="Password">
					</div>
					<div class="form-group" id="checkCode">
						<label for="company-code">회사 코드</label><br>
						<input type="text" class="form-control" id="company-code" placeholder="Password">
						<!--<button id="btn-checkCodeD">회사코드확인</button>-->
						<input type="button" value="회사코드중복확인" id="btn-checkCode" onclick="checkCompanyCode();">
					</div>
					<div class="form-group">
						<label>회사 업종</label>
						<select class="form-control">
							<option>제조</option>
							<option>서비스</option>
							<option>IT</option>
							<option>유통</option>
							<option>교육/연구</option>
							<option>건설</option>
							<option>의료</option>
							<option>금융</option>
							<option>공공행정</option>
							<option>엔터테인먼트</option>
							<option>기타</option>
						</select>
					</div>
					<div class="enroll-check">
						<input type="checkbox" class="form-check-input" id="form-check">
						<label class="form-check-label" for="form-check">
							서비스 이용약관, 개인정보 취급방침을 확인하였고, 이에 동의합니다.
						</label>
					</div>
				</div>

				<div class="btn-sub">
					<button type="submit">회원가입</button>
				</div>

			</form>
		</div>

		<!-- 이메일 중복체크용 모달 -->
		<div class="modal fade" id="emailDoubleCheck-modal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<div style="margin-left:170px;">
							<span style="text-align: center; font-size: 17px; font-weight: 700;">
								이메일 중복 확인
							</span>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							&times;
						</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div style="text-align: center;">
							<span
								style="font-size: 15px; font-weight: 600; display: inline-block; margin-top: 20px;">
								사용 가능한 이메일 입니다.
							</span><br>
						</div>
						<div style="text-align: center; margin-top: 60px;">
							<button type="button" class="btn" data-dismiss="modal" id="btn-emailDoubleCheck"
							style="width: 90px; background-color: rgb(78, 115, 223); color: white;">
								닫기
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 회사코드 중복체크용 모달 -->
		<div class="modal fade" id="after-checkCodeE">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<div style="margin-left:160px;">
							<span style="text-align: center; font-size: 17px; font-weight: 700;">
								회사 코드 중복 체크
							</span>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							&times;
						</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div style="text-align: center;">
							<span
								style="font-size: 15px; font-weight: 600; display: inline-block; margin-top: 20px;">
								사용 가능한 회사 코드입니다.
							</span><br>
							<span style="font-size: 13px; display: inline-block; margin: 10px 0 60px 0;">
								사용하시려면 확인을 클릭해주세요.
							</span>
						</div>
						<div style="text-align: center;">
							<button type="button" class="btn" id="btn-checkCodeE" data-dismiss="modal"
							style="width: 90px; background-color: rgb(78, 115, 223); color: white;">
								확인
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="after-checkCodeD">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<div style="margin-left:160px;">
							<span style="text-align: center; font-size: 17px; font-weight: 700;">
								회사 코드 중복 체크
							</span>
						</div>
						<button type="button" class="close" data-dismiss="modal">
							&times;
						</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div style="text-align: center;">
							<span
								style="font-size: 15px; font-weight: 600; display: inline-block; margin-top: 20px;">
								이미 사용중인 회사코드 입니다.
							</span><br>
						</div>
						<div style="text-align: center; margin-top: 60px;">
							<button type="button" class="btn" id="btn-checkCodeD" data-dismiss="modal"
							style="width: 90px; background-color: rgb(78, 115, 223); color: white;">
								닫기
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="startFooter.jsp"></jsp:include>
	<jsp:include page="../common/scripts.jsp" />

	<script>

		// 정규식 
		// 이메일 정규식
		let emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 비밀번호 정규식
		let pwdExp = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}$/i;
		// 휴대폰번호 정규식
		let phoneExp = /^01[0179]([0-9]{7,8}$)/;

		$("#company-email").blur(function () {
			// 이메일 정규표현식 확인
			if (!emailExp.test($(this).val())) {
				console.log(emailExp.test($(this).val()));
				$('#checkEmail').text("이메일을 확인해주세요.");
				$('#checkEmail').css('color', 'red');
				$('#company-email').css('border', '2px solid red');
				$('#company-email').focus();
			} else {
				$('#checkEmail').text('');
				$('#company-email').css('border', '1px solid #ced4da');
				checkEmailDouble();
			}
		});

		// 비밀번호 정규표현식 확인
		$('#company-pwd').blur(function () {
			if (!pwdExp.test($(this).val())) {
				console.log(pwdExp.test($(this).val()));
				$('#checkPwd').text("비밀번호는 영문, 숫자, 특수문자 포함 8~16자리 입니다.");
				$('#checkPwd').css('color', 'red');
				$('#company-pwd').css('border', '2px solid red');
				$('#company-pwd').focus();
			} else {
				$('#checkPwd').text('');
				$('#company-pwd').css('border', '1px solid #ced4da');
			}
		});

		// 비밀번호 중복확인
		$('#company-pwdcheck').blur(function () {
			if ($('#company-pwdcheck').val() != $('#company-pwd').val()) {
				$('#checkPwd-check').text('비밀번호가 일치하지 않습니다.');
				$('#checkPwd-check').css('color', 'red');
				$('#company-pwdcheck').css('border', '2px solid red');
				$('#company-pwdcheck').focus();
			} else {
				$('#checkPwd-check').text('');
				$('#company-pwdcheck').css('border', '1px solid #ced4da');
			}
		});

		// 이메일 중복체크
		function checkEmailDouble() {
			const emailInput = $('#company-email');

			$.ajax({
				url: "emailDoubleCheck.do",
				data: { checkEmail: emailInput.val() },
				type: "post",
				success: function (result) {
					if (result == 'NNNNY') {
						// 사용 가능
						$("#emailDoubleCheck-modal").modal('show');
						//$('#company-adminname').focus();
						emailInput.attr("readonly", true);
						$('#btn-emailDoubleCheck').click(function(){
							$('#emailDoubleCheck-modal').modal('hide');
							$('#company-adminname').focus();
						})
					} else {
						alert("이미 사용중인 이메일입니다.");
						emailInput.val('');
						emailInput.focus();
					}
				}, error: function () {
					console.log("ajax 통신 실패")
				}
			})
		}

		// 회사코드 중복확인
		function checkCompanyCode() {
			const companyCode = $('#company-code');

			if(companyCode.val() == ''){
				alert("사용할 회사코드를 입력하세요.");
				companyCode.focus();
			}else{
				$.ajax({
					url: "companyCodeCheck.ad",
					data: { companyCode: companyCode.val() },
					type: "post",
					success: function (result) {
						if (result == 'NNNNY') {
							// 사용가능
							$('#after-checkCodeE').modal();
							companyCode.attr("readonly", true);
						} else {
							// 중복
							$('#after-checkCodeD').modal();
						}
					}, error: function () {
						console.log("회사코드인증 ajax 통신 실패");
					}
				})
			}

		}

		// 모달 닫기 버튼 클릭 시 포커스 이동
		$('#btn-checkCodeD').click(function(){
			$('#company-code').focus();
		})
		$('#btn-emailDoubleCheck').click(function(){
			$('#company-adminname').focus();
		})

		
	</script>
</body>
</html>