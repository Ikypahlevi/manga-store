<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

<!-- Table -->
<div data-aos="zoom-in" class="bg-white border-4 border-black shadow-comic-lg mb-8">
    <div>
        <table class="w-full text-center">
            <thead class="bg-secondary border-b-4 border-black text-dark font-comic text-xl tracking-widest sticky top-0 z-10 shadow-sm">
                <tr>
                    <th class="px-6 py-4 border-r-4 border-black">MÃ SỐ</th>
                    <th class="px-6 py-4 border-r-4 border-black">TRUYỆN TRANH</th>
                    <th class="px-6 py-4 border-r-4 border-black">GIÁ BÁN</th>
                    <th class="px-6 py-4 border-r-4 border-black">SỐ LƯỢNG</th>
                    <th class="px-6 py-4 text-center">THAO TÁC</th>
                </tr>
            </thead>
            <tbody class="divide-y-4 divide-black font-black uppercase text-sm">
                <c:forEach items="${listSach}" var="sach" varStatus="status">
                    <tr data-aos="fade-up" data-aos-delay="${status.index * 50}" class="hover:bg-gray-100 transition-colors">
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

<!-- Container for Pagination Controls -->
<div id="paginationControls" class="flex justify-center mb-8 gap-3"></div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const originalTable = document.querySelector('table');
    const allRows = Array.from(originalTable.querySelectorAll('tbody tr'));
    const itemsPerPage = 8;
    
    if(allRows.length <= itemsPerPage) return; // Không cần phân trang nếu ít hơn 8

    const theadHTML = originalTable.querySelector('thead').outerHTML;
    
    const wrapper = document.createElement('div');
    wrapper.className = 'overflow-hidden relative w-full';
    
    const totalPages = Math.ceil(allRows.length / itemsPerPage);
    
    const track = document.createElement('div');
    track.className = 'flex transition-transform duration-500 ease-in-out w-full';
    track.id = 'tableTrack';
    
    for(let i=0; i<totalPages; i++){
        const pageRows = allRows.slice(i*itemsPerPage, (i+1)*itemsPerPage);
        
        // Remove AOS attributes so hidden pages don't stay invisible
        const pageRowsHTML = pageRows.map(r => {
            const clone = r.cloneNode(true);
            clone.removeAttribute('data-aos');
            clone.removeAttribute('data-aos-delay');
            clone.style.opacity = '1';
            clone.style.transform = 'none';
            clone.classList.remove('aos-animate', 'aos-init');
            return clone.outerHTML;
        }).join('');

        const pageTable = document.createElement('table');
        pageTable.className = 'w-full text-center flex-shrink-0';
        pageTable.innerHTML = theadHTML + '<tbody class="divide-y-4 divide-black font-black uppercase text-sm">' + pageRowsHTML + '</tbody>';
        track.appendChild(pageTable);
    }
    
    wrapper.appendChild(track);
    originalTable.parentNode.replaceChild(wrapper, originalTable);

    const controls = document.getElementById('paginationControls');
    let currentPage = 0;

    function renderControls() {
        controls.innerHTML = '';
        
        if(currentPage > 0) {
            const prevBtn = document.createElement('button');
            prevBtn.type = 'button';
            prevBtn.className = 'px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase';
            prevBtn.textContent = 'Trang Trước';
            prevBtn.onclick = () => goToPage(currentPage - 1);
            controls.appendChild(prevBtn);
        }

        for(let i=0; i<totalPages; i++){
            const pageBtn = document.createElement('button');
            pageBtn.type = 'button';
            const isActive = i === currentPage;
            pageBtn.className = `px-5 py-2 border-4 border-black font-black transition-all shadow-comic uppercase ${isActive ? 'bg-primary text-white -translate-y-1' : 'bg-white text-dark hover:bg-secondary hover:-translate-y-1'}`;
            pageBtn.textContent = i + 1;
            pageBtn.onclick = () => goToPage(i);
            controls.appendChild(pageBtn);
        }

        if(currentPage < totalPages - 1) {
            const nextBtn = document.createElement('button');
            nextBtn.type = 'button';
            nextBtn.className = 'px-5 py-2 border-4 border-black bg-white font-black text-dark hover:bg-secondary hover:-translate-y-1 shadow-comic transition-all uppercase';
            nextBtn.textContent = 'Trang Kế';
            nextBtn.onclick = () => goToPage(currentPage + 1);
            controls.appendChild(nextBtn);
        }
    }

    function goToPage(page) {
        currentPage = page;
        track.style.transform = `translateX(-${currentPage * 100}%)`;
        renderControls();
    }

    renderControls();
});
</script>
