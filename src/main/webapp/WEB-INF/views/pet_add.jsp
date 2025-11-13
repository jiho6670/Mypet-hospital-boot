<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 펫 등록 - MY PET 동물병원</title>

<!-- ⭐ Spring Boot 정적 리소스 경로로 교체 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/mypage_userinfo_edit.css">

</head>
<body>

<!-- SNS Floating Icons -->
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

<!-- HEADER -->
<header>
    <div class="inner">
        <h1>
            <a href="<c:url value='/mainpage' />">
                <img src="/img/mypet.png">MY PET 동물병원
            </a>
        </h1>

        <ul id="gnb">
            <li><a href="<c:url value='/hospital_info' />">병원소개</a></li>
            <li class="dropdown-parent">
                <a href="#">게시판</a>
                <ul class="submenu">
                    <li><a href="<c:url value='/notices_list' />">공지사항</a></li>
                    <li><a href="#">자유게시판</a></li>
                    <li><a href="<c:url value='/qna_page' />">Q&A</a></li>
                </ul>
            </li>

            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'USER'}">
                    <li><a href="/reservation">예약</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/login">예약</a></li>
                </c:otherwise>
            </c:choose>
        </ul>

        <ul class="util">
            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'USER'}">
                    <li><a href="/mypage_userinfo">마이페이지</a></li>
                    <li><a href="/logout">로그아웃</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/login">로그인</a></li>
                    <li><a href="/register">회원가입</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</header>

<!-- MAIN CONTENT -->
<main>
    <div class="edit-container">
        <h2>나의 펫 등록 🐾</h2>
        <p>정보를 입력해주세요.</p>

        <form action="/petjoinProcess" method="post" enctype="multipart/form-data">

            <div class="input-group">
                <input type="text" name="pet_name" placeholder="펫 이름" required>
            </div>

            <div class="input-group">
                <input type="text" name="pet_species" placeholder="종(강아지, 고양이 등)" required>
            </div>

            <div class="input-group">
                <input type="text" name="pet_breed" placeholder="품종(예: 말티즈, 리트리버)" required>
            </div>

            <div class="input-group">
                <label>성별</label>
                <div class="gender-options">
                    <label><input type="radio" name="pet_gender" value="M"> 남성</label>
                    <label><input type="radio" name="pet_gender" value="F"> 여성</label>
                </div>
            </div>

            <div class="input-group">
                <label for="pet_birthday">생년월일</label>
                <input type="date" id="pet_birthday" name="pet_birthday">
            </div>

            <div class="input-group">
                <label>중성화 여부</label>
                <div class="pet_neutered-options">
                    <label><input type="radio" name="pet_neutered" value="Y"> 예</label>
                    <label><input type="radio" name="pet_neutered" value="N"> 아니오</label>
                </div>
            </div>

            <div class="input-group">
                <label for="pet_img" class="file-label">프로필 사진 추가</label>
                <input type="file" id="pet_img" name="pet_img">
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-primary">등록하기</button>
            </div>

        </form>
    </div>
</main>

<footer>
    <div class="inner">
        <div class="footer-logo">
            <a href="#">MY PET 동물병원</a>
        </div>
        <div class="footer-info">
            <p>주소: 부산광역시 OO구 OO로 123번길 45 | 대표: 김원장 | 사업자등록번호: 123-45-67890</p>
            <p>TEL: 051-123-4567 | E-MAIL: contact@mypet.com</p>
            <p class="copyright">&copy; 2025 MY PET Animal Hospital. All Rights Reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>
