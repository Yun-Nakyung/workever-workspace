package com.workever.wk.chatting.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workever.wk.common.model.vo.PageInfo;
import com.workever.wk.user.model.vo.User;

@Repository
public class ChattingDao {

	public int abSelectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("userMapper.abSelectListCount");
	}

	public ArrayList<User> abSelectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1 ) * pi.getBoardLimit();
	    int limit = pi.getBoardLimit();
	    RowBounds rowBounds = new RowBounds(offset, limit);
	        
		return (ArrayList)sqlSession.selectList("userMapper.abSelectList", null, rowBounds);
	}

	public ArrayList<User> ivSelectList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ivSelectList");
	}
	
}
