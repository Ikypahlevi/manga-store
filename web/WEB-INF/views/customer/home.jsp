<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!-- Hero Banner Comic -->
            <div data-aos="zoom-out-down"
                class="relative bg-primary dark:bg-red-900 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark mb-12 p-8 md:p-16 text-center transform -rotate-1 transition-colors">
                <div
                    class="absolute inset-0 opacity-10 dark:opacity-20 bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23000000\'/%3E%3C/svg%3E')]">
                </div>
            <!-- Banner Hero (Khổ rộng) với Hiệu ứng Parallax 3D -->
        <div id="parallax-container" data-aos="zoom-out-down" class="relative bg-dark border-[8px] border-black overflow-hidden shadow-[16px_16px_0_0_#000] mb-20 aspect-[21/9] md:aspect-[3/1] flex items-center p-8 md:p-16 transform -rotate-1 cursor-crosshair">
            
            <!-- Nền chấm bi to (Lớp sau cùng - di chuyển chậm) -->
            <div id="layer-bg" class="absolute inset-0 bg-[radial-gradient(#333_3px,transparent_3px)] [background-size:20px_20px] opacity-30 transition-transform duration-75 ease-out scale-110"></div>

            <div id="layer-text" class="relative z-10 w-full md:w-2/3 transition-transform duration-75 ease-out">
                <h1 class="text-6xl md:text-8xl font-comic text-white uppercase tracking-tighter leading-none mb-4" style="-webkit-text-stroke: 3px black; text-shadow: 8px 8px 0 #FFD166;">
                    ĐẠI TIỆC<br>MANGA!
                </h1>
                <p class="text-xl md:text-3xl font-black text-white bg-black inline-block px-4 py-2 transform rotate-2">
                    Săn Sale Giảm Sâu - Đọc Lâu Không Chán
                </p>
                <div class="mt-8">
                    <a href="#danh-sach-truyen" class="inline-block bg-primary border-4 border-white text-white font-black text-2xl px-8 py-4 uppercase shadow-comic hover:-translate-y-2 hover:shadow-comic-lg transition-all animate-pulse-shadow">
                        VÀO KHO NGAY!
                    </a>
                </div>
            </div>

            <!-- Lớp hình ảnh (Lớp trên cùng - di chuyển nhanh) -->
            <div id="layer-img" class="absolute -right-10 -bottom-10 md:right-10 md:-bottom-20 w-1/2 md:w-[40%] opacity-50 md:opacity-100 transition-transform duration-75 ease-out drop-shadow-[10px_10px_0_rgba(0,0,0,1)]">
                <!-- SVG họa tiết Comic thay cho ảnh tĩnh -->
                <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" class="w-full h-auto animate-bounce-slow">
                    <path fill="#06D6A0" stroke="black" stroke-width="4" d="M44.7,-76.4C58.9,-69.2,71.8,-59.1,81.6,-46C91.4,-32.9,98,-16.4,96.5,-0.8C95.1,14.7,85.6,29.5,75.2,42.5C64.8,55.5,53.5,66.8,39.9,73.4C26.3,80,10.4,81.9,-4.6,80.5C-19.5,79,-33.6,74.2,-46.8,66.5C-60,58.8,-72.3,48.2,-80.6,34.5C-88.9,20.8,-93.2,4,-90.1,-11.2C-87,-26.4,-76.5,-40,-63.9,-49.6C-51.3,-59.2,-36.6,-64.8,-22.8,-70C-9,-75.2,3.9,-80,17.4,-81.1C30.9,-82.2,44.5,-79.6,44.7,-76.4Z" transform="translate(100 100)" />
                    <text x="100" y="115" font-family="'Nunito', sans-serif" font-weight="900" font-size="40" fill="white" stroke="black" stroke-width="2" text-anchor="middle">SALE!</text>
                </svg>
            </div>
        </div>
                        
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

            <!-- Grid Manga -->
            <div id="mangaGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 px-4 transition-opacity duration-300">
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
        </section>
        
        <script>
            // Hiệu ứng Parallax 3D cho Banner
            document.addEventListener('DOMContentLoaded', () => {
                const container = document.getElementById('parallax-container');
                const layerBg = document.getElementById('layer-bg');
                const layerText = document.getElementById('layer-text');
                const layerImg = document.getElementById('layer-img');
                
                if(!container) return;

                container.addEventListener('mousemove', (e) => {
                    const rect = container.getBoundingClientRect();
                    const x = e.clientX - rect.left; // x position within the element.
                    const y = e.clientY - rect.top;  // y position within the element.
                    
                    const centerX = rect.width / 2;
                    const centerY = rect.height / 2;
                    
                    const percentX = (x - centerX) / centerX;
                    const percentY = (y - centerY) / centerY;
                    
                    // Depth factors
                    const depthBg = 10;
                    const depthText = -20;
                    const depthImg = -40;
                    
                    layerBg.style.transform = `translate(${percentX * depthBg}px, ${percentY * depthBg}px) scale(1.1)`;
                    layerText.style.transform = `translate(${percentX * depthText}px, ${percentY * depthText}px)`;
                    layerImg.style.transform = `translate(${percentX * depthImg}px, ${percentY * depthImg}px)`;
                });
                
                container.addEventListener('mouseleave', () => {
                    layerBg.style.transform = `translate(0px, 0px) scale(1.1)`;
                    layerText.style.transform = `translate(0px, 0px)`;
                    layerImg.style.transform = `translate(0px, 0px)`;
                });
            });
        </script>

            <!-- Real-time Search Script -->
            <script>
            document.addEventListener('DOMContentLoaded', function() {
                const searchInput = document.getElementById('searchInput');
                const searchForm = document.getElementById('searchForm');
                const mangaGrid = document.getElementById('mangaGrid');
                const paginationContainer = document.getElementById('paginationContainer');
                const searchIcon = document.getElementById('searchIcon');
                const searchLoading = document.getElementById('searchLoading');
                let debounceTimer;

                if (!searchInput || !mangaGrid) return;

                searchInput.addEventListener('input', function() {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => {
                        performSearch(this.value);
                    }, 400); // Đợi 400ms sau khi ngừng gõ mới gọi API
                });

                searchForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    performSearch(searchInput.value);
                });

                async function performSearch(keyword) {
                    // Hiện loading
                    mangaGrid.style.opacity = '0.4';
                    searchIcon.classList.add('hidden');
                    searchLoading.classList.remove('hidden');
                    
                    const url = new URL(window.location.origin + '${pageContext.request.contextPath}/customer');
                    url.searchParams.set('action', 'home');
                    if (keyword && keyword.trim() !== '') {
                        url.searchParams.set('keyword', keyword.trim());
                    }
                    
                    // Giữ nguyên các filter khác (ví dụ nếu có sidebar filter giá)
                    const currentUrl = new URL(window.location.href);
                    if (currentUrl.searchParams.has('minPrice')) url.searchParams.set('minPrice', currentUrl.searchParams.get('minPrice'));
                    if (currentUrl.searchParams.has('maxPrice')) url.searchParams.set('maxPrice', currentUrl.searchParams.get('maxPrice'));

                    try {
                        const response = await fetch(url);
                        const htmlString = await response.text();
                        
                        // Parse DOM từ HTML trả về
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(htmlString, 'text/html');
                        
                        const newGrid = doc.getElementById('mangaGrid');
                        const newPagination = doc.getElementById('paginationContainer');
                        
                        if (newGrid) {
                            mangaGrid.innerHTML = newGrid.innerHTML;
                        }

                        if (paginationContainer && newPagination) {
                            paginationContainer.innerHTML = newPagination.innerHTML;
                        }
                        
                        // Thay đổi URL trên thanh địa chỉ mà không reload
                        window.history.pushState({}, '', url);
                        
                        // Khởi tạo lại VanillaTilt nếu có
                        if (typeof VanillaTilt !== 'undefined') {
                            VanillaTilt.init(document.querySelectorAll(".manga-card-tilt"));
                        }
                    } catch (error) {
                        console.error('Lỗi khi tìm kiếm real-time:', error);
                    } finally {
                        mangaGrid.style.opacity = '1';
                        searchIcon.classList.remove('hidden');
                        searchLoading.classList.add('hidden');
                    }
                }
            });
            </script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/vanilla-tilt/1.8.1/vanilla-tilt.min.js"></script>