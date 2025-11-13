<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세보기</title>

  <!-- ⭐ 정적 리소스 경로 교체 -->
  <link rel="stylesheet" href="/css/mainpage.css">
  <link rel="stylesheet" href="/css/notices_content_view.css">

  <script>
    window.addEventListener('DOMContentLoaded', () => {
      const textarea = document.querySelector('textarea[readonly]');
      if (textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
      }
    });
  </script>
</head>
<body>

<div class="floating-icons">
  <a href="https://www.instagram.com/khieiorkr/" target="_blank" class="icon-instagram">
      <img src="https://img.icons8.com/fluent/48/000000/instagram-new.png" />
  </a>

  <a href="https://www.youtube.com/@KH_academy" target="_blank" class="icon-youtube">
      <img src="https://img.icons8.com/color/48/youtube-play.png" />
  </a>

  <a href="/map" class="icon-map">
      <img src="https://img.icons8.com/color/48/000000/map-marker.png" />
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
  <section class="notice-view">
    <table>
      <tr class="title">
        <td>제목</td>
        <td colspan="6">${dto.notice_title}</td>
      </tr>
      <tr class="writer_tr">
        <td class="writer">작성자 : 관리자</td>
        <td class="date">작성일</td>
        <td>${dto.created_date}</td>
        <td class="num">번호</td>
        <td>${dto.notice_no}</td>
        <td class="viewnum">조회수</td>
        <td>${dto.view_count}</td>
      </tr>
      <tr>
        <td class="file">첨부파일</td>
        <td colspan="6" class="file2">
          <c:choose>
            <c:when test="${not empty dto.notice_file}">
              <a href="/download?file=${dto.notice_file}">${dto.notice_file}</a>
            </c:when>
            <c:otherwise>첨부파일 없음</c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <td colspan="7">
          <div class="notice-content">${dto.notice_content}</div>
        </td>
      </tr>
    </table>

    <!-- 관리자 전용 버튼 -->
    <c:if test="${sessionScope.role == 'ADMIN'}">
      <div class="btn-box">
        <button type="button"
                onclick="location.href='/notices_modify_view?notice_no=${dto.notice_no}'"
                class="btn-submit">수정</button>

        <form action="/notices_delete" method="post" style="display:inline;">
          <input type="hidden" name="notice_no" value="${dto.notice_no}" />
          <button type="submit" class="btn-delete">삭제</button>
        </form>

        <button type="button" onclick="location.href='/notices_list'" class="btn-list">목록보기</button>
      </div>
    </c:if>
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
      <p class="copyright">&copy; 2025 MY PET Animal Hospital. All Rights Reserved.</p>
    </div>
  </div>
</footer>

</body>
</html>
