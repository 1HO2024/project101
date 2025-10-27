package com.board.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentVo {
    private Integer comt_id;
    private Integer csp_id;
    private String  user_id;
    private String  content;
    private String  c_date;

    // Getters and Setters
}
