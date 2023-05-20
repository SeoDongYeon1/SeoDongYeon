package com.KoreaIT.sdy.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Board;

@Mapper
public interface BoardRepository {

	public Board getBoardById(int id);

}
