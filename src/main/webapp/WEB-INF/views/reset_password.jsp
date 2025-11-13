<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정 - MY PET 동물병원</title>

    <!-- 최소 수정: 정적 리소스 경로 교체 -->
    <link rel="stylesheet" href="/css/mainpage.css">
    <link rel="stylesheet" href="/css/reset_password.css">

    <script>
    function validateForm() {
        var newPassword = document.getElementById("user_pwd").value;
        var confirmPassword = document.getElementById("user_pwd_confirm").value;

        if (newPassword === "" || confirmPassword === "") {
            alert("비밀번호를 입력해 주세요.");
            return false;
        }
        if (newPassword !== confirmPassword) {
            alert("입력한 비밀번호가 서로 일치하지 않습니다.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>

<div class="floating-icons">
    <a href="https://www.instagram.com/khieiorkr/" target="_blank">
        <img src="https://img.icons8.com/fluent/48/000000/instagram-new.png"/>
    </a>
    <a href="" target="_blank">
        <img src="https://img.icons8.com/color/48/BH0XTdh770dG/kakaotalk.png"/>
    </a>
    <a href="<c:url value='/map' />" target="_blank">
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
    <div class="reset-container">
        <h2>비밀번호 재설정 🔒</h2>
        <p>새로운 비밀번호를 입력해 주세요.</p>

        <!-- 최소 수정: action 경로 절대경로화 -->
        <form action="/updatePassword" method="post" onsubmit="return validateForm();">

            <input type="hidden" name="user_id" value="${user_id}">

            <div class="input-group">
                <input type="password" id="user_pwd" name="user_pwd" placeholder="새 비밀번호" required>
            </div>
            <div class="input-group">
                <input type="password" id="user_pwd_confirm" name="user_pwd_confirm" placeholder="새 비밀번호 확인" required>
            </div>

            <button type="submit" class="submit-btn">변경하기</button>
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

<c:if test="${not empty message}">
<script>
    alert("${message}");
</script>
</c:if>

</body>
</html>
