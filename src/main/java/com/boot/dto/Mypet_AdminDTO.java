package com.boot.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mypet_AdminDTO {
	private int admin_no;
	private String admin_id;
	private String admin_pwd;
	private String admin_name;
	private String admin_gender;
	private Date admin_birthday;
	private String admin_phone;
	private String admin_email;
	private Date admin_regidate;
	private String admin_img;	
}
