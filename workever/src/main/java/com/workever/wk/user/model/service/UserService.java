package com.workever.wk.user.model.service;

import java.util.HashMap;

import com.workever.wk.user.model.vo.User;

public interface UserService {
	
	User loginUser(User u);
	
	int emailDoubleCheck(String checkEmail);
	
	// 회사코드 중복체크
	int companyCodeCheckAdmin(String companyCode);
	
	// 회사코드 확인(사원)
	//int companyCodeCheckUser(String companyCode);
	
	// 회원가입 (관리자)
	int insertCompany(HashMap<String, Object> admin);
	
	// 회원가입(사원)
	int insertUser(HashMap<String, Object> user);

}
