<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MY PET 동물병원</title>

    <!-- 🔥 Boot 정적 리소스 -->
    <link rel="stylesheet" href="/css/mainpage.css">
    <link rel="stylesheet" href="/css/jquery.bxslider.css">
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
        <ul class="slide_gallery">
            <li><img src="/img/main.png"></li>
            <li><img src="/img/main2.png"></li>
            <li><img src="/img/main3.png"></li>
        </ul>
    </div>

    <div class="main-text">
        <h1>소중한 반려동물의 평생 주치의</h1>
        <p>
            MY PET 동물병원은 최상의 의료 서비스로<br>
            보호자의 마음까지 치료합니다.
        </p>
    </div>
</figure>

<section class="features">
    <div class="inner">
        <h1>MY PET 동물병원의 약속</h1>

        <div class="wrap">
            <article>
                <img src="/img/1.png">
                <h2>최고의 의료진과 최신 장비</h2>
                <p>대학병원급 최신 장비를 통해 정확한 진단을 내리고, 반려동물의 건강을 약속합니다.</p>
            </article>

            <article>
                <img src="/img/2.png">
                <h2>보호자가 신뢰하는 병원</h2>
                <p>과잉 진료 없이 정직하게, 보호자가 가장 신뢰할 수 있는 선택이 되겠습니다.</p>
            </article>

            <article>
                <img src="/img/3.png">
                <h2>정확한 진단, 정직한 진료</h2>
                <p>오랜 임상 경험과 데이터를 바탕으로 반려동물 의료의 새로운 표준을 제시합니다.</p>
            </article>

            <article>
                <img src="/img/4.png">
                <h2>최적의 치료 솔루션</h2>
                <p>풍부한 임상 경험을 바탕으로 아이에게 가장 안전하고 효과적인 치료법을 제공합니다.</p>
            </article>
        </div>
    </div>
</section>

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

<!-- 🔥 Boot 정적 자바스크립트 경로 -->
<script src="/js/jquery.js"></script>
<script src="/js/jquery.bxslider.js"></script>

<script>
    $(document).ready(function(){
        $('.slide_gallery').bxSlider({
            auto: true,
            pause: 5000
        });
    });
</script>

</body>
</html>
