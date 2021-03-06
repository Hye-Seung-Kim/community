package com.hstravel.reply.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hstravel.member.constants.Member;
import com.hstravel.member.vo.MemberVO;
import com.hstravel.reply.service.ReplyService;
import com.hstravel.reply.vo.ReplyVO;

@Controller
public class ReplyController {
	
	private ReplyService replyService;
	
	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@RequestMapping(value = "/api/reply/{communityId}", method = RequestMethod.GET)
	@ResponseBody
	public List<ReplyVO> getAllReplies(@PathVariable int communityId){
		return replyService.readAllReplies(communityId);
	}
	
	@RequestMapping(value = "/api/reply/{communityId}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createReply(
			@PathVariable int communityId,
			HttpSession session,
			ReplyVO replyVO){
		
		MemberVO member = (MemberVO) session.getAttribute(Member.USER);
		replyVO.setUserId(member.getId());
		replyVO.setCommunityId(communityId);
		
		boolean isSuccess = replyService.createReply(replyVO);
		
		ReplyVO newReply = null;
		if ( isSuccess ) {
			newReply = replyService.readOneReply(replyVO.getId());
		}
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", isSuccess);
		result.put("reply", newReply);
		
		return result;
	}
	
}
