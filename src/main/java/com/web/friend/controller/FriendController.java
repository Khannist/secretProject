package com.web.friend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.web.friend.vo.FriendVO;

@RestController
public class FriendController {
	
	//List<FriendVO> friendList = new ArrayList<FriendVO>();
	 
	@Autowired
	private SqlSession ss;
	
	@RequestMapping("/ajax.do")
	@ResponseBody
	public void ajax(HttpServletResponse res,FriendVO fVo) throws Exception{
		Gson gson = new Gson();
		Map<String, Object> data = new HashMap<String, Object>();
		List<String> list = null;
		
		
		String name = fVo.getMainId();
		//System.out.println("mainId1 = " + fVo.getMainId());
		//System.out.println("mainId2 = " + name);
		
		list = ss.selectList("ChatMapper.selectFriendList", fVo.getMainId());
		
		data.put("list", list);

		res.getWriter().print(gson.toJson(data));
	}
	
	
	
	
	// ajax 친구 리스트
	@RequestMapping("/ajax.flist")
	public @ResponseBody List<FriendVO> ajaxFlist (FriendVO fVo) {
		List<FriendVO> friendList = null;
		String mainId = fVo.getMainId(); 
		if(mainId != null && !mainId.trim().equals("")) {
			friendList = ss.selectList("ChatMapper.selectFriendList", fVo.getMainId());			
		}
		
		
		return friendList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
