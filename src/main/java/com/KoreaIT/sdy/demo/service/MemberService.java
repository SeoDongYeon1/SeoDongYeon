package com.KoreaIT.sdy.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.MemberRepository;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Member;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Service
public class MemberService {
	@Autowired
	MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	public ResultData doJoin(String email, String loginPw, String name, String nickname, String cellphoneNum) {
		// 로그인 이메일 중복체크
		Member member = getMemberByEmail(email);

		if (member != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 이메일(%s)입니다", email));
		}

		memberRepository.doJoin(email, loginPw, name, nickname, cellphoneNum);

		return ResultData.from("S-1", "회원가입이 완료되었습니다");
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

	public Member getMemberByLoginId(String loginId) {
		Member member = memberRepository.getMemberByLoginId(loginId);
		
		return member;
	}

	public Member getMemberByEmail(String email) {
		return memberRepository.getMemberByEmail(email);
	}

	public Member getMemberByNickname(String nickname) {
		return memberRepository.getMemberByNickname(nickname);
	}

	public ResultData modifyMember(int id, String loginPw, String name, String nickname, String cellphoneNum) {
		memberRepository.modifyMember(id, loginPw, name, nickname, cellphoneNum);
		return ResultData.from("S-1", "회원 정보 수정이 완료되었습니다");
	}
}

