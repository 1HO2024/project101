<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
        <select class="select-field" name="workspace" id="workspace" >
          <option value=""     ${vo.workspace == '' ? 'selected' : ''}>지역별</option>
          <option value="서울" ${vo.workspace == '서울' ? 'selected' : ''}>서울</option>
          <option value="경기" ${vo.workspace == '경기' ? 'selected' : ''}>경기</option>
          <option value="인천" ${vo.workspace == '인천' ? 'selected' : ''}>인천</option>
          <option value="부산" ${vo.workspace == '부산' ? 'selected' : ''}>부산</option>
          <option value="대구" ${vo.workspace == '대구' ? 'selected' : ''}>대구</option>
          <option value="광주" ${vo.workspace == '광주' ? 'selected' : ''}>광주</option>
          <option value="대전" ${vo.workspace == '대전' ? 'selected' : ''}>대전</option>
          <option value="울산" ${vo.workspace == '울산' ? 'selected' : ''}>울산</option>
          <option value="세종" ${vo.workspace == '세종' ? 'selected' : ''}>세종</option>
          <option value="제주" ${vo.workspace == '제주' ? 'selected' : ''}>제주</option>
          <option value="강원" ${vo.workspace == '강원' ? 'selected' : ''}>강원</option>
          <option value="경남" ${vo.workspace == '경남' ? 'selected' : ''}>경남</option>
          <option value="경북" ${vo.workspace == '경북' ? 'selected' : ''}>경북</option>
          <option value="전남" ${vo.workspace == '전남' ? 'selected' : ''}>전남</option>
          <option value="전북" ${vo.workspace == '전북' ? 'selected' : ''}>전북</option>
          <option value="충남" ${vo.workspace == '충남' ? 'selected' : ''}>충남</option>
          <option value="충북" ${vo.workspace == '충북' ? 'selected' : ''}>충북</option>
        </select>