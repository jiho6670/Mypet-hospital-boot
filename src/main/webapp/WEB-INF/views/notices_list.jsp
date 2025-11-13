<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>

  <!-- ⭐ 정적 리소스 경로 Spring Boot 표준 적용 -->
  <link rel="stylesheet" href="/css/mainpage.css">
  <link rel="stylesheet" href="/css/notices_list.css">
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

          <li class="dropdown-parent">
            <a href="#">게시판</a>
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
  <h2 class="notice-title">공지사항</h2>

  <table class="table">
    <thead>
      <tr class="column">
        <th id="number">번호</th>
        <th>제목</th>
        <th id="writer">작성자</th>
        <th id="date">작성일</th>
        <th id="count">조회수</th>
      </tr>
    </thead>

    <tbody>
      <c:forEach var="dto" items="${notices}">
        <tr>
          <td>${dto.notice_no}</td>
          <td class="title">
            <a href="/notices_view?notice_no=${dto.notice_no}">
              <c:if test="${dto.is_fixed == 'Y'}">📌 </c:if>
              <c:out value="${dto.notice_title}" />
            </a>
          </td>
          <td>관리자</td>
          <td><fmt:formatDate value="${dto.created_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
          <td>${dto.view_count}</td>
        </tr>
      </c:forEach>

      <c:if test="${sessionScope.role == 'ADMIN'}">
        <tr class="divider_tr"><td colspan="5"></td></tr>
        <tr class="button_tr">
          <td colspan="5">
            <form action="/notices_write_view" method="get">
              <button type="submit" class="button">글쓰기</button>
            </form>
          </td>
        </tr>
      </c:if>
    </tbody>
  </table>

  <!-- 페이지 네비게이션 -->
  <div class="pagination">
    <c:if test="${currentPage > 1}">
      <a href="/notices_list?page=${currentPage - 1}" class="page-btn">이전</a>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPage}">
      <c:choose>
        <c:when test="${i == currentPage}">
          <span class="page-btn active">${i}</span>
        </c:when>
        <c:otherwise>
          <a href="/notices_list?page=${i}" class="page-btn">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:if test="${currentPage < totalPage}">
      <a href="/notices_list?page=${currentPage + 1}" class="page-btn">다음</a>
    </c:if>
  </div>
</main>

<footer>
  <div class="inner">
    <div class="footer-logo">
      <a href="/mainpage">MY PET 동물병원</a>
    </div>

    <div class="footer-info">
      <p>주소: 부산광역시 OO구 OO로 123번길 45 | 대표: 김원장</p>
      <p>TEL: 051-123-4567 | E-MAIL: contact@mypet.com</p>
      <p class="copyright">
        &copy; 2025 MY PET Animal Hospital. All Rights Reserved.
      </p>
    </div>
  </div>
</footer>

</body>
</html>
