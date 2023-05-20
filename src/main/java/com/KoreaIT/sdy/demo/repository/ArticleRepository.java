package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public void writeArticle(String title, String body, int memberId, int boardId);

	public List<Article> getArticles(int boardId);

	public void modifyArticle(int id, String title, String body);

	public void deleteArticle(int id);
	
	public Article getArticleById(int id);

	public int getLastInsertId();

	public Article getForPrintArticle(int id);

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

	public List<Article> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword);

	public int increaseHitCount(int id);

	public int getArticleHitCount(int id);

	public List<Article> getRepliesCount();


}
