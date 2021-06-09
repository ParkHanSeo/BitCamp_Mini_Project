package com.model2.mvc.service.user;

import java.util.HashMap;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.service.user.vo.UserVO;

public interface UserDAO {
	
	public void insertUser(UserVO userVO) throws Exception;
	
	public UserVO findUser(String userId) throws Exception;
	
	public HashMap<String,Object> getUserList(SearchVO searchVO) throws Exception;
	
	public void updateUser(UserVO userVO) throws Exception;
}
