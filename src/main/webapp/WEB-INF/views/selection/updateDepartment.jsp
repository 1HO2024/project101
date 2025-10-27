<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <select class="select-field" name="department" id="department">
          <option value=""                   ${vo.department == '' ? 'selected' : ''}>직무별</option>
          <option value="기획,전략"          ${vo.department == '기획,전략' ? 'selected' : ''}>기획,전략</option>
          <option value="마케팅,홍보,조사"   ${vo.department == '마케팅,홍보,조사' ? 'selected' : ''}>마케팅,홍보,조사</option>
          <option value="회계,세무,채무"     ${vo.department == '회계,세무,채무' ? 'selected' : ''}>회계,세무,채무</option>
          <option value="인사,노무,HRD"      ${vo.department == '인사,노무,HRD' ? 'selected' : ''}>인사,노무,HRD</option>
          <option value="총무,법무,사무"     ${vo.department == '총무,법무,사무' ? 'selected' : ''}>총무,법무,사무</option>
          <option value="IT개발,데이터"      ${vo.department == 'IT개발,데이터' ? 'selected' : ''}>IT개발,데이터</option>
          <option value="디자인"             ${vo.department == '디자인' ? 'selected' : ''}>디자인</option>
          <option value="영업,판매,무역"     ${vo.department == '영업,판매,무역' ? 'selected' : ''}>영업,판매,무역</option>
          <option value="고객상담,TM"        ${vo.department == '고객상담,TM' ? 'selected' : ''}>고객상담,TM</option>
          <option value="구매,자재,물류"     ${vo.department == '구매,자재,물류' ? 'selected' : ''}>구매,자재,물류</option>
          <option value="상품기획,MD"        ${vo.department == '상품기획,MD' ? 'selected' : ''}>상품기획,MD</option>
          <option value="운전,운송,배송"     ${vo.department == '운전,운송,배송' ? 'selected' : ''}>운전,운송,배송</option>
          <option value="서비스"             ${vo.department == '서비스' ? 'selected' : ''}>서비스</option>
          <option value="생산"               ${vo.department == '생산' ? 'selected' : ''}>생산</option>
          <option value="건설,건축"          ${vo.department == '건설,건축' ? 'selected' : ''}>건설,건축</option>
          <option value="의료"               ${vo.department == '의료' ? 'selected' : ''}>의료</option>
          <option value="연구,R&D"           ${vo.department == '연구,R&D' ? 'selected' : ''}>연구,R&D</option>
          <option value="교육"               ${vo.department == '교육' ? 'selected' : ''}>교육</option>
          <option value="미디어,문화,스포츠" ${vo.department == '미디어,문화,스포츠' ? 'selected' : ''}>미디어,문화,스포츠</option>
          <option value="금융,보험"          ${vo.department == '금융,보험' ? 'selected' : ''}>금융,보험</option>
          <option value="공공,복지"          ${vo.department == '공공,복지' ? 'selected' : ''}>공공,복지</option>
        </select>