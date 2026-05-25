<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div data-aos="fade-down" class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
    <div>
        <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1" style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">KHÁCH HÀNG VIP</h1>
        <p class="font-black text-gray-500 mt-2 uppercase">Vinh danh các Wibu chịu chi nhất</p>
    </div>
</div>

<div data-aos="zoom-in" class="bg-white border-4 border-black shadow-comic-lg overflow-x-auto">
    <table class="w-full text-center">
        <thead class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
            <tr>
                <th class="px-6 py-4 border-r-4 border-black">TOP</th>
                <th class="px-6 py-4 border-r-4 border-black">TÀI KHOẢN</th>
                <th class="px-6 py-4 border-r-4 border-black">CẤP BẬC</th>
                <th class="px-6 py-4 border-r-4 border-black">MANGA COIN</th>
                <th class="px-6 py-4 text-center">TỔNG ĐÃ CHI</th>
            </tr>
        </thead>
        <tbody class="divide-y-4 divide-black font-black text-sm uppercase">
            <c:choose>
                <c:when test="${empty listVip}">
                    <tr>
                        <td colspan="5" class="px-6 py-12 text-center text-gray-500 font-comic text-2xl">
                            CHƯA CÓ AI ĐẠT VIP!
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${listVip}" var="vip" varStatus="loop">
                        <tr data-aos="fade-up" data-aos-delay="${loop.index * 100}" class="hover:bg-gray-100 transition-colors">
                            <td class="px-6 py-4 border-r-4 border-black text-2xl font-comic ${loop.index == 0 ? 'text-primary' : (loop.index == 1 ? 'text-accent' : (loop.index == 2 ? 'text-secondary' : 'text-gray-500'))}" style="${loop.index < 3 ? '-webkit-text-stroke: 1px black;' : ''}">#${loop.index + 1}</td>
                            <td class="px-6 py-4 border-r-4 border-black text-left">
                                <div class="font-bold text-dark uppercase flex items-center gap-2">
                                    <div class="w-8 h-8 rounded-full bg-secondary border-2 border-black flex items-center justify-center font-comic text-dark shadow-comic-hover">${vip.user.username.substring(0,1).toUpperCase()}</div>
                                    ${vip.user.username}
                                </div>
                            </td>
                            <td class="px-6 py-4 border-r-4 border-black">
                                <span class="bg-dark text-white px-2 py-1 rounded border-2 border-black">${vip.user.rankTier}</span>
                            </td>
                            <td class="px-6 py-4 border-r-4 border-black text-secondary text-lg" style="-webkit-text-stroke: 1px black;">💰 ${vip.user.mangaCoin}</td>
                            <td class="px-6 py-4 text-primary text-xl font-comic tracking-widest" style="-webkit-text-stroke: 1px black;">
                                <fmt:formatNumber value="${vip.totalSpent}" pattern="#,###" />đ
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
