package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.ArticleRepository;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Service
public class ArticleService {
	@Autowired
	ArticleRepository articleRepository;

	// 생성자
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	// 게시글 작성
	public ResultData writeArticle(String title, String body, int memberId, int boardId) {
		articleRepository.writeArticle(title, body, memberId, boardId);

		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 글이 생성되었습니다.", id), id);

	}

	// 게시글 리스트
	public List<Article> getArticles(int boardId) {

		return articleRepository.getArticles(boardId);
	}

	// 게시글 수정
	public String modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);

		return Ut.jsReplace(Ut.f("%d번 게시글이 수정되었습니다.", id), Ut.f("../article/detail?id=%d", id));
	}

	// 게시글 삭제
	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	// 특정 게시글 가져오기(id값을 이용)
	public Article getArticleById(int id) {
		return articleRepository.getArticleById(id);
	}

	// 사용자가 게시글 수정가능한지
	public ResultData actorCanModifyRd(Article article, int actorId) {

		if (article.getMemberId() != actorId) {
			return ResultData.from("F-1", "해당 게시글에 권한이 없습니다.");
		}

		return ResultData.from("S-1", "수정 가능");
	}

	// 사용자가 게시글 삭제 가능한지
	public ResultData actorCanDeleteRd(Article article, int actorId) {

		if (article.getMemberId() != actorId) {
			return ResultData.from("F-1", "해당 게시글에 권한이 없습니다.");
		}

		return ResultData.from("S-1", "삭제 가능");
	}

	// 조인 셀렉트 버전
	public Article getForPrintArticle(int id) {
		return articleRepository.getForPrintArticle(id);
	}

	// 게시글 갯수
	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	// 조인 버전 게시글 리스트
	public List<Article> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode,
			String searchKeyword) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return articleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode,
				searchKeyword);
	}

	// 조회수 증가
	public ResultData increaseHitCount(int id) {
		int affectedRow = articleRepository.increaseHitCount(id);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "해당 게시글은 존재하지 않습니다.", affectedRow);
		}

		return ResultData.from("S-1", "조회수 증가", affectedRow);
	}

	// 조회수 갯수 가져오기
	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}

	// 댓글 갯수 가져오기
	public List<Article> getRepliesCount() {
		return articleRepository.getRepliesCount();
	}

}
