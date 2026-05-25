<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


            <div data-aos="fade-down" class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
                <div>
                    <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1"
                        style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">DUYỆT ĐÁNH GIÁ</h1>
                    <p class="font-black text-gray-500 mt-2 uppercase">Phê duyệt hoặc từ chối đánh giá từ người dùng</p>
                </div>
            </div>

            <!-- Table -->
            <div data-aos="zoom-in" class="bg-white border-4 border-black shadow-comic-lg mb-8">
                <div>
                    <table class="w-full text-center">
                        <thead class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
                            <tr>
                                <th class="px-6 py-4 border-r-4 border-black w-1/6">NGƯỜI DÙNG</th>
                                <th class="px-6 py-4 border-r-4 border-black w-1/6">MÃ TRUYỆN</th>
                                <th class="px-6 py-4 border-r-4 border-black w-1/6">CHẤM ĐIỂM</th>
                                <th class="px-6 py-4 border-r-4 border-black w-2/6">NỘI DUNG</th>
                                <th class="px-6 py-4 text-center w-1/6">HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y-4 divide-black font-black text-sm">
                            <c:choose>
                                <c:when test="${empty pendingReviews}">
                                    <tr>
                                        <td colspan="5" class="px-6 py-12 text-center text-gray-500 font-comic text-2xl">
                                            HIỆN TẠI KHÔNG CÓ ĐÁNH GIÁ NÀO CẦN DUYỆT!
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${pendingReviews}" var="review" varStatus="status">
                                        <tr data-aos="fade-up" data-aos-delay="${status.index * 50}" class="hover:bg-gray-100 transition-colors">
                                            <td class="px-6 py-4 border-r-4 border-black text-dark font-bold uppercase">${review.username}</td>
                                            <td class="px-6 py-4 border-r-4 border-black text-gray-500 font-bold uppercase">#${review.maSach}</td>
                                            <td class="px-6 py-4 border-r-4 border-black text-primary text-xl font-comic tracking-widest">
                                                <c:choose>
                                                    <c:when test="${review.rating == 5}">🔥 Siêu phẩm</c:when>
                                                    <c:when test="${review.rating == 4}">😭 Cảm động</c:when>
                                                    <c:otherwise>🤣 Hài hước</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 border-r-4 border-black text-left text-gray-700 italic">
                                                "${review.comment}"
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <form action="${pageContext.request.contextPath}/AdminReviewsServlet" method="POST" class="flex flex-col gap-2">
                                                    <input type="hidden" name="reviewId" value="${review.maReview}">
                                                    <button type="submit" name="subAction" value="approve"
                                                            class="bg-[#06D6A0] border-2 border-black px-3 py-2 shadow-comic hover:-translate-y-1 transition text-dark font-bold uppercase text-xs">DUYỆT ✅</button>
                                                    <button type="submit" name="subAction" value="reject"
                                                            onclick="return confirm('Bạn có chắc muốn xóa đánh giá này?');"
                                                            class="bg-primary text-white border-2 border-black px-3 py-2 shadow-comic hover:-translate-y-1 transition font-bold uppercase text-xs">TỪ CHỐI ❌</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
