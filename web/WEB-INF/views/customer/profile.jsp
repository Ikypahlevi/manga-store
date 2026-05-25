<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

    <!-- Lịch sử Đơn Hàng -->
    <h2 class="text-4xl font-comic text-dark dark:text-white tracking-wider uppercase mb-6" style="-webkit-text-stroke: 1px black;">LỊCH SỬ CHỐT ĐƠN</h2>

    <c:choose>
        <c:when test="${empty listOrders}">
            <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-10 text-center shadow-comic dark:shadow-comic-dark transform rotate-1 transition-colors">
                <h3 class="text-3xl font-comic text-gray-400 dark:text-gray-500 mb-4">CHƯA TỪNG MÚC CUỐN NÀO!</h3>
                <a href="${pageContext.request.contextPath}/customer" class="inline-block bg-primary dark:bg-red-800 text-white border-4 border-black dark:border-white px-6 py-3 font-comic text-2xl tracking-widest shadow-comic dark:shadow-comic-dark hover:-translate-y-1 hover:bg-dark transition-all uppercase">
                    ĐI HỐT TRUYỆN NGAY!
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="flex flex-col gap-8">
                <c:forEach items="${listOrders}" var="order" varStatus="status">
                    <div data-aos="fade-up" data-aos-delay="${status.index * 100}" class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark overflow-hidden transition-colors">
                        
                        <!-- Header Đơn Hàng -->
                        <div class="bg-gray-100 dark:bg-gray-700 border-b-4 border-black dark:border-white p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
                            <div class="flex flex-col gap-1">
                                <div class="font-black text-dark dark:text-white text-lg uppercase">
                                    Mã Đơn: <span class="text-primary dark:text-red-400">#${order.id}</span>
                                </div>
                                <div class="font-bold text-gray-500 dark:text-gray-400 text-sm">
                                    Ngày chốt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                            </div>
                            
                            <div class="flex items-center gap-4">
                                <div class="text-right">
                                    <div class="font-black text-xs text-gray-500 dark:text-gray-400 uppercase">Tổng tiền</div>
                                    <div class="font-comic text-2xl text-dark dark:text-white" style="-webkit-text-stroke: 1px black;">
                                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />đ
                                    </div>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="bg-secondary dark:bg-yellow-600 border-2 border-black dark:border-white px-3 py-1.5 text-dark dark:text-white shadow-comic dark:shadow-comic-dark font-black uppercase text-sm block transform rotate-2">CHỜ DUYỆT</span>
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPING'}">
                                            <div class="flex flex-col gap-2 items-end">
                                                <span class="bg-accent dark:bg-teal-700 border-2 border-black dark:border-white px-3 py-1.5 text-dark dark:text-white shadow-comic dark:shadow-comic-dark font-black uppercase text-sm block transform -rotate-1 w-full text-center">ĐANG GIAO</span>
                                                <a href="${pageContext.request.contextPath}/CustomerConfirmOrderServlet?id=${order.id}" 
                                                   onclick="return confirm('Bạn xác nhận đã nhận được truyện an toàn?');"
                                                   class="bg-[#06D6A0] hover:bg-green-400 dark:bg-[#05b586] border-2 border-black dark:border-white px-3 py-1.5 text-dark dark:text-white shadow-comic dark:shadow-comic-dark hover:-translate-y-1 transition-all font-black uppercase text-xs block w-full text-center">
                                                    ĐÃ NHẬN HÀNG
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">
                                            <span class="bg-[#06D6A0] dark:bg-[#05b586] border-2 border-black dark:border-white px-3 py-1.5 text-dark dark:text-white shadow-comic dark:shadow-comic-dark font-black uppercase text-sm block">ĐÃ NHẬN</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-primary dark:bg-red-800 text-white border-2 border-black dark:border-white px-3 py-1.5 shadow-comic dark:shadow-comic-dark font-black uppercase text-sm block transform rotate-1">ĐÃ HỦY</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Chi Tiết Truyện Đã Đặt -->
                        <div class="p-4 bg-white dark:bg-gray-800 flex flex-col gap-3">
                            <c:forEach items="${order.details}" var="detail">
                                <div class="flex items-center justify-between border-b-2 border-gray-200 dark:border-gray-600 pb-3 last:border-b-0 last:pb-0">
                                    <div class="flex items-center gap-3 w-2/3">
                                        <div class="w-12 h-16 bg-gray-200 dark:bg-gray-600 border-2 border-black dark:border-white overflow-hidden flex-shrink-0 flex justify-center items-center font-comic text-[10px] text-gray-500 dark:text-gray-300">
                                            <c:choose>
                                                <c:when test="${not empty detail.sach.hinhAnh}">
                                                    <img src="${pageContext.request.contextPath}/img/${detail.sach.hinhAnh}" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>NO IMG</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex flex-col">
                                            <a href="${pageContext.request.contextPath}/customer?action=detail&id=${detail.maSach}" class="font-black text-dark dark:text-white uppercase hover:text-primary dark:hover:text-primary transition-colors line-clamp-1">
                                                ${detail.sach.tenSach}
                                            </a>
                                            <div class="font-bold text-gray-500 dark:text-gray-400 text-xs">Đơn giá: <fmt:formatNumber value="${detail.price}" pattern="#,###" />đ x ${detail.quantity}</div>
                                        </div>
                                    </div>
                                    <div class="font-black text-dark dark:text-white text-lg">
                                        <fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,###" />đ
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
