package com.boot.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mypet_Qna_BoardDTO {
	private int qna_no;
	private int user_no;
	private String qna_title;
	private String qna_content;
	private String qna_file;
	private String is_answered;
	private Date created_date;
}
