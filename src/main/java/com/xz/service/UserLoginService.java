package com.xz.service;

import com.xz.entity.UserLogin;

public interface UserLoginService {
	UserLogin getUserById(String id);
	
	UserLogin checkUserExist(UserLogin userLogin);
	
}
