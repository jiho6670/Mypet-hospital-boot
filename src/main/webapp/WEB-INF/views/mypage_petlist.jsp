<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 펫 목록</title>

<!-- 🔥 Boot 정적 리소스 경로로 변경 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/petlist_style.css">

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

<main class="mypage-container">

    <aside class="sidemenu">
        <h2>마이페이지 🐾</h2>
        <a href="/mypage_userinfo">내 정보</a>
        <a href="/mypage_petlist" class="active">펫 목록</a>
    </aside>

    <section class="content">
        <h2>펫 목록</h2>

        <c:if test="${not empty petList}">
            <div class="pet-grid">

                <c:forEach var="pet" items="${petList}">
                    <div class="pet-card clickable"
                         onclick="location.href='/mypage_petinfo?pet_no=${pet.pet_no}'">

                        <!-- 🔥 이미지 경로는 DB 값 그대로 사용 -->
                        <img src="${pet.pet_img}" alt="펫 이미지" class="pet-img">

                        <h3>${pet.pet_name}</h3>
                        <p>종: ${pet.pet_species}</p>
                        <p>품종: ${pet.pet_breed}</p>
                        <p>성별: ${pet.pet_gender}</p>
                        <p>생일: ${pet.pet_birthday}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty petList}">
            <p style="margin-top: 20px;">등록된 펫이 없습니다.</p>
        </c:if>

        <div class="add-pet-box">
            <button class="add-pet-btn" onclick="location.href='/pet_add'">펫 등록</button>
        </div>

    </section>

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
