package com.workever.wk.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter @Getter
@ToString
public class User {

	private String userNo;
	private String deptNo;
	private String comNo;
	private String userEmail;
	private String userName;
	private String userPhone;
	private String userPwd;
	private String userRank;
	private String userJoinDate;
	private String userResDate;
	private String userStatus;
	private String userEnabled;
	private String userFilePath;
	private String userAuth;
	private String userAnnualDate;
	private String userUseDate;
	private String companyCode;
	
	private String deptName;
	private String comName;
	private String comPhone;
	
	private String comEncode;
	
	// 검색, 카테고리별 정렬을 위해 필요한 필드
	private String category;
	private String group;
	private String keyword;
	
	// 조직도 카테고리
	private String orgCategory;
}
