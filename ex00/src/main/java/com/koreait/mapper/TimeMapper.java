package com.koreait.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("SELECT SYSDATE FROM DUAL")
	public String getTime();
	
	//실제 SQL은 XML을 이용해서 처리
	public String getTime2();
}
