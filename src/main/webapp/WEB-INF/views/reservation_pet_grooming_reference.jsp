<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미용 예약 조회 - MY PET 동물병원</title>

<!-- 최소 수정: 정적 리소스 경로 Spring Boot 방식 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/reservation.css">

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

<div class="wrap">
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
        <div class="check-form-container2">
            <h2 class="section-title">미용 예약 조회 결과</h2>

            <!-- 1. 조회 결과 있을 때 -->
            <c:if test="${not empty reservationList}">
                <div class="result-container">
                    <h3 class="result-title">총 ${reservationList.size()}건의 예약 내역이 조회되었습니다.</h3>
                    
                    <table class="result-table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>보호자</th>
                                <th>반려동물</th>
                                <th>예약 일시</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="res" items="${reservationList}" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td>${res.user_name}</td>
                                    <td>${res.pet_name}</td>
                                    <td>
                                        <fmt:formatDate 
                                            value="${res.res_date}" 
                                            pattern="yyyy 년 MM월 dd일 HH:mm" />
                                    </td>
                                    <td>
                                        <span class="status status-completed">${res.res_status}</span>
                                    </td>
                                    <td class="actions">
                                        <button class="btn btn-sm">변경</button>
                                        <button class="btn btn-sm btn-danger">취소</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- 2. 조회 결과 없을 때 -->
            <c:if test="${not empty errorMessage}">
                <div class="error-container">
                    <p class="error-message">${errorMessage}</p>
                    <button class="btn" onclick="history.back()">다시 조회하기</button>
                </div>
            </c:if>

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
</div>

</body>
</html>
