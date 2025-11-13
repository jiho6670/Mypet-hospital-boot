package com.boot.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mypet_NoticesDTO {
	private int notice_no;
	private int admin_no;
	private String notice_title;
	private String notice_content;
	private int view_count;
	private String is_fixed = "N";
	private Timestamp created_date;
	private Timestamp updated_date;
	private String notice_file;
}
