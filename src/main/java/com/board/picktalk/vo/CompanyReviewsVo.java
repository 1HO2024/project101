package com.board.picktalk.vo;

import lombok.Data;

@Data
public class CompanyReviewsVo {
    private int review_id; 
    private String user_id;     
    private String compname;    
    private double rating;      
    private String content;      
    private String review_date;  
    private String title;  
    private int difficulty;      
    private int mood;          
}
