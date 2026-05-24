<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <div class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
                <div>
                    <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1"
                        style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">KHO TRUYỆN TRANH</h1>
                    <p class="font-black text-gray-500 mt-2 uppercase">Khu vực quản lý dành riêng cho các Wibu chúa</p>
                </div>
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin?action=orders"
                        class="flex items-center gap-2 bg-secondary hover:bg-white text-dark px-6 py-3 border-4 border-black rounded shadow-comic hover:shadow-comic-lg transition font-black uppercase transform rotate-2">
                        ĐƠN HÀNG MỚI
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?action=add"
                        class="flex items-center gap-2 bg-primary hover:bg-white text-white hover:text-primary px-6 py-3 border-4 border-black rounded shadow-comic hover:shadow-comic-lg transition font-black uppercase transform -rotate-1">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"></path>
                        </svg>
                        NHẬP TRUYỆN MỚI!
                    </a>
                </div>
            </div>

            <!-- Biểu đồ Thống kê Doanh Thu -->
            <div class="bg-white border-4 border-black shadow-comic-lg p-6 mb-8">
                <h2 class="text-3xl font-comic text-dark uppercase mb-4" style="-webkit-text-stroke: 1px black;">THỐNG KÊ DOANH THU NĂM NAY</h2>
                <div class="w-full h-80">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const ctx = document.getElementById('revenueChart').getContext('2d');
                    
                    // Parse data passed from Servlet
                    const labels = ${not empty chartLabels ? chartLabels : '[]'};
                    const dataPoints = ${not empty chartData ? chartData : '[]'};
                    
                    new Chart(ctx, {
                        type: 'line', // Có thể đổi thành 'bar'
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Doanh Thu (VNĐ)',
                                data: dataPoints,
                                backgroundColor: 'rgba(255, 209, 102, 0.5)', // Màu phụ (vàng)
                                borderColor: '#ef476f', // Màu chính (hồng/đỏ)
                                borderWidth: 4,
                                tension: 0.3, // Làm cong đường
                                pointBackgroundColor: '#06d6a0',
                                pointBorderColor: '#000',
                                pointBorderWidth: 2,
                                pointRadius: 5,
                                pointHoverRadius: 8
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    labels: {
                                        font: {
                                            family: 'Comic Sans MS, cursive', // Font Comic
                                            size: 14,
                                            weight: 'bold'
                                        },
                                        color: '#000'
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: {
                                        color: '#000',
                                        lineWidth: 2,
                                        borderDash: [5, 5]
                                    },
                                    ticks: {
                                        font: { weight: 'bold' },
                                        color: '#000',
                                        callback: function(value) {
                                            return value.toLocaleString('vi-VN') + 'đ';
                                        }
                                    }
                                },
                                x: {
                                    grid: {
                                        color: '#000',
                                        lineWidth: 2
                                    },
                                    ticks: {
                                        font: { weight: 'bold' },
                                        color: '#000'
                                    }
                                }
                            }
                        }
                    });
                });
            </script>

            <!-- Table -->
            <div
                class="bg-white border-4 border-black shadow-comic-lg overflow-x-auto">
                <div>
                    <table class="w-full text-center">
                        <thead
                            class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
                            <tr>
                                <th class="px-6 py-4 border-r-4 border-black">MÃ SỐ</th>
                                <th class="px-6 py-4 border-r-4 border-black">TRUYỆN TRANH</th>
                                <th class="px-6 py-4 border-r-4 border-black">GIÁ BÁN</th>
                                <th class="px-6 py-4 border-r-4 border-black">SỐ LƯỢNG</th>
                                <th class="px-6 py-4 text-center">THAO TÁC</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y-4 divide-black font-black uppercase text-sm">
                            <c:forEach items="${listSach}" var="sach">
                                <tr class="hover:bg-gray-100 transition-colors">
                                    <td class="px-6 py-4 border-r-4 border-black text-gray-500">#${sach.maSach}</td>
                                    <td class="px-6 py-4 border-r-4 border-black">
                                        <div class="flex items-center gap-4">
                                            <c:choose>
                                                <c:when test="${not empty sach.hinhAnh}">
                                                    <div
                                                        class="w-12 h-16 bg-white border-2 border-black shadow-comic overflow-hidden">
                                                        <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}"
                                                            class="w-full h-full object-cover">
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div
                                                        class="w-12 h-16 bg-gray-200 border-2 border-black flex items-center justify-center text-[10px] text-gray-400 font-comic">
                                                        NO IMG</div>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="text-base text-dark">${sach.tenSach}</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 border-r-4 border-black text-primary text-xl font-comic tracking-widest"
                                        style="-webkit-text-stroke: 1px black;">
                                        <fmt:formatNumber value="${sach.giaTien}" pattern="#,###" />đ
                                    </td>
                                    <td class="px-6 py-4 border-r-4 border-black">
                                        <c:choose>
                                            <c:when test="${sach.soLuong > 10}">
                                                <span
                                                    class="bg-accent border-2 border-black px-3 py-1 text-dark shadow-comic">${sach.soLuong}</span>
                                            </c:when>
                                            <c:when test="${sach.soLuong > 0}">
                                                <span
                                                    class="bg-secondary border-2 border-black px-3 py-1 text-dark shadow-comic">${sach.soLuong}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="bg-primary text-white border-2 border-black px-3 py-1 shadow-comic">CHÁY
                                                    HÀNG!</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <div class="flex items-center justify-center gap-3">
                                            <a href="${pageContext.request.contextPath}/admin?action=edit&id=${sach.maSach}"
                                                class="bg-white border-2 border-black px-4 py-2 hover:bg-accent shadow-comic hover:-translate-y-1 transition text-dark">SỬA</a>
                                            <a href="${pageContext.request.contextPath}/admin?action=delete&id=${sach.maSach}"
                                                onclick="return confirm('Chắc chắn muốn phi tang cuốn truyện này chưa?');"
                                                class="bg-primary text-white border-2 border-black px-4 py-2 shadow-comic hover:bg-dark hover:-translate-y-1 transition">XÓA!</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>