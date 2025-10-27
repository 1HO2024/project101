package com.board.individual.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IndividualVo {
	private String user_id;
	private String user_id2;
	private String username;
	private String email;
	private String password;
	private String phone_number;
	private String address;
	private String j_date;
	
	private int    app_id;
	private Integer aplnum;
	private String post_id;
	private String title;  
	private String app_date;
	private String picture;
	private String location;
	private String result;
	
	private String birth;
	private String gender;
	private String number2;
	private String career;
	private String careers;
	private String eduwhen;
	private String eduwher;
	private String edu;
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
	private String portfolioPath;
	private MultipartFile portfolio;
	private String selfintro;
	private String c_date;
	private String u_date;
	
	private int    recruitnum;
	private String deadline;
	private String duty;
	private String skills;
	private String licenses;
	private String workspace;
	private int    salary;
	private String department;
	private String compname;
	private int    hit;
	
	private Integer comt_id;
	private Integer csp_id;
	private String type;
	private String csp_title;
    private String csp_pw;
    private String content;
    private String csp_file;
    private String photoPath;
    private MultipartFile photo;
    
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

    private String ubook_id;
    private String jjim;
    
}
