<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!-- Hero Banner Comic -->
            <div data-aos="zoom-out-down"
                class="relative bg-primary dark:bg-red-900 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark mb-12 p-8 md:p-16 text-center transform -rotate-1 transition-colors">
                <div
                    class="absolute inset-0 opacity-10 dark:opacity-20 bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23000000\'/%3E%3C/svg%3E')]">
                </div>
                <div class="relative z-10 flex flex-col items-center justify-center h-full">
                    <div
                        class="inline-block bg-secondary dark:bg-yellow-600 border-4 border-black dark:border-white px-6 py-2 transform rotate-3 shadow-comic dark:shadow-comic-dark mb-4 animate-float-comic">
                        <span class="font-black text-xl text-dark dark:text-white">🔥 KHO SIÊU PHẨM 🔥</span>
                    </div>
                    <h1 class="text-5xl md:text-7xl font-comic text-white tracking-wider uppercase mb-8"
                        style="-webkit-text-stroke: 2px black; text-shadow: 4px 4px 0 #000;">TÌM KIẾM TRUYỆN YÊU THÍCH!</h1>
                        
                    <!-- Thanh Tìm Kiếm -->
                    <form id="searchForm" action="${pageContext.request.contextPath}/customer" method="GET" class="w-full max-w-2xl flex flex-col md:flex-row items-center gap-2 transform rotate-1">
                        <input type="hidden" name="action" value="home" />
                        <input type="text" id="searchInput" name="keyword" value="${keyword}" placeholder="Gõ tên truyện vào đây..." autocomplete="off"
                               class="w-full bg-white dark:bg-gray-800 border-4 border-black dark:border-white px-6 py-4 text-2xl font-black text-dark dark:text-white focus:outline-none focus:bg-yellow-50 dark:focus:bg-gray-700 shadow-comic dark:shadow-comic-dark" />
                        <button type="submit" class="w-full md:w-auto bg-accent dark:bg-teal-700 text-dark dark:text-white border-4 border-black dark:border-white px-8 py-4 font-comic text-3xl tracking-widest uppercase shadow-comic dark:shadow-comic-dark hover:-translate-y-1 hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all flex items-center justify-center gap-2">
                            <span id="searchIcon">TÌM!</span>
                            <svg id="searchLoading" class="animate-spin h-6 w-6 hidden" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Grid Wrapper for Sliding Animation -->
            <div id="gridWrapper" class="relative overflow-hidden w-full">
                <!-- Grid Manga -->
                <div id="mangaGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 px-4 w-full flex-shrink-0 transition-transform duration-500 ease-in-out">
                    <c:choose>
                        <c:when test="${empty listSach}">
                            <div class="col-span-full text-center py-16">
                                <h3 class="font-comic text-4xl text-dark dark:text-white tracking-widest uppercase" style="-webkit-text-stroke: 1px black;">KHÔNG TÌM THẤY TRUYỆN NÀO! 😭</h3>
                                <p class="font-black text-gray-500 mt-4 uppercase">Thử gõ từ khóa khác xem sao nha wibu!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listSach}" var="sach" varStatus="status">
                                <!-- Comic Card -->
                                <div data-aos="fade-up" data-aos-delay="${(status.index % 8) * 50}" data-tilt data-tilt-max="10" data-tilt-speed="400" data-tilt-glare="true" data-tilt-max-glare="0.5"
                                    class="manga-card-tilt bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all flex flex-col group relative overflow-hidden transform animate-pulse-shadow" style="transform-style: preserve-3d;">

                                    <c:if test="${sach.soLuong <= 0}">
                                        <div class="absolute inset-0 bg-black/60 z-20 flex items-center justify-center">
                                            <span
                                                class="bg-primary dark:bg-red-800 text-white font-comic tracking-widest text-3xl border-4 border-black dark:border-white px-4 py-2 transform -rotate-12 shadow-comic dark:shadow-comic-dark">HẾT
                                                HÀNG!</span>
                                        </div>
                                    </c:if>

                                    <div class="absolute top-0 right-0 z-10 transform translate-x-2 -translate-y-2">
                                        <div
                                            class="bg-secondary dark:bg-yellow-600 border-4 border-black dark:border-white text-dark dark:text-white font-black text-sm uppercase px-3 py-1 shadow-comic dark:shadow-comic-dark rotate-12">
                                            NEW!</div>
                                    </div>

                                    <div class="h-80 bg-gray-100 dark:bg-gray-700 border-b-4 border-black dark:border-white relative overflow-hidden">
                                        <c:choose>
                                            <c:when test="${not empty sach.hinhAnh}">
                                                <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}"
                                                    alt="${sach.tenSach}"
                                                    class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300" />
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-full h-full flex items-center justify-center bg-gray-200 dark:bg-gray-600">
                                                    <span class="font-comic text-2xl text-gray-400 dark:text-gray-300 transform -rotate-12">NO
                                                        IMAGE</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="p-5 flex flex-col flex-grow bg-white dark:bg-gray-800">

                                        <h3
                                            class="font-black text-xl text-dark dark:text-white line-clamp-2 mb-3 uppercase group-hover:text-primary dark:group-hover:text-primary transition-colors leading-tight">
                                            ${sach.tenSach}</h3>

                                        <div
                                            class="mt-auto pt-4 border-t-4 border-dashed border-gray-300 dark:border-gray-600 flex flex-col items-between justify-center">
                                            <div>
                                                <div class="text-2xl font-comic text-primary tracking-widest"
                                                    style="-webkit-text-stroke: 1px black;">
                                                    <fmt:formatNumber value="${sach.giaTien}" pattern="#,###" />đ
                                                </div>
                                                <div class="text-xs font-black text-gray-500 dark:text-gray-400 uppercase">Kho: ${sach.soLuong > 0 ?
                                                    sach.soLuong : '0'} cuốn</div>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/customer?action=detail&id=${sach.maSach}"
                                                class="bg-accent dark:bg-teal-700 border-4 border-black dark:border-white text-dark dark:text-white text-center mt-4 font-black px-4 py-2 hover:bg-secondary dark:hover:bg-yellow-600 transition-colors shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-x-1 hover:translate-y-1">
                                                XEM!
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Phân trang Comic -->
            <div id="paginationContainer">
            <c:if test="${totalPages > 1}">
                <c:set var="filterParams" value="" />
                <c:if test="${not empty minPrice}">
                    <c:set var="filterParams" value="${filterParams}&minPrice=${minPrice}" />
                </c:if>
                <c:if test="${not empty maxPrice}">
                    <c:set var="filterParams" value="${filterParams}&maxPrice=${maxPrice}" />
                </c:if>
                <c:if test="${not empty keyword}">
                    <c:set var="filterParams" value="${filterParams}&keyword=${keyword}" />
                </c:if>

                <div class="flex justify-center mt-16 gap-3">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/customer?page=${currentPage - 1}${filterParams}"
                            class="px-5 py-2 border-4 border-black dark:border-white bg-white dark:bg-gray-800 font-black text-dark dark:text-white hover:bg-secondary dark:hover:bg-yellow-600 hover:-translate-y-1 shadow-comic dark:shadow-comic-dark transition-all uppercase">Trang
                            Trước</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/customer?page=${i}${filterParams}"
                            class="px-5 py-2 border-4 border-black dark:border-white font-black transition-all shadow-comic dark:shadow-comic-dark uppercase ${i == currentPage ? 'bg-primary dark:bg-red-800 text-white -translate-y-1' : 'bg-white dark:bg-gray-800 text-dark dark:text-white hover:bg-secondary dark:hover:bg-yellow-600 hover:-translate-y-1'}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/customer?page=${currentPage + 1}${filterParams}"
                            class="px-5 py-2 border-4 border-black dark:border-white bg-white dark:bg-gray-800 font-black text-dark dark:text-white hover:bg-secondary dark:hover:bg-yellow-600 hover:-translate-y-1 shadow-comic dark:shadow-comic-dark transition-all uppercase">Trang
                            Kế</a>
                    </c:if>
                </div>
            </c:if>
            </div>

            <!-- Real-time Search & Sliding Pagination Script -->
            <script>
            document.addEventListener('DOMContentLoaded', function() {
                const searchInput = document.getElementById('searchInput');
                const searchForm = document.getElementById('searchForm');
                const gridWrapper = document.getElementById('gridWrapper');
                let currentGrid = document.getElementById('mangaGrid');
                const paginationContainer = document.getElementById('paginationContainer');
                const searchIcon = document.getElementById('searchIcon');
                const searchLoading = document.getElementById('searchLoading');
                let debounceTimer;
                let isAnimating = false;

                if (!searchInput || !currentGrid) return;

                // Handle pagination clicks
                paginationContainer.addEventListener('click', function(e) {
                    const link = e.target.closest('a');
                    if (link) {
                        e.preventDefault();
                        if (isAnimating) return;
                        
                        const url = new URL(link.href);
                        const currentPage = parseInt(new URLSearchParams(window.location.search).get('page') || '1');
                        const targetPage = parseInt(url.searchParams.get('page') || '1');
                        const direction = targetPage > currentPage ? 'right' : 'left';
                        
                        performSearchAndSlide(url.toString(), direction);
                    }
                });

                searchInput.addEventListener('input', function() {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => {
                        const url = buildSearchUrl(this.value);
                        performSearchAndSlide(url, 'fade');
                    }, 400); 
                });

                searchForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    const url = buildSearchUrl(searchInput.value);
                    performSearchAndSlide(url, 'fade');
                });

                function buildSearchUrl(keyword) {
                    const url = new URL(window.location.origin + '${pageContext.request.contextPath}/customer');
                    url.searchParams.set('action', 'home');
                    if (keyword && keyword.trim() !== '') {
                        url.searchParams.set('keyword', keyword.trim());
                    }
                    const currentUrl = new URL(window.location.href);
                    if (currentUrl.searchParams.has('minPrice')) url.searchParams.set('minPrice', currentUrl.searchParams.get('minPrice'));
                    if (currentUrl.searchParams.has('maxPrice')) url.searchParams.set('maxPrice', currentUrl.searchParams.get('maxPrice'));
                    return url.toString();
                }

                async function performSearchAndSlide(urlStr, animationType) {
                    if (isAnimating) return;
                    isAnimating = true;

                    if (animationType === 'fade') {
                        currentGrid.style.opacity = '0.4';
                        searchIcon.classList.add('hidden');
                        searchLoading.classList.remove('hidden');
                    }

                    try {
                        const response = await fetch(urlStr);
                        const htmlString = await response.text();
                        
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(htmlString, 'text/html');
                        
                        const newGridHtml = doc.getElementById('mangaGrid');
                        const newPagination = doc.getElementById('paginationContainer');
                        
                        if (newGridHtml) {
                            if (animationType === 'fade') {
                                currentGrid.innerHTML = newGridHtml.innerHTML;
                                currentGrid.style.opacity = '1';
                                if (typeof VanillaTilt !== 'undefined') {
                                    VanillaTilt.init(currentGrid.querySelectorAll(".manga-card-tilt"));
                                }
                            } else {
                                // Sliding animation
                                const newGrid = document.createElement('div');
                                newGrid.className = currentGrid.className;
                                newGrid.id = 'mangaGrid';
                                newGrid.innerHTML = newGridHtml.innerHTML;
                                
                                // Setup initial positions
                                gridWrapper.style.display = 'flex';
                                gridWrapper.style.flexWrap = 'nowrap';
                                gridWrapper.style.overflow = 'hidden';
                                
                                currentGrid.style.minWidth = '100%';
                                newGrid.style.minWidth = '100%';
                                
                                if (animationType === 'right') {
                                    gridWrapper.appendChild(newGrid);
                                    // Start transition
                                    setTimeout(() => {
                                        currentGrid.style.transform = 'translateX(-100%)';
                                        newGrid.style.transform = 'translateX(-100%)';
                                    }, 50);
                                } else {
                                    gridWrapper.insertBefore(newGrid, currentGrid);
                                    currentGrid.style.transform = 'translateX(100%)';
                                    newGrid.style.transform = 'translateX(-100%)';
                                    
                                    setTimeout(() => {
                                        currentGrid.style.transform = 'translateX(0)';
                                        newGrid.style.transform = 'translateX(0)';
                                    }, 50);
                                }
                                
                                // Wait for transition to finish
                                await new Promise(r => setTimeout(r, 500));
                                
                                if (animationType === 'right') {
                                    gridWrapper.removeChild(currentGrid);
                                    newGrid.style.transform = 'none';
                                } else {
                                    gridWrapper.removeChild(currentGrid);
                                    newGrid.style.transform = 'none';
                                }
                                
                                currentGrid = newGrid;
                                
                                if (typeof VanillaTilt !== 'undefined') {
                                    VanillaTilt.init(currentGrid.querySelectorAll(".manga-card-tilt"));
                                }
                                
                                gridWrapper.style.display = 'block';
                            }
                        }

                        if (paginationContainer && newPagination) {
                            paginationContainer.innerHTML = newPagination.innerHTML;
                        }
                        
                        window.history.pushState({}, '', urlStr);
                    } catch (error) {
                        console.error('Error fetching new page:', error);
                    } finally {
                        if (animationType === 'fade') {
                            currentGrid.style.opacity = '1';
                            searchIcon.classList.remove('hidden');
                            searchLoading.classList.add('hidden');
                        }
                        isAnimating = false;
                    }
                }
            });
            </script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/vanilla-tilt/1.8.1/vanilla-tilt.min.js"></script>