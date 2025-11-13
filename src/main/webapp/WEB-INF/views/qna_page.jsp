<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 최소 수정: resources → /css, /img -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/qna_page.css">

</head>
<body>
    <header>
        <div class="inner">
            <h1>
                <a href="<c:url value='/mainpage'/>">
                    <img src="/img/mypet.png">
                    MY PET 동물병원
                </a>
            </h1>
            <ul id="gnb">
                <li><a href="<c:url value='/hospital_info' />">병원소개</a></li>
                <li class="dropdown-parent"><a href="#">게시판</a>
                    <ul class="submenu">
                        <li><a href="<c:url value='/notices_list'/>">공지사항</a></li>
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

    <!--   fqn 추가 -->

    <div align="center">
        <table>
            <br><br><br>
            <caption>
                <h2 class="qna_title">자주 묻는 질문</h2>
                <br><br>
            </caption>
            <tr>
                <td>
                    <div>
                        <details id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
                <td>
                    <div>
                        <details style="width: 300px;" id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
                <td>
                    <div>
                        <details style="width: 300px;" id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <details style="width: 300px;" id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
                <td>
                    <div>
                        <details style="width: 300px;" id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
                <td>
                    <div>
                        <details style="width: 300px;" id="det">
                            <summary id="sum">질문</summary>
                            <p id="p">내용</p>
                        </details>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <!--   qna 목록 -->

    <main>
        <br><br>
        <h2 id="top" class="qna_title">(질문사항)Q&A</h2>
        <br><br>
        <div class="div">
            <table class="table">
                <tr class="column">
                    <th width="90" id="number">번호</th>
                    <th width="600" id="title">제목</th>
                    <th id="answered">답변여부</th>
                    <th id="date">작성일</th>
                </tr>
                <c:forEach var="dto" items="${dd}">
                    <tr>
                        <td id="number">${dto.qna_no}</td>
                        <td id="title">
                            <a href="qna_view?qna_no=${dto.qna_no}">
                                ${dto.qna_title}
                            </a>
                        </td>
                        <td id="answered">${dto.is_answered}</td>
                        <td id="date">${dto.created_date}</td>
                    </tr>
                </c:forEach>

                <tr class="button_tr">
                    <td colspan="5">
                        <a href="<c:url value='/qna_write'/>" class="button">질문작성</a>
                    </td>
                </tr>
            </table>
        </div>

        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <c:if test="${totalPage > 1}">
                <c:if test="${currentPage > 1}">
                    <a href="qna_page?page=${currentPage - 1}" class="page-btn">이전</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <sapn class="page-btn active">${i}</sapn>
                        </c:when>
                        <c:otherwise>
                            <a href="qna_page?page=${i}" class="page-btn">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPage}">
                    <a href="qna_page?page=${currentPage + 1}" class="page-btn">다음</a>
                </c:if>
            </c:if>
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
                <p class="copyright">&copy; 2025 MY PET Animal Hospital. All
                    Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
