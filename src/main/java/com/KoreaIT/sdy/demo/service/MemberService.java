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
	
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		// 로그인 아이디 중복체크
		Member member = getMemberByLoginId(loginId);

		if (member != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		// 이름 + 이메일 중복체크
		member = memberRepository.getMemberByNameAndEmail(name, email);

		if (member != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}

		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

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
}

