<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 최소 수정: resources → /css, /img -->
<link rel="stylesheet" href="/css/mainpage.css">
<link rel="stylesheet" href="/css/qna_content_view.css">

</head>
<body>
        <header>
        <div class="inner">
            <h1>
                <a href="<c:url value='/mainpage' />"> 
                    <img src="/img/mypet.png" alt="MY PET 로고">
                    MY PET 동물병원
                </a>
            </h1>
            <nav>
                <ul id="gnb">
                    <li><a href="<c:url value='/hospital_info' />">병원소개</a></li>
                    <li class="dropdown-parent"><a href="#">게시판</a>
                        <ul class="submenu">
                            <li><a href="notices_list">공지사항</a></li>
                            <li><a href="#">자유게시판</a></li>
                            <li><a href="qna_page">Q&A</a></li>
                        </ul></li>
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
            </nav>
        </div>
    </header>

    <main>
        
        <section class="notice-view">
            <table border="1">
                <tr class="title">
                    <td>제목</td>
                    <td colspan="6">${dto.notice_title}</td>
                </tr>
                <tr class="writer_tr">
                    <td class="num">번호</td>
                    <td class="write_td">${dto.qna_no}</td>
                    <td class="answered">답변여부</td>
                    <td class="answered2">${dto.is_answered}</td>
                    <td class="date">작성일</td>
                    <td colspan="2" class="write_td">${dto.created_date}</td>
                </tr>
                <tr>
                    <td class="file">첨부파일</td>
                    <td colspan="6" class="file2"></td>
                </tr>
                <td colspan="7">
                    <div class="qna-content">${dto.qna_content}</div>
                </td>
                
                <tr>                   
                    <td colspan="7" class="answer-title">
                        답변
                    </td>
                </tr>
                <tr class="writer_tr">                    
                    <td class="date">        
                        작성자
                    </td>
                    <td>관리자</td>
                    <td class="date">
                        작성일
                    </td>
                    <td colspan="4">${dto.created_date}</td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div class="qna-content">${dto.reply_content}</div>
                    </td> 
                </tr>
            </table>

            <!-- 버튼 영역 -->
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <div class="btn-box">
              <button type="submit" class="btn-list">답변하기</button>
            </div>      
        </c:if>                
            <c:if test="${sessionScope.role == 'ADMIN'}">
                  <div class="btn-box">
                      <button type="button"
                        onclick="location.href='<c:url value="/notices_modify_view?notice_no=${dto.notice_no}"/>'"
                        class="btn-submit">
                        수정
                      </button>
                    <form action="<c:url value='/notices_delete' />" method="post" style="display:inline;">
                      <input type="hidden" name="notice_no" value="${dto.qna_no}" />
                      <button type="submit" class="btn-delete">삭제</button>
                    </form>
                  </div>
                </c:if>
            <div class="btn-box">
              <button type="button" 
                      onclick="location.href='qna_page'" 
                      class="btn-list">
                        목록보기
              </button>
             
            </div>
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
                <p class="copyright">&copy; 2025 MY PET Animal Hospital. All
                    Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
