package com.board.company.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyVo {
	private String user_id;
	private String password;
	private String username;
	private String compname;
	private String email;
	private String phone_number;
	private String j_date;
	
	private String ceo;
	private String address;
	private int    create_date;
	private String business_type;
	
	private Integer aplnum;
	private String post_id;
	private int    recruitnum;
	private String deadline;
	private String duty;
	private String career;
	private String edu;
	private String skills;
	private String licenses;
	private String workspace;
	private int    salary;
	private String department;
	private int    hit;
	
	private Integer comt_id;
	private Integer csp_id;
	private String type;
	private String csp_title;
    private String csp_pw;
    private String content;
    private String csp_file;
    private String result;
	private String c_date;
	
	private String title;
	private int    app_id;
	private String birth;
	private String gender;
	private String number2;
	private String careers;
	private String eduwhen;
	private String eduwher;
	private String major;
	private String licenses1;
	private String licenses2;
	private String licenses3;
	private String publisher1;
	private String publisher2;
	private String publisher3;
	private String passdate1;
	private String passdate2;
	private String passdate3;
	private String skills1;
	private String skills2;
	private String skills3;
	private String skills4;
	private String skills5;
	private String portfolio;
	private String selfintro;
	private String u_date;
	
	private MultipartFile logo; 
	private String logoPath;
	private int hopescore;
	private int licensesscore;
	private int careerscore;
	private int eduscore;
	private int skillsscore;

	public void setCspId(Integer csp_id2) {
		// TODO Auto-generated method stub		
	}
	
    private int    message_id;
    private String sender_userid;
    private String sender_username;
    private String sender_compid;
    private String sender_compname;
    private String receiver_userid;
    private String receiver_username;
    private String receiver_compid;
    private String receiver_compname;
    private String receiver_email;
    private String mcontent;
    private String stime;
    private String is_read;
    private String division;
    
    private String jjim;
    private Double average;
    
    private String bookmark;
    

}
