package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	public void writeReply(String relTypeCode, int relId, String body, int actorId);

	public List<Reply> getForPrintReplies(int actorId, String relTypeCode, int relId);

	public Reply getReplyById(int id);

	public void deleteReply(int id);

	public void modifyReply(int id, String body);

}