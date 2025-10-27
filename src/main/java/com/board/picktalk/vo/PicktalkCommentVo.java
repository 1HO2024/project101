package com.board.picktalk.vo;

import lombok.Data;

@Data
public class PicktalkCommentVo {
    private int comment_id;       
    private int post_id;         
    private String user_id;   
    private String content;          
    private String comment_date;      
    private int parent_comment_id;
}
