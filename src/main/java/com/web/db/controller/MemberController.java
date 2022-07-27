package com.web.db.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.catalina.connector.Response;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.web.db.vo.MemberVO;
import com.web.friend.vo.FriendVO;

@RestController
public class MemberController {
	@Autowired
	private SqlSession ss;
	
	@RequestMapping({("/index"),("/")})
	public ModelAndView indexList(MemberVO mVo) {
		ModelAndView mav = new ModelAndView();
		
		if(mVo.getUserId() == null) {
			
		}else {
			mav.addObject("mVo", mVo);			
		}
		mav.setViewName("/index");
		return mav;
	}
	
	@RequestMapping("/login")
	public ModelAndView loginPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/login/loginForm");
		return mav;
	}
	
	@RequestMapping("/loginCheck")
	public ModelAndView loginCheck(MemberVO mVo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("mVo.getId = " + mVo.getUserId());
		MemberVO tempVo = ss.selectOne("ChatMapper.loginCheck", mVo);
		System.out.println("tempVo.length = " + String.valueOf(tempVo));
		if(String.valueOf(tempVo).equals("null")) {
			mav.addObject("msg", "존재하지 않는 아이디 입니다.");
		}else {
			if(!tempVo.getUserPw().equals(mVo.getUserPw())) {
				mav.addObject("msg", "로그인에 실패했습니다.");
			}else {
				mav.addObject(mVo);
				mav.setViewName("forward:/");
				return mav;
			}
		}
		mav.setViewName("login/loginForm");
		return mav;
	}
	
	@RequestMapping("/friendList")
	public ModelAndView flt() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/friend/friendList");
		return mav;
	}

}
