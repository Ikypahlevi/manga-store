<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div data-aos="fade-down" class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
    <div>
        <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1"
            style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">ĐƠN HÀNG MỚI</h1>
        <p class="font-black text-gray-500 mt-2 uppercase">Quản lý hóa đơn và vận chuyển</p>
    </div>
    <div class="flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/admin"
            class="flex items-center gap-2 bg-white hover:bg-secondary text-dark px-6 py-3 border-4 border-black rounded shadow-comic hover:shadow-comic-lg transition font-black uppercase transform -rotate-1">
            KHO TRUYỆN TRANH
        </a>
    </div>
</div>

<!-- Search Form -->
<div data-aos="fade-up" class="mb-6 bg-white border-4 border-black p-4 shadow-comic">
    <form action="${pageContext.request.contextPath}/AdminOrdersServlet" method="GET" class="flex flex-col md:flex-row items-center gap-4">
        <input type="text" name="search" value="${search}" placeholder="Tên khách hàng, Số điện thoại..." class="flex-grow w-full md:w-auto bg-gray-50 border-4 border-black p-3 font-bold uppercase focus:bg-yellow-50 focus:outline-none focus:-translate-y-1 focus:shadow-comic transition-all" />
        <select name="status" class="w-full md:w-auto bg-gray-50 border-4 border-black p-3 font-bold uppercase focus:bg-yellow-50 focus:outline-none focus:-translate-y-1 focus:shadow-comic transition-all cursor-pointer">
            <option value="ALL" ${status == 'ALL' ? 'selected' : ''}>TẤT CẢ TRẠNG THÁI</option>
            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>CHỜ DUYỆT</option>
            <option value="SHIPPING" ${status == 'SHIPPING' ? 'selected' : ''}>ĐANG GIAO</option>
            <option value="COMPLETED" ${status == 'COMPLETED' ? 'selected' : ''}>ĐÃ GIAO</option>
            <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>ĐÃ HỦY</option>
        </select>
        <button type="submit" class="w-full md:w-auto bg-dark text-white font-black px-8 py-3 border-4 border-black shadow-comic hover:bg-primary hover:text-white transition hover:-translate-y-1 uppercase tracking-widest">TÌM KIẾM</button>
    </form>
</div>
<!-- Table -->
<div data-aos="zoom-in" class="bg-white border-4 border-black shadow-comic-lg mb-8">
    <div>
        <table class="w-full text-center">
            <thead class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
                <tr>
                    <th class="px-6 py-4 border-r-4 border-black">MÃ ĐƠN</th>
                    <th class="px-6 py-4 border-r-4 border-black">NGƯỜI NHẬN</th>
                    <th class="px-6 py-4 border-r-4 border-black">TỔNG TIỀN</th>
                    <th class="px-6 py-4 border-r-4 border-black">NGÀY ĐẶT</th>
                    <th class="px-6 py-4 border-r-4 border-black">TRẠNG THÁI</th>
                    <th class="px-6 py-4 text-center">HÀNH ĐỘNG</th>
                </tr>
            </thead>
            <tbody class="divide-y-4 divide-black font-black text-sm">
                <c:choose>
                    <c:when test="${empty listOrders}">
                        <tr>
                            <td colspan="6" class="px-6 py-12 text-center text-gray-500 font-comic text-2xl">
                                CHƯA CÓ ĐƠN HÀNG NÀO TỚI!
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${listOrders}" var="order" varStatus="status">
                            <tr data-aos="fade-up" data-aos-delay="${status.index * 50}" class="hover:bg-gray-100 transition-colors">
                                <td class="px-6 py-4 border-r-4 border-black text-gray-500 font-bold uppercase">#${order.id}</td>
                                <td class="px-6 py-4 border-r-4 border-black text-left">
                                    <div class="font-bold text-dark uppercase">${order.customerName}</div>
                                    <div class="text-xs text-gray-500 mt-1">📞 ${order.customerPhone}</div>
                                    <div class="text-xs text-gray-500 mt-1 truncate max-w-[200px]" title="${order.customerAddress}">📍 ${order.customerAddress}</div>
                                </td>
                                <td class="px-6 py-4 border-r-4 border-black text-primary text-xl font-comic tracking-widest"
                                    style="-webkit-text-stroke: 1px black;">
                                    <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />đ
                                </td>
                                <td class="px-6 py-4 border-r-4 border-black text-gray-600">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td class="px-6 py-4 border-r-4 border-black">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="bg-secondary border-2 border-black px-3 py-1 text-dark shadow-comic font-bold uppercase">CHỜ DUYỆT</span>
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPING'}">
                                            <span class="bg-accent border-2 border-black px-3 py-1 text-dark shadow-comic font-bold uppercase">ĐANG GIAO</span>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">
                                            <span class="bg-[#06D6A0] border-2 border-black px-3 py-1 text-dark shadow-comic font-bold uppercase">ĐÃ GIAO</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-primary text-white border-2 border-black px-3 py-1 shadow-comic font-bold uppercase">ĐÃ HỦY</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <c:if test="${order.status == 'PENDING'}">
                                        <div class="flex items-center justify-center gap-2">
                                            <a href="${pageContext.request.contextPath}/admin?action=update-order-status&id=${order.id}&status=SHIPPING"
                                               class="bg-accent border-2 border-black px-3 py-2 shadow-comic hover:-translate-y-1 transition text-dark font-bold uppercase text-xs">DUYỆT & GIAO</a>
                                            <a href="${pageContext.request.contextPath}/admin?action=update-order-status&id=${order.id}&status=CANCELLED"
                                               onclick="return confirm('Chắc chắn muốn hủy đơn này?');"
                                               class="bg-primary text-white border-2 border-black px-3 py-2 shadow-comic hover:-translate-y-1 transition font-bold uppercase text-xs">HỦY!</a>
                                        </div>
                                    </c:if>
                                    <c:if test="${order.status == 'SHIPPING'}">
                                        <a href="${pageContext.request.contextPath}/admin?action=update-order-status&id=${order.id}&status=COMPLETED"
                                           class="inline-block bg-[#06D6A0] border-2 border-black px-3 py-2 shadow-comic hover:-translate-y-1 transition text-dark font-bold uppercase text-xs">XÁC NHẬN ĐÃ GIAO</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
