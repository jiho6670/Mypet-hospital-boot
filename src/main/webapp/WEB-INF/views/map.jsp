<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MY PET 동물병원</title>

    <!-- 🔥 Boot 표준 정적 리소스 경로 -->
    <link rel="stylesheet" href="/css/mainpage.css">
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

<figure>
    <div class="pic">
        <img src="/img/map.png">
    </div>

    <div class="main-text">
        <h1>오시는 길</h1>
        <p>
            MY PET 동물병원으로 오시는 길을 안내해드립니다.
        </p>
    </div>
</figure>

<div class="location-container">
    <div class="info">
        <p>
            <h2>MY PET 동물병원 오시는 길</h2>
            Seoul, Gangnam District, 강남구 테헤란로14길 6
        </p>

        <p>
            <h2>대중교통 이용</h2>
            지하철 | 서울 신분당선 강남역 1번 출구 도보 5분
        </p>

        <table class="info-table">
            <tr>
                <th colspan="2">진료시간</th>
            </tr>
            <tr>
                <th>월 - 금</th>
                <td>오전 9시 - 오후 7시</td>
            </tr>
            <tr>
                <th>주말</th>
                <td>오전 9시 - 오후 6시</td>
            </tr>
            <tr>
                <th>점심시간</th>
                <td>오후 12시 30분 - 오후 2시</td>
            </tr>
        </table>
    </div>

    <div class="map">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.378379236162!2d127.03290899999996!3d37.49899300000002"
                width="600" height="450" style="border:0;" allowfullscreen=""
                loading="lazy" referrerpolicy="no-referrer-when-downgrade">
        </iframe>
    </div>
</div>

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
