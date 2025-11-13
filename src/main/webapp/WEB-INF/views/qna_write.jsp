<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 최소 수정: 정적 리소스 경로만 Boot 방식으로 -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/qna_write.css">

<!-- 부트스트랩 / 서머노트는 CDN 그대로 유지 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">

</head>
<body>

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
            <li><a href="/reservation">진료예약</a></li>
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
    <div class="container">
        <h2 align="center" id="h22">Q&A</h2>
        <br>

        <form method="post" action="qna_write_ok">
            <table class="table">
                <tr>
                    <td width="80" id="center1">제목</td>
                    <td><input type="text" class="form-control" name="qna_title" required></td>
                </tr>
                <tr>
                    <td id="center2">첨부파일</td>
                    <td><input type="text" class="form-control" name="qna_file"></td>
                </tr>
            </table>

            <table id="table2">
                <tr class="content" align="left">
                    <td colspan="2">
                        <textarea id="summernote" name="qna_content"></textarea>
                    </td>
                </tr>
                <tr class="content2">
                    <td colspan="2" align="center">
                        <input type="submit" value="등록" class="btn-submit">
                        <button type="button" onclick="location.href='qna_page'" class="btn-cancel">취소</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</main>

<!-- JQuery / Bootstrap / Summernote -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

<script>
$(document).ready(function() {
    $('#summernote').summernote({
        height: 300,
        lang : 'ko-KR',
        placeholder: '내용을 입력하세요...',
        toolbar: [
            ['style', ['bold','italic','underline','clear']],
            ['font', ['fontname','fontsize','color']],
            ['para', ['ul','ol','paragraph']],
            ['insert', ['link','picture']],
            ['view', ['codeview']]
        ]
    });
});
</script>

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
