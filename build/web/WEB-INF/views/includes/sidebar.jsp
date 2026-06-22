<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>

        <c:choose>
            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN' && view.contains('/admin')}">
                <aside data-aos="fade-right" class="w-72 flex-shrink-0 hidden xl:block">
                    <div class="bg-white border-4 border-black shadow-comic p-6 rounded-lg relative w-full">

                        <div class="text-center mb-8 pb-6 border-b-4 border-black">
                            <h3 class="font-comic text-4xl text-primary tracking-wide transform -rotate-3"
                                style="-webkit-text-stroke: 1px black;">ADMIN PANEL</h3>
                            <p
                                class="font-black text-dark bg-secondary inline-block px-2 mt-2 border-2 border-black transform rotate-2">
                                Khu Vực Cấm</p>
                        </div>

                        <c:set var="currentAction" value="${empty param.action ? 'dashboard' : param.action}" />
                        <nav class="space-y-4">
                            <a href="${pageContext.request.contextPath}/admin?action=dashboard"
                                class="block w-full text-center py-3 ${currentAction == 'dashboard' ? 'bg-accent' : 'bg-white'} border-4 border-black rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all font-comic text-2xl tracking-widest text-dark">
                                THỐNG KÊ TỔNG
                            </a>

                            <a href="${pageContext.request.contextPath}/admin?action=products"
                                class="block w-full text-center py-3 ${currentAction == 'products' ? 'bg-accent' : 'bg-white'} border-4 border-black rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all font-comic text-2xl tracking-widest text-dark">
                                KHO TRUYỆN TRANH
                            </a>

                            <a href="${pageContext.request.contextPath}/admin?action=orders"
                                class="block w-full text-center py-3 ${currentAction == 'orders' ? 'bg-accent' : 'bg-white'} border-4 border-black rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all font-comic text-2xl tracking-widest text-dark">
                                ĐƠN HÀNG MỚI
                            </a>

                            <a href="${pageContext.request.contextPath}/admin?action=vip"
                                class="block w-full text-center py-3 ${currentAction == 'vip' ? 'bg-accent' : 'bg-white'} border-4 border-black rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all font-comic text-2xl tracking-widest text-dark">
                                KHÁCH HÀNG VIP
                            </a>

                            <a href="${pageContext.request.contextPath}/admin?action=reviews"
                                class="block w-full text-center py-3 ${currentAction == 'reviews' ? 'bg-accent' : 'bg-white'} border-4 border-black rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all font-comic text-2xl tracking-widest text-dark">
                                DUYỆT ĐÁNH GIÁ
                            </a>
                        </nav>

                        <div class="mt-8 pt-4 border-t-4 border-black text-center">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.avatar}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}"
                                        class="w-16 h-16 mx-auto rounded-full border-2 border-black bg-white object-cover"
                                        alt="Admin Avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://api.dicebear.com/7.x/bottts/svg?seed=admin&backgroundColor=FFD166"
                                        class="w-16 h-16 mx-auto rounded-full border-2 border-black bg-secondary"
                                        alt="Admin Avatar">
                                </c:otherwise>
                            </c:choose>
                            <div class="mt-2 font-black text-dark uppercase">${sessionScope.user.username}</div>
                        </div>
                    </div>
                </aside>
            </c:when>
            <c:when test="${view.contains('/customer/home')}">
                <aside data-aos="fade-right" class="w-72 flex-shrink-0 hidden md:block">
                    <div class="bg-white border-4 border-black shadow-comic p-6 rounded-lg relative">
                        <div class="text-center mb-6 pb-4 border-b-4 border-black">
                            <h3 class="font-comic text-3xl text-primary tracking-wide transform -rotate-2"
                                style="-webkit-text-stroke: 1px black;">LỌC TRUYỆN</h3>
                            <p
                                class="font-black text-dark bg-secondary inline-block px-2 mt-2 border-2 border-black transform rotate-2">
                                Theo Giá Tiền</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/customer" method="GET" class="space-y-4">
                            <input type="hidden" name="action" value="home">
                            <div>
                                <label class="block font-black text-dark uppercase mb-1">Giá từ:</label>
                                <input type="number" name="minPrice" value="${minPrice}"
                                    class="w-full px-3 py-2 border-4 border-black font-bold focus:outline-none focus:border-primary shadow-comic transition"
                                    placeholder="VNĐ">
                            </div>
                            <div>
                                <label class="block font-black text-dark uppercase mb-1">Đến:</label>
                                <input type="number" name="maxPrice" value="${maxPrice}"
                                    class="w-full px-3 py-2 border-4 border-black font-bold focus:outline-none focus:border-primary shadow-comic transition"
                                    placeholder="VNĐ">
                            </div>

                            <button type="submit"
                                class="w-full bg-accent text-dark border-4 border-black font-comic text-2xl py-2 mt-4 shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition tracking-widest uppercase">
                                LỌC NGAY!
                            </button>
                        </form>
                    </div>
                </aside>
            </c:when>
        </c:choose>
