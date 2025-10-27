package com.board.picktalk.vo;

import lombok.Data;

@Data
public class PicktalkVo {
    private int post_id;              
    private String user_id;       
    private String title;            
    private String content;           
    private String post_date;         
    private int vcount;              
}
