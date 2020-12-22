package com.koreait.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

@Component
@Data
public class Shop {
	@Setter(onMethod_ = {@Autowired})
	private Employee employee;
}
