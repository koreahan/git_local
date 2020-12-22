package com.koreait.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

/* ② */
@Component
@Data
/* Restaurant 객체는 Chef 객체를 필요로 한다. */
public class Restaurant {
	
	/* ③ */
	/* onMethod_ 속성은 생성되는 setChef에 @Autowired 어노테이션을 추가하도록 한다. */
	@Setter(onMethod_ = @Autowired)
	private Chef chef;
}
