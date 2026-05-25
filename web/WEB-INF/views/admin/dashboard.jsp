<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <div data-aos="fade-down" class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
                <div>
                    <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1"
                        style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">THỐNG KÊ DOANH THU</h1>
                    <p class="font-black text-gray-500 mt-2 uppercase">Báo cáo siêu cấp vip pro</p>
                </div>
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin?action=products"
                        class="flex items-center gap-2 bg-primary hover:bg-white text-white hover:text-primary px-6 py-3 border-4 border-black rounded shadow-comic hover:shadow-comic-lg transition font-black uppercase transform -rotate-1">
                        KHO TRUYỆN TRANH
                    </a>
                </div>
            </div>

            <!-- Biểu đồ Thống kê -->
            <div class="flex flex-col gap-8 mb-8">
                <div data-aos="fade-up" class="bg-white border-4 border-black shadow-comic-lg p-6">
                    <h2 class="text-3xl font-comic text-dark uppercase mb-4 text-center" style="-webkit-text-stroke: 1px black;">THỐNG KÊ DOANH THU NĂM NAY</h2>
                    <div class="w-full h-96">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
                <div data-aos="fade-up" data-aos-delay="200" class="bg-white border-4 border-black shadow-comic-lg p-6">
                    <h2 class="text-3xl font-comic text-primary uppercase mb-4 text-center transform -rotate-1" style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">TOP 5 TRUYỆN BÁN CHẠY NHẤT</h2>
                    <div class="w-full h-[400px]">
                        <canvas id="topBooksChart"></canvas>
                    </div>
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

                    // Top Books Chart
                    const topLabels = ${not empty topBooksLabels ? topBooksLabels : '[]'};
                    const topData = ${not empty topBooksData ? topBooksData : '[]'};
                    const ctxTop = document.getElementById('topBooksChart').getContext('2d');
                    
                    new Chart(ctxTop, {
                        type: 'bar',
                        data: {
                            labels: topLabels,
                            datasets: [{
                                label: 'Số lượng bán ra',
                                data: topData,
                                backgroundColor: [
                                    '#ef476f',
                                    '#ffd166',
                                    '#06d6a0',
                                    '#118ab2',
                                    '#073b4c'
                                ],
                                borderColor: '#000',
                                borderWidth: 3
                            }]
                        },
                        options: {
                            indexAxis: 'y', // Horizontal Bar Chart
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            },
                            scales: {
                                x: {
                                    beginAtZero: true,
                                    grid: {
                                        color: '#000',
                                        lineWidth: 2,
                                        borderDash: [5, 5]
                                    },
                                    ticks: {
                                        font: { weight: 'bold' },
                                        color: '#000',
                                        stepSize: 1
                                    }
                                },
                                y: {
                                    grid: { display: false },
                                    ticks: {
                                        font: { weight: 'bold', size: 14, family: 'Nunito, sans-serif' },
                                        color: '#000'
                                    }
                                }
                            }
                        }
                    });
                });
            </script>
