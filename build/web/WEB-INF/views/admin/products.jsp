<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div data-aos="fade-down" class="flex items-center justify-between mb-8 pb-4 border-b-4 border-black">
    <div>
        <h1 class="text-5xl font-comic text-dark tracking-widest uppercase transform -rotate-1"
            style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">KHO TRUYỆN TRANH</h1>
        <p class="font-black text-gray-500 mt-2 uppercase">Khu vực quản lý dành riêng cho các Wibu chúa</p>
    </div>
    <div class="flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/admin?action=add"
            class="flex items-center gap-2 bg-primary hover:bg-white text-white hover:text-primary px-6 py-3 border-4 border-black rounded shadow-comic hover:shadow-comic-lg transition font-black uppercase transform -rotate-1">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"></path>
            </svg>
            NHẬP TRUYỆN MỚI!
        </a>
    </div>
</div>

<!-- Grid Wrapper for Sliding Animation -->
<div id="gridWrapper" class="relative overflow-hidden w-full">
    <div id="mangaGrid" data-aos="zoom-in" class="bg-white border-4 border-black shadow-comic-lg mb-8 w-full flex-shrink-0 transition-transform duration-500 ease-in-out">
        <div>
            <table class="w-full text-center">
                <thead class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
                    <tr>
                        <th class="px-6 py-4 border-r-4 border-black">MÃ SỐ</th>
                        <th class="px-6 py-4 border-r-4 border-black">TRUYỆN TRANH</th>
                        <th class="px-6 py-4 border-r-4 border-black">CHỦ ĐỀ</th>
                        <th class="px-6 py-4 border-r-4 border-black">GIÁ BÁN</th>
                        <th class="px-6 py-4 border-r-4 border-black">SỐ LƯỢNG</th>
                        <th class="px-6 py-4 text-center">THAO TÁC</th>
                    </tr>
                </thead>
                <tbody class="divide-y-4 divide-black font-black uppercase text-sm">
                    <c:forEach items="${listSach}" var="sach" varStatus="status">
                        <tr class="hover:bg-gray-100 transition-colors">
                            <td class="px-6 py-4 border-r-4 border-black text-gray-500">#${sach.maSach}</td>
                            <td class="px-6 py-4 border-r-4 border-black">
                                <div class="flex items-center gap-4">
                                    <c:choose>
                                        <c:when test="${not empty sach.hinhAnh}">
                                            <div class="w-12 h-16 bg-white border-2 border-black shadow-comic overflow-hidden">
                                                <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}" class="w-full h-full object-cover">
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-12 h-16 bg-gray-200 border-2 border-black flex items-center justify-center text-[10px] text-gray-400 font-comic">NO IMG</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="text-base text-dark">${sach.tenSach}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 border-r-4 border-black text-gray-700">
                                <span class="bg-yellow-200 border-2 border-black px-2 py-1">${not empty sach.theLoai ? sach.theLoai : 'Khác'}</span>
                            </td>
                            <td class="px-6 py-4 border-r-4 border-black text-primary text-xl font-comic tracking-widest" style="-webkit-text-stroke: 1px black;">
                                <fmt:formatNumber value="${sach.giaTien}" pattern="#,###" />đ
                            </td>
                            <td class="px-6 py-4 border-r-4 border-black">
                                <c:choose>
                                    <c:when test="${sach.soLuong > 10}">
                                        <span class="bg-accent border-2 border-black px-3 py-1 text-dark shadow-comic">${sach.soLuong}</span>
                                    </c:when>
                                    <c:when test="${sach.soLuong > 0}">
                                        <span class="bg-secondary border-2 border-black px-3 py-1 text-dark shadow-comic">${sach.soLuong}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="bg-primary text-white border-2 border-black px-3 py-1 shadow-comic">CHÁY HÀNG!</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <div class="flex items-center justify-center gap-3">
                                    <a href="${pageContext.request.contextPath}/admin?action=edit&id=${sach.maSach}" class="bg-white border-2 border-black px-4 py-2 hover:bg-accent shadow-comic hover:-translate-y-1 transition text-dark">SỬA</a>
                                    <a href="${pageContext.request.contextPath}/admin?action=delete&id=${sach.maSach}" onclick="return confirm('Chắc chắn muốn phi tang cuốn truyện này chưa?');" class="bg-primary text-white border-2 border-black px-4 py-2 shadow-comic hover:bg-dark hover:-translate-y-1 transition">XÓA!</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div id="paginationContainer">
    <c:if test="${totalPages > 1}">
        <div class="flex justify-center items-center mb-8 gap-8">
            <div class="flex gap-3">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/admin?action=products&page=1"
                        class="px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase" title="Trang Đầu">&lt;&lt;</a>
                    <a href="${pageContext.request.contextPath}/admin?action=products&page=${currentPage - 1}"
                        class="px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase">Trang
                        Trước</a>
                </c:if>

                <c:set var="startPage" value="${currentPage - 1}" />
                <c:set var="endPage" value="${currentPage + 1}" />
                <c:if test="${startPage < 1}">
                    <c:set var="startPage" value="1" />
                    <c:set var="endPage" value="${totalPages > 3 ? 3 : totalPages}" />
                </c:if>
                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}" />
                    <c:set var="startPage" value="${totalPages - 2 > 0 ? totalPages - 2 : 1}" />
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <a href="${pageContext.request.contextPath}/admin?action=products&page=${i}"
                        class="px-5 py-2 border-4 border-black font-black transition-all shadow-comic uppercase ${i == currentPage ? 'bg-primary text-white -translate-y-1' : 'bg-white text-dark hover:bg-secondary hover:-translate-y-1'}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/admin?action=products&page=${currentPage + 1}"
                        class="px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase">Trang
                        Kế</a>
                    <a href="${pageContext.request.contextPath}/admin?action=products&page=${totalPages}"
                        class="px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase" title="Trang Cuối">&gt;&gt;</a>
                </c:if>
            </div>
            
            <div class="font-black text-dark text-lg bg-white px-4 py-2 border-4 border-black shadow-comic transform rotate-2">
                Trang ${currentPage} / ${totalPages}
            </div>
        </div>
    </c:if>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const gridWrapper = document.getElementById('gridWrapper');
    let currentGrid = document.getElementById('mangaGrid');
    const paginationContainer = document.getElementById('paginationContainer');
    let isAnimating = false;

    if (!gridWrapper || !currentGrid || !paginationContainer) return;

    paginationContainer.addEventListener('click', function(e) {
        const link = e.target.closest('a');
        if (link) {
            e.preventDefault();
            if (isAnimating) return;
            
            const url = new URL(link.href);
            const currentPage = parseInt(new URLSearchParams(window.location.search).get('page') || '1');
            const targetPage = parseInt(url.searchParams.get('page') || '1');
            const direction = targetPage > currentPage ? 'right' : 'left';
            
            performSlide(url.toString(), direction);
        }
    });

    async function performSlide(urlStr, animationType) {
        if (isAnimating) return;
        isAnimating = true;

        try {
            const response = await fetch(urlStr);
            const htmlString = await response.text();
            
            const parser = new DOMParser();
            const doc = parser.parseFromString(htmlString, 'text/html');
            
            const newGridHtml = doc.getElementById('mangaGrid');
            const newPagination = doc.getElementById('paginationContainer');
            
            if (newGridHtml) {
                // Strip AOS attributes so elements don't get stuck
                newGridHtml.querySelectorAll('[data-aos]').forEach(el => {
                    el.removeAttribute('data-aos');
                    el.removeAttribute('data-aos-delay');
                    el.style.opacity = '1';
                    el.style.transform = 'none';
                    el.classList.remove('aos-animate', 'aos-init');
                });

                const newGrid = document.createElement('div');
                newGrid.className = currentGrid.className;
                newGrid.id = 'mangaGrid';
                newGrid.innerHTML = newGridHtml.innerHTML;
                
                gridWrapper.style.display = 'flex';
                gridWrapper.style.flexWrap = 'nowrap';
                gridWrapper.style.overflow = 'hidden';
                
                currentGrid.style.minWidth = '100%';
                newGrid.style.minWidth = '100%';
                
                currentGrid.style.transition = 'none';
                newGrid.style.transition = 'none';
                
                if (animationType === 'right') {
                    gridWrapper.appendChild(newGrid);
                    currentGrid.style.transform = 'translateX(0)';
                    newGrid.style.transform = 'translateX(0)';
                    
                    void gridWrapper.offsetWidth; // Force reflow
                    
                    currentGrid.style.transition = 'transform 500ms ease-in-out';
                    newGrid.style.transition = 'transform 500ms ease-in-out';
                    
                    currentGrid.style.transform = 'translateX(-100%)';
                    newGrid.style.transform = 'translateX(-100%)';
                } else {
                    gridWrapper.insertBefore(newGrid, currentGrid);
                    currentGrid.style.transform = 'translateX(-100%)';
                    newGrid.style.transform = 'translateX(-100%)';
                    
                    void gridWrapper.offsetWidth; // Force reflow
                    
                    currentGrid.style.transition = 'transform 500ms ease-in-out';
                    newGrid.style.transition = 'transform 500ms ease-in-out';
                    
                    currentGrid.style.transform = 'translateX(0)';
                    newGrid.style.transform = 'translateX(0)';
                }
                
                // Bắt đầu cuộn mượt mà cùng lúc với hiệu ứng trượt ngang
                const yOffset = gridWrapper.getBoundingClientRect().top + window.pageYOffset - 100;
                smoothScrollTo(yOffset, 500);
                
                await new Promise(r => setTimeout(r, 500));
                
                gridWrapper.removeChild(currentGrid);
                newGrid.style.transition = 'none';
                newGrid.style.transform = 'none';
                
                currentGrid = newGrid;
                gridWrapper.style.display = 'block';
            }

            if (paginationContainer && newPagination) {
                paginationContainer.innerHTML = newPagination.innerHTML;
            }
            
            window.history.pushState({}, '', urlStr);
        } catch (error) {
            console.error('Error fetching new page:', error);
        } finally {
            isAnimating = false;
        }
    }

    function smoothScrollTo(targetY, duration) {
        const startY = window.pageYOffset;
        const distance = targetY - startY;
        let startTime = null;

        function animation(currentTime) {
            if (startTime === null) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const progress = Math.min(timeElapsed / duration, 1);
            const ease = 1 - Math.pow(1 - progress, 3); // easeOutCubic
            
            window.scrollTo(0, startY + distance * ease);
            
            if (timeElapsed < duration) {
                requestAnimationFrame(animation);
            }
        }
        requestAnimationFrame(animation);
    }
});
</script>
