<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="max-w-5xl mx-auto mb-16 px-4">
    
    <!-- Tiêu đề Hồ Sơ -->
    <div class="mb-10 pb-4 border-b-4 border-black dark:border-white">
        <h1 class="text-5xl font-comic text-dark dark:text-white tracking-widest uppercase transform rotate-1"
            style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">
            HỒ SƠ VIP
        </h1>
        <p class="font-black text-gray-500 dark:text-gray-400 mt-2 uppercase">Lịch sử thu thập siêu phẩm của ${sessionScope.user.username}</p>
    </div>

    <div data-aos="zoom-in" class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark flex flex-col p-6 mb-8 transform -rotate-1 transition-colors animate-pulse-shadow">
        <h2 class="text-3xl font-comic text-dark dark:text-white border-b-4 border-black dark:border-white pb-3 mb-6 uppercase">THÔNG TIN TÀI KHOẢN</h2>
        <div class="flex flex-col md:flex-row gap-8 w-full">
            <div class="flex items-center gap-6 md:w-1/2">
                <div class="flex flex-col items-center gap-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.avatar}">
                            <div class="w-32 h-32 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark rounded-full overflow-hidden flex-shrink-0 bg-white">
                                <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" alt="Avatar" class="w-full h-full object-cover" />
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w-32 h-32 bg-secondary dark:bg-yellow-700 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark rounded-full flex items-center justify-center flex-shrink-0">
                                <img src="https://api.dicebear.com/7.x/bottts/svg?seed=${sessionScope.user.username}&backgroundColor=FFD166" class="w-full h-full rounded-full" alt="Avatar">
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <form action="${pageContext.request.contextPath}/UploadAvatarServlet" method="post" enctype="multipart/form-data" class="flex flex-col items-center">
                        <label class="cursor-pointer bg-white dark:bg-gray-700 text-dark dark:text-white border-2 border-black dark:border-white px-3 py-1 font-bold text-xs uppercase shadow-sm hover:bg-gray-100 dark:hover:bg-gray-600 transition-colors rounded">
                            Đổi Ảnh
                            <input type="file" name="avatarFile" accept="image/*" class="hidden" onchange="this.form.submit()" />
                        </label>
                    </form>
                </div>
                <div class="flex flex-col gap-2">
                    <div class="font-black text-2xl uppercase text-dark dark:text-white">Tài Khoản: <span class="text-primary">${sessionScope.user.username}</span></div>
                    <div class="font-bold text-gray-500 dark:text-gray-400 uppercase tracking-widest">
                        CẤP BẬC: 
                        <span class="bg-accent dark:bg-teal-700 text-dark dark:text-white border-2 border-black dark:border-white px-2 py-0.5 ml-1 shadow-comic dark:shadow-comic-dark text-sm">
                            ${sessionScope.user.role == 'ADMIN' ? 'TRÙM CUỐI (ADMIN)' : sessionScope.user.rankTier}
                        </span>
                    </div>
                </div>
            </div>
            
            <c:if test="${sessionScope.user.role != 'ADMIN'}">
            <!-- Khu vực Manga Coin & Tiến trình hạng -->
            <div class="md:w-1/2 border-t-4 border-black dark:border-white md:border-t-0 md:border-l-4 pt-6 md:pt-0 md:pl-8 flex flex-col justify-center">
                <div class="flex justify-between items-end mb-2">
                    <div class="font-black text-dark dark:text-white uppercase text-lg">Manga Coin: <span class="text-secondary text-2xl" style="-webkit-text-stroke: 1px black;">💰 ${sessionScope.user.mangaCoin}</span></div>
                </div>
                
                <c:set var="currentCoins" value="${sessionScope.user.mangaCoin}" />
                <c:set var="nextRank" value="HACHIMAN" />
                <c:set var="nextTarget" value="5000" />
                <c:set var="prevTarget" value="1000" />
                
                <c:choose>
                    <c:when test="${currentCoins < 100}">
                        <c:set var="nextRank" value="WIBU CHUẨN" />
                        <c:set var="nextTarget" value="100" />
                        <c:set var="prevTarget" value="0" />
                    </c:when>
                    <c:when test="${currentCoins < 1000}">
                        <c:set var="nextRank" value="WIBU CHÚA" />
                        <c:set var="nextTarget" value="1000" />
                        <c:set var="prevTarget" value="100" />
                    </c:when>
                    <c:when test="${currentCoins < 5000}">
                        <c:set var="nextRank" value="HACHIMAN" />
                        <c:set var="nextTarget" value="5000" />
                        <c:set var="prevTarget" value="1000" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="nextRank" value="MAX LEVEL" />
                        <c:set var="nextTarget" value="${currentCoins}" />
                        <c:set var="prevTarget" value="5000" />
                    </c:otherwise>
                </c:choose>
                
                <c:set var="progressPercent" value="${(currentCoins - prevTarget) * 100 / (nextTarget - prevTarget)}" />
                <c:if test="${progressPercent > 100}"><c:set var="progressPercent" value="100" /></c:if>
                <c:if test="${progressPercent < 0}"><c:set var="progressPercent" value="0" /></c:if>

                <div class="w-full h-6 bg-gray-200 dark:bg-gray-700 border-2 border-black dark:border-white shadow-comic-dark overflow-hidden relative">
                    <div class="h-full bg-primary transition-all duration-1000" style="width: ${progressPercent}%;"></div>
                </div>
                
                <c:choose>
                    <c:when test="${nextRank == 'MAX LEVEL'}">
                        <div class="font-bold text-xs text-gray-500 dark:text-gray-400 uppercase text-right mt-1">Đã đạt cảnh giới tối cao!</div>
                    </c:when>
                    <c:otherwise>
                        <div class="font-bold text-xs text-gray-500 dark:text-gray-400 uppercase text-right mt-1">Cần thêm ${nextTarget - currentCoins} coin để lên <span class="text-accent dark:text-teal-400">${nextRank}</span></div>
                    </c:otherwise>
                </c:choose>
            </div>
            </c:if>
        </div>
    </div>

    <!-- Hiển thị thông báo (nếu có) -->
    <c:if test="${not empty sessionScope.message}">
        <div class="bg-[#06D6A0] text-dark border-4 border-black p-4 mb-6 font-comic text-xl shadow-comic uppercase transform -rotate-1 text-center">
            ${sessionScope.message}
        </div>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="bg-primary text-white border-4 border-black p-4 mb-6 font-comic text-xl shadow-comic uppercase transform rotate-1 text-center">
            ${sessionScope.error}
        </div>
        <c:remove var="error" scope="session" />
    </c:if>

    <!-- Truyện Yêu Thích -->
    <h2 class="text-4xl font-comic text-dark dark:text-white tracking-wider uppercase mb-6" style="-webkit-text-stroke: 1px black;">BỘ SƯU TẬP YÊU THÍCH ❤️</h2>
    <c:choose>
        <c:when test="${empty favList}">
            <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-10 text-center shadow-comic dark:shadow-comic-dark transform -rotate-1 transition-colors">
                <h3 class="text-3xl font-comic text-gray-400 dark:text-gray-500 mb-4">CHƯA THẢ TIM TRUYỆN NÀO!</h3>
                <a href="${pageContext.request.contextPath}/customer" class="inline-block bg-accent dark:bg-teal-700 text-dark dark:text-white border-4 border-black dark:border-white px-6 py-3 font-comic text-2xl tracking-widest shadow-comic dark:shadow-comic-dark hover:-translate-y-1 hover:bg-white dark:hover:bg-gray-600 transition-all uppercase">
                    ĐI TÌM CHÂN ÁI!
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6 mb-12">
                <c:forEach items="${favList}" var="sach">
                    <div data-aos="fade-up" class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white rounded p-4 flex flex-col items-center shadow-comic dark:shadow-comic-dark transform hover:-translate-y-2 hover:-rotate-2 transition-all">
                        <a href="${pageContext.request.contextPath}/customer?action=detail&id=${sach.maSach}" class="w-full h-48 sm:h-56 overflow-hidden border-2 border-black dark:border-white mb-3 flex items-center justify-center bg-gray-100 dark:bg-gray-700">
                            <c:choose>
                                <c:when test="${not empty sach.hinhAnh}">
                                    <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}" class="w-full h-full object-cover">
                                </c:when>
                                <c:otherwise>
                                    <span class="font-comic text-gray-400">NO IMG</span>
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <a href="${pageContext.request.contextPath}/customer?action=detail&id=${sach.maSach}" class="font-black text-dark dark:text-white uppercase text-center line-clamp-2 hover:text-primary dark:hover:text-primary transition-colors mb-2">
                            ${sach.tenSach}
                        </a>
                        <div class="font-comic text-primary text-xl tracking-widest mt-auto" style="-webkit-text-stroke: 1px black;">
                            <fmt:formatNumber value="${sach.giaTien}" pattern="#,###" />đ
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Lịch sử Đơn Hàng -->
    <h2 class="text-4xl font-comic text-dark dark:text-white tracking-wider uppercase mt-12 mb-6" style="-webkit-text-stroke: 1px black;">LỊCH SỬ CHỐT ĐƠN</h2>
    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-10 text-center shadow-comic-lg dark:shadow-comic-lg-dark transform rotate-1 transition-colors mb-12">
        <p class="font-bold text-gray-500 dark:text-gray-400 mb-6 text-xl uppercase tracking-widest">Kiểm tra ngay các kho báu siêu phẩm đã đặt hàng!</p>
        <button onclick="document.getElementById('orderModal').classList.remove('hidden')" class="inline-block bg-primary dark:bg-red-800 text-white border-4 border-black dark:border-white px-8 py-4 font-comic text-2xl tracking-widest shadow-comic dark:shadow-comic-dark hover:-translate-y-1 hover:bg-dark transition-all uppercase transform -rotate-2">
            XEM LỊCH SỬ CHỐT ĐƠN 📋
        </button>
    </div>

    <!-- Modal Order History -->
    <div id="orderModal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-70">
        <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark w-full max-w-5xl max-h-[90vh] overflow-hidden flex flex-col relative animate-fade-in-up">
            <div class="p-4 border-b-4 border-black dark:border-white flex justify-between items-center bg-secondary dark:bg-yellow-600">
                <h2 class="text-3xl font-comic uppercase text-dark dark:text-white transform -rotate-1" style="-webkit-text-stroke: 1px black;">BẢNG LỊCH SỬ ĐƠN HÀNG</h2>
                <button onclick="document.getElementById('orderModal').classList.add('hidden')" class="text-4xl font-black text-dark dark:text-white hover:text-primary transition-colors">&times;</button>
            </div>
            <div class="p-4 overflow-y-auto">
                <table class="w-full text-center border-4 border-black dark:border-white bg-white dark:bg-gray-800">
                    <thead class="bg-gray-100 dark:bg-gray-700 border-b-4 border-black dark:border-white font-black uppercase text-sm text-dark dark:text-white">
                        <tr>
                            <th class="p-3 border-r-4 border-black dark:border-white">Mã Đơn</th>
                            <th class="p-3 border-r-4 border-black dark:border-white">Ngày Đặt</th>
                            <th class="p-3 border-r-4 border-black dark:border-white">Sản Phẩm</th>
                            <th class="p-3 border-r-4 border-black dark:border-white">Tổng Tiền</th>
                            <th class="p-3">Trạng Thái</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y-4 divide-black dark:divide-white font-bold text-dark dark:text-gray-200">
                        <c:choose>
                            <c:when test="${empty listOrders}">
                                <tr><td colspan="5" class="p-6 text-xl font-comic text-gray-500">CHƯA TỪNG MÚC CUỐN NÀO!</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${listOrders}" var="order">
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                        <td class="p-3 border-r-4 border-black dark:border-white text-primary text-lg">#${order.id}</td>
                                        <td class="p-3 border-r-4 border-black dark:border-white"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td class="p-3 border-r-4 border-black dark:border-white text-left text-sm max-w-xs">
                                            <div class="flex flex-col gap-1">
                                                <c:forEach items="${order.details}" var="detail">
                                                    <div class="line-clamp-1" title="${detail.sach.tenSach}">- ${detail.sach.tenSach} (x${detail.quantity})</div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td class="p-3 border-r-4 border-black dark:border-white text-xl font-comic tracking-widest"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />đ</td>
                                        <td class="p-3">
                                            <div class="flex flex-col items-center justify-center gap-2">
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="bg-secondary dark:bg-yellow-600 px-3 py-1 border-2 border-black dark:border-white uppercase text-xs">CHỜ DUYỆT</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                        <span class="bg-accent dark:bg-teal-700 px-3 py-1 border-2 border-black dark:border-white uppercase text-xs w-full">ĐANG GIAO</span>
                                                        <a href="${pageContext.request.contextPath}/CustomerConfirmOrderServlet?id=${order.id}" onclick="return confirm('Bạn xác nhận đã nhận được truyện an toàn?');" class="bg-[#06D6A0] hover:bg-green-400 dark:bg-[#05b586] px-3 py-1 border-2 border-black dark:border-white uppercase text-xs w-full shadow-comic-sm hover:-translate-y-0.5 transition-all">ĐÃ NHẬN HÀNG</a>
                                                    </c:when>
                                                    <c:when test="${order.status == 'COMPLETED'}">
                                                        <span class="bg-[#06D6A0] dark:bg-[#05b586] px-3 py-1 border-2 border-black dark:border-white uppercase text-xs">ĐÃ NHẬN</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="bg-primary dark:bg-red-800 text-white px-3 py-1 border-2 border-black dark:border-white uppercase text-xs">ĐÃ HỦY</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
