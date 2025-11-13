<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 안내 - MY PET 동물병원</title>

<!-- 최소 수정: 정적 리소스 경로 변경 -->
<link rel="stylesheet" href="/css/reservation.css">

</head>
<body>

<div class="floating-icons">
    <a href="https://www.instagram.com/khieiorkr/" target="_blank" class="icon-instagram">
        <img src="https://img.icons8.com/fluent/48/000000/instagram-new.png"/>
    </a>
    <a href="https://www.youtube.com/@KH_academy" target="_blank" class="icon-youtube">
        <img src="https://img.icons8.com/color/48/youtube-play.png"/>
    </a>
    <a href="<c:url value='/map' />" class="icon-map">
        <img src="https://img.icons8.com/color/48/000000/map-marker.png"/>
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

<main class="main-container">
    <table>
        <tr>
            <td>
                <h3>예약 가능 일자</h3><br>
                <hr>
                <div>평일 : 오전 9시 ~ 오후 6시</div>
                <div>주말 / 공휴일 : 오전 9시 ~ 오후 3시</div>
            </td>

            <td>
                <button class="reserve-btn" onclick="location.href='reservation_pet_medical'">
                    진료 예약
                </button><br><br>

                <button class="reserve-btn" onclick="location.href='reservation_pet_medical_check'">
                    예약 조회
                </button>
            </td>

            <td>
                <button class="reserve-btn" onclick="location.href='reservation_pet_grooming'">
                    미용 예약
                </button><br><br>

                <button class="reserve-btn" onclick="location.href='reservation_pet_grooming_check'">
                    예약 조회
                </button>
            </td>
        </tr>
    </table>
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
