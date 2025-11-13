<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항 수정</title>

  <!-- ⭐ 정적 리소스 Spring Boot 스타일 적용 -->
  <link rel="stylesheet" href="/css/mainpage.css">
  <link rel="stylesheet" href="/css/notice_modify.css">

  <!-- Bootstrap & Summernote -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

  <script>
    $(document).ready(function () {
      $('#summernote').summernote({
        height: 300,
        lang: 'ko-KR',
        placeholder: '내용을 입력하세요...',
        toolbar: [
          ['style', ['bold', 'italic', 'underline', 'clear']],
          ['font', ['fontname', 'fontsize', 'color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['insert', ['link', 'picture']],
          ['view', ['codeview']]
        ],
        fontNames: ['맑은 고딕', '굴림', '돋움', 'Arial', 'Courier New'],
        fontSizes: ['10', '12', '14', '16', '18', '20']
      });
    });
  </script>

</head>
<body>

<header>
  <div class="inner">
    <h1>
      <a href="<c:url value='/mainpage' />">
        <img src="/img/mypet.png" alt="로고"> MY PET 동물병원
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

<main>
  <div class="container">
    <h3 class="page-title">공지사항 수정</h3>

    <form method="post" action="notices_modify">
      <input type="hidden" name="notice_no" value="${dto.notice_no}">

      <table class="table">
        <tr>
          <td class="label-cell">제목</td>
          <td><input type="text" class="form-control" name="notice_title" value="${dto.notice_title}" required></td>
        </tr>

        <tr>
          <td class="label-cell">첨부파일</td>
          <td><input type="text" class="form-control" name="notice_file" value="${dto.notice_file}"></td>
        </tr>

        <tr>
          <td colspan="2">
            <textarea id="summernote" name="notice_content">${dto.notice_content}</textarea>
          </td>
        </tr>

        <tr>
          <td colspan="2">
            <div class="btn-box">
              <input type="submit" value="수정" class="btn-submit">
              <button type="button" onclick="location.href='notices_list'" class="btn-cancel">취소</button>
            </div>
          </td>
        </tr>
      </table>
    </form>
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

</body>
</html>
