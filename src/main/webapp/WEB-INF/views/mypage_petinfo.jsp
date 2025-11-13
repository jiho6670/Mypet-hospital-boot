<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 펫 상세정보</title>

<!-- 🔥 정적 리소스 경로 Boot 스타일로 변경 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/petinfo_style.css">

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
        <h2>펫 상세정보</h2>

        <div class="pet-detail-box">

            <!-- 🔥 이미지 경로 자체는 DB에 저장된 그대로 사용 -->
            <img src="${petInfo.pet_img}" 
                 alt="${petInfo.pet_name}" 
                 class="pet-profile-img"/>

            <table class="pet-detail-table">
                <tr>
                    <th>이름</th>
                    <td>${petInfo.pet_name}</td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td>${petInfo.pet_age}세</td>
                </tr>
                <tr>
                    <th>생일</th>
                    <td>${petInfo.pet_birthday}</td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td>${petInfo.pet_gender}</td>
                </tr>
                <tr>
                    <th>종</th>
                    <td>${petInfo.pet_species}</td>
                </tr>
                <tr>
                    <th>품종</th>
                    <td>${petInfo.pet_breed}</td>
                </tr>

                <tr>
                    <th>중성화 여부</th>
                    <td>
                        <c:choose>
                            <c:when test="${petInfo.pet_neutered eq 'Y'}">완료</c:when>
                            <c:otherwise>미완료</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>칩 등록 여부</th>
                    <td>
                        <c:choose>
                            <c:when test="${petInfo.pet_haschip eq 'Y'}">
                                있음 
                                <c:if test="${not empty petInfo.pet_chip_regdate}">
                                    (${petInfo.pet_chip_regdate})
                                </c:if>
                            </c:when>
                            <c:otherwise>없음</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>등록일</th>
                    <td>${petInfo.pet_regdate}</td>
                </tr>
            </table>
        </div>

        <div class="edit-pet-box">
            <button class="edit-pet-btn"
                onclick="location.href='/mypage_petinfo_edit?pet_no=${petInfo.pet_no}'">
                펫 정보 수정
            </button>
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
