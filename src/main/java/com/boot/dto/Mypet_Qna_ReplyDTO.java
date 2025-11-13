package com.boot.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mypet_Qna_ReplyDTO {
	private int reply_no;
	private int qna_no;
	private int user_no;
	private String reply_content;
	private Date created_date;
}
