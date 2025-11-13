<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정 - MY PET 동물병원</title>

<!-- 🔥 Boot 정적 리소스 경로 적용 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/mypage_userinfo_edit.css">

</head>
<body>

<div class="floating-icons">
    <a href="https://www.instagram.com/khieiorkr/" target="_blank" class="icon-instagram">
        <img src="https://img.icons8.com/fluent/48/000000/instagram-new.png" alt="인스타그램"/>
    </a>
    <a href="https://www.youtube.com/@KH_academy" target="_blank" class="icon-youtube">
        <img src="https://img.icons8.com/color/48/youtube-play.png" alt="유튜브"/>
    </a>
    <a href="/map" class="icon-map">
        <img src="https://img.icons8.com/color/48/000000/map-marker.png" alt="오시는길"/>
    </a>
</div>

<header>
    <div class="inner">
        <h1>
            <a href="/mainpage">
                <img src="/img/mypet.png">MY PET 동물병원
            </a>
        </h1>

        <ul id="gnb">
            <li><a href="/hospital_info">병원소개</a></li>

            <li class="dropdown-parent"><a href="#">게시판</a>
                <ul class="submenu">
                    <li><a href="/notices_list">공지사항</a></li>
                    <li><a href="#">자유게시판</a></li>
                    <li><a href="/qna_page">Q&A</a></li>
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

<main>
    <div class="edit-container">
        <h2>내 정보 수정 🐾</h2>
        <p>변경하실 정보를 입력해주세요.</p>

        <form action="/mypage_userinfo_edit_ok" method="post" enctype="multipart/form-data">

            <!-- 아이디 (읽기 전용) -->
            <div class="input-group">
                <input type="text" name="user_id" value="${loginUser.user_id}" readonly>
            </div>

            <!-- 비밀번호 -->
            <div class="input-group">
                <input type="password" name="user_pwd" placeholder="새 비밀번호 (변경 시 입력)">
            </div>
            <div class="input-group">
                <input type="password" name="user_pwd_confirm" placeholder="새 비밀번호 확인">
            </div>

            <!-- 연락처 -->
            <div class="input-group">
                <input type="text" name="user_phone" value="${loginUser.user_phone}" required>
            </div>

            <!-- 이메일 -->
            <div class="input-group">
                <input type="email" name="user_email" value="${loginUser.user_email}" required>
            </div>

            <!-- 주소 -->
            <div class="input-group address">
                <div class="address-group">
                    <input type="text" id="postcode" placeholder="우편번호">
                    <button type="button" class="btn-find-address" onclick="execDaumPostcode()">주소 찾기</button>
                </div>

                <input type="text" id="address" name="user_addr" placeholder="기본 주소"
                       value="${loginUser.user_addr}">

                <input type="text" id="detailAddress" name="user_addr_detail"
                       placeholder="상세 주소">
            </div>

            <!-- 이미지 업로드 -->
            <div class="input-group">
                <label for="user_img" class="file-label">프로필 사진 변경</label>
                <input type="file" id="user_img" name="user_img">
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-primary">수정 완료</button>
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
            <p class="copyright">
                &copy; 2025 MY PET Animal Hospital. All Rights Reserved.
            </p>
        </div>
    </div>
</footer>

</body>
</html>
