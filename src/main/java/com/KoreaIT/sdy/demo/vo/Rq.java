package com.KoreaIT.sdy.demo.vo;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.KoreaIT.sdy.demo.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;
	@Getter
	private String loginedMemberLoginId;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		
		this.session = req.getSession();

		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;
		String loginedMemberLoginId = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = (Member) session.getAttribute("loginedMember");
			loginedMemberLoginId = (String) session.getAttribute("loginedMemberLoginId");
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		this.loginedMemberLoginId = loginedMemberLoginId;
		
		this.req.setAttribute("rq", this);
	}

	public void printHistoryBackJs(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.empty(msg)) {
			println("alert('" + msg + "');");
		}
		println("history.back();");
		println("</script>");
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) {
		print(str + "\n");
	}
	
	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("loginedMember", member);
		session.setAttribute("loginedMemberLoginId", member.getLoginId());
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}
	
	// 삭제 x, rq 객체 자동생성
	public void initOnBeforeActionInterceptor() {
		
	}

	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";

	}

	public String jsHistoryBack(String resultCode, String msg) {
		return Ut.jsHistoryBack(resultCode, msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}
	
	public boolean isNotLogined() {
		return !isLogined;
	}

}