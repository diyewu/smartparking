package com.xz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.dao.UserLoginMapper;
import com.xz.entity.UserLogin;
import com.xz.service.UserLoginService;

@Service
@Transactional
public class UserLoginServiceImpl implements UserLoginService{
	
	@Autowired
	private UserLoginMapper userLoginMapper;
	@Override
	public UserLogin getUserById(String id) {
		UserLogin userLogin = userLoginMapper.selectByPrimaryKey(id+"");
		return userLogin;
	}
	@Override
	public UserLogin checkUserExist(UserLogin userLogin) {
		return userLoginMapper.checkUserExist(userLogin);
	}

}
