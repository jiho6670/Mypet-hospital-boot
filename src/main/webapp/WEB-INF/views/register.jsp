<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 우리 MYPET 동물병원</title>

<!-- 최소 변경: 정적 리소스 경로 Boot 형식으로 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/register.css">

</head>
<body>
 <div class="floating-icons">
        <a href="https://www.instagram.com/khieiorkr/" target="_blank" class="icon-instagram">
            <img src="https://img.icons8.com/fluent/48/000000/instagram-new.png" alt="인스타그램"/>
        </a>
        <a href="https://www.youtube.com/@KH_academy" target="_blank" class="icon-youtube">
            <img src="https://img.icons8.com/color/48/youtube-play.png" alt="유튜브"/>
        </a>
        <a href="<c:url value='/map' />" class="icon-map">
            <img src="https://img.icons8.com/color/48/000000/map-marker.png" alt="오시는길"/>
        </a>
    </div>

<header>
    <div class="inner">
        <h1>
            <a href="<c:url value='/mainpage' />">
                <img src="/img/mypet.png">MY PET 동물병원
            </a>
        </h1>

        <ul id="gnb">
            <li><a href="<c:url value='/hospital_info' />">병원소개</a></li>
            <li class="dropdown-parent"><a href="#">게시판</a>
                <ul class="submenu">
                    <li><a href="<c:url value='/notices_list' />">공지사항</a></li>
                    <li><a href="#">자유게시판</a></li>
                    <li><a href="<c:url value='/qna_page' />">Q&A</a></li>
                </ul>
            </li>

            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'USER'}">
                    <li><a href="<c:url value='/reservation' />">예약</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="<c:url value='/login' />">예약</a></li>
                </c:otherwise>
            </c:choose>
        </ul>

        <ul class="util">
            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'USER'}">
                    <li><a href="<c:url value='/mypage_userinfo'/>">마이페이지</a></li>
                    <li><a href="<c:url value='/logout'/>">로그아웃</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="<c:url value='/login'/>">로그인</a></li>
                    <li><a href="<c:url value='/register'/>">회원가입</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</header>

<main>
    <div class="register-container">
        <h2>보호자 정보 등록 🐾</h2>
        <p>우리 MYPET 동물병원의 가족이 되어주세요!</p>

        <form action="registerProcess" method="post" enctype="multipart/form-data">
            
            <div class="input-group">
                <label for="user_id">아이디</label>
                <input type="text" id="user_id" name="user_id" placeholder="사용하실 아이디를 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="user_pwd">비밀번호</label>
                <input type="password" id="user_pwd" name="user_pwd" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="input-group">
                <label for="user_name">보호자 성함</label>
                <input type="text" id="user_name" name="user_name" placeholder="이름을 입력하세요" required>
            </div>

            <div class="input-group">
                <label>성별</label>
                <div class="gender-options">
                    <label><input type="radio" name="user_gender" value="M"> 남성</label>
                    <label><input type="radio" name="user_gender" value="F"> 여성</label>
                    <label><input type="radio" name="user_gender" value="O"> 선택안함</label>
                </div>
            </div>

            <div class="input-group">
                <label for="user_birthday">생년월일</label>
                <input type="date" id="user_birthday" name="user_birthday">
            </div>

            <div class="input-group">
                <label for="user_phone">휴대폰 번호</label>
                <input type="tel" id="user_phone" name="user_phone" placeholder="'-' 없이 숫자만 입력하세요" required>
            </div>
            
            <div class="input-group">
                <label for="user_email">이메일</label>
                <input type="email" id="user_email" name="user_email" placeholder="예: petlover@email.com">
            </div>

            <div class="input-group">
                <label for="user_addr">주소</label>
                <input type="text" name="user_addr" placeholder="기본 주소" style="margin-top:10px;">
                <input type="text" name="user_addr_detail" placeholder="상세 주소" style="margin-top:10px;">
            </div>
            
            <button type="submit" class="submit-btn">가입하기</button>
        </form>
    </div>
</main>

<footer>
    <div class="inner">
        <div class="footer-logo"><a href="#">MY PET 동물병원</a></div>
        <div class="footer-info">
            <p>주소: 부산광역시 OO구 OO로 123번길 45 | 대표: 김원장 | 사업자등록번호: 123-45-67890</p>
            <p>TEL: 051-123-4567 | E-MAIL: contact@mypet.com</p>
            <p class="copyright">
                &copy; 2025 MY PET Animal Hospital. All Rights Reserved.
            </p>
        </div>
    </div>
</footer>

</body>
</html>
