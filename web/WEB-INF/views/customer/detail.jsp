<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Nút Quay lại ghim bên trái cho mọi màn hình -->
<div class="absolute top-0 -left-[7.5rem]">
    <a href="${pageContext.request.contextPath}/customer"
       class="flex flex-col items-center gap-2 md:gap-4 bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-2 md:p-4 font-black uppercase text-dark dark:text-white hover:bg-secondary dark:hover:bg-yellow-600 hover:-translate-x-1 hover:-translate-y-1 shadow-comic dark:shadow-comic-dark transition-all">
        <svg class="w-6 h-6 md:w-8 md:h-8" fill="none" stroke="currentColor" stroke-width="4"
             viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
        </svg>
    </a>
</div>

<div
    class="max-w-5xl mx-auto mb-8 flex flex-col pl-14 md:pl-0">

    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark overflow-hidden transition-colors">

        <div class="flex flex-col md:flex-row">
            <!-- Khung Ảnh Truyện -->
            <div data-aos="fade-right"
                class="w-full md:w-5/12 bg-secondary dark:bg-yellow-700 border-b-4 md:border-b-0 md:border-r-4 border-black dark:border-white p-4 relative flex items-center justify-center bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23000000\'/%3E%3C/svg%3E')] dark:bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23ffffff\' opacity=\'0.2\'/%3E%3C/svg%3E')]">
                <div
                    class="relative z-10 w-full flex justify-center">
                    <div class="relative w-full max-w-[320px] md:max-w-[380px]">
                        <!-- Nổ giá -->
                        <div class="absolute -top-3 -right-3 z-20">
                            <div
                                class="bg-primary border-4 border-black p-2 rounded-full w-16 h-16 flex items-center justify-center flex-col shadow-comic transform rotate-12">
                                <span class="font-comic text-white text-sm leading-none">HOT</span>
                                <span class="font-black text-secondary text-xs">DEAL!</span>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sach.hinhAnh}">
                                <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}"
                                     alt="${sach.tenSach}"
                                     class="w-full h-auto object-contain border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark animate-float-comic"
                                     style="image-rendering: -webkit-optimize-contrast;" />
                            </c:when>
                            <c:otherwise>
                                <div
                                    class="w-full h-40 md:h-80 flex flex-col items-center justify-center font-comic text-2xl md:text-3xl text-gray-400">
                                    NO IMAGE</div>
                                </c:otherwise>
                            </c:choose>
                    </div>
                </div>
            </div>

            <!-- Chi tiết Truyện -->
            <div data-aos="fade-left" class="w-full md:w-7/12 p-6 md:p-8 flex flex-col relative bg-white dark:bg-gray-800">



                <h1 class="text-3xl md:text-4xl font-black uppercase text-dark dark:text-white leading-tight mb-4">
                    ${sach.tenSach}</h1>

                <div class="bg-gray-100 dark:bg-gray-700 border-4 border-black dark:border-white p-3 shadow-comic dark:shadow-comic-dark mb-4 transform rotate-1">
                    <h4 class="font-comic text-xl text-primary tracking-wide mb-1">THÔNG TIN SIÊU PHẨM:
                    </h4>
                    <p class="font-bold text-gray-700 dark:text-gray-300 text-sm leading-relaxed">
                        <c:choose>
                            <c:when test="${not empty sach.moTa}">
                                ${sach.moTa}
                            </c:when>
                            <c:otherwise>
                                Bộ truyện cực kỳ hấp dẫn đang làm mưa làm gió trên bảng xếp hạng Oricon. Một khi đã đọc là không thể rời mắt. Mua ngay để bổ sung vào bộ sưu tập của bạn!
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="flex flex-wrap gap-4 mb-6">
                    <div class="bg-white dark:bg-gray-700 border-4 border-black dark:border-white px-4 py-2 shadow-comic dark:shadow-comic-dark">
                        <div class="font-black text-xs text-gray-500 dark:text-gray-400 uppercase mb-1">TRẠNG THÁI</div>
                        <div class="font-comic text-2xl ${sach.soLuong > 0 ? 'text-accent' : 'text-primary'} tracking-widest"
                             style="-webkit-text-stroke: 1px black;">
                            ${sach.soLuong > 0 ? 'CÒN HÀNG' : 'HẾT HÀNG'} (${sach.soLuong})
                        </div>
                    </div>

                    <div class="bg-white dark:bg-gray-700 border-4 border-black dark:border-white px-4 py-2 shadow-comic dark:shadow-comic-dark">
                        <div class="font-black text-xs text-gray-500 dark:text-gray-400 uppercase mb-1">GIÁ BÁN</div>
                        <div class="font-comic text-3xl text-primary tracking-widest"
                             style="-webkit-text-stroke: 1px black;">
                            <fmt:formatNumber value="${sach.giaTien}" pattern="#,###" />Đ
                        </div>
                    </div>
                </div>

                <div class="mt-auto pt-6 flex flex-col sm:flex-row gap-4">
                    <c:choose>
                        <c:when test="${sach.soLuong > 0}">
                            <a href="${pageContext.request.contextPath}/customer?action=add-to-cart&id=${sach.maSach}"
                               class="flex-1 bg-primary border-4 border-black text-white font-comic text-2xl md:text-3xl tracking-widest py-3 md:py-4 rounded shadow-comic-lg hover:shadow-comic-hover hover:translate-y-1 hover:translate-x-1 hover:bg-secondary hover:text-dark transition-all uppercase flex items-center justify-center gap-2 btn-add-to-cart-ajax"
                               style="-webkit-text-stroke: 1px black;">
                                <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="3"
                                     viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z">
                                </path>
                                </svg>
                                MÚC NGAY!
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button disabled
                                    class="flex-1 bg-gray-400 border-4 border-black text-white font-comic text-2xl md:text-3xl tracking-widest py-3 md:py-4 rounded shadow-comic cursor-not-allowed uppercase flex items-center justify-center gap-2"
                                    style="-webkit-text-stroke: 1px black;">
                                HẾT HÀNG RỒI!
                            </button>
                        </c:otherwise>
                    </c:choose>
                    
                    <button type="button" id="btn-read-preview"
                        class="flex-1 bg-accent border-4 border-black text-white font-comic text-xl md:text-2xl tracking-widest py-3 md:py-4 rounded shadow-comic hover:shadow-comic-hover hover:translate-y-1 hover:translate-x-1 hover:bg-teal-300 hover:text-dark transition-all uppercase flex items-center justify-center gap-2"
                        style="-webkit-text-stroke: 1px black;">
                        ĐỌC THỬ
                    </button>

                    <button type="button" id="btn-favorite"
                        class="sm:flex-none bg-white dark:bg-gray-700 border-4 border-black dark:border-white ${isFavorite ? 'text-primary dark:text-primary' : 'text-dark dark:text-white'} font-comic text-xl md:text-2xl tracking-widest py-3 px-6 rounded shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-gray-100 dark:hover:bg-gray-600 transition-all uppercase flex items-center justify-center gap-2"
                        title="Thêm vào yêu thích">
                        <svg class="w-8 h-8" fill="${isFavorite ? 'currentColor' : 'none'}" stroke="black" stroke-width="2"
                             viewBox="0 0 24 24">
                        <path
                            d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z">
                        </path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <!-- Trailer Siêu Phẩm -->
        <c:if test="${not empty sach.trailerUrl}">
        <div data-aos="zoom-in" class="border-t-4 border-black dark:border-white p-6 md:p-8 bg-dark dark:bg-black">
            <h2 class="text-3xl font-comic text-white uppercase mb-6 flex items-center gap-2" style="-webkit-text-stroke: 1px black;">
                <span class="text-4xl">🎬</span> TRAILER SIÊU PHẨM
            </h2>
            <div class="relative w-full overflow-hidden border-4 border-white shadow-[8px_8px_0_0_#e63946] transform -rotate-1 bg-black" style="padding-top: 56.25%;">
                <iframe class="absolute top-0 left-0 w-full h-full" src="${sach.trailerUrl}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </div>
        </div>
        </c:if>

    </div>
</div>
<!-- Đánh giá và Bình luận -->
<div data-aos="fade-up" class="max-w-5xl mx-auto mt-8 mb-8 pl-14 md:pl-0">
    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark p-6 md:p-8 transition-colors">
        <h2 class="text-3xl font-comic text-dark dark:text-white uppercase mb-6" style="-webkit-text-stroke: 1px black;">ĐÁNH GIÁ TỪ ĐỘC GIẢ</h2>
        
        <!-- Form nhập đánh giá (chỉ hiện khi đã đăng nhập) -->
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <form id="reviewForm" class="mb-8 border-b-4 border-black pb-8">
                    <input type="hidden" name="id" value="${sach.maSach}">
                    <div class="mb-4">
                        <label class="block font-black text-dark uppercase mb-2">Chấm Điểm:</label>
                        <div class="flex gap-6" id="emojiRating">
                            <input type="hidden" name="rating" id="ratingValue" value="5">
                            
                            <label class="cursor-pointer group flex flex-col items-center emoji-label" data-value="5">
                                <div class="text-4xl filter grayscale-0 transition-all emoji-icon border-4 border-black p-2 rounded-full bg-secondary transform hover:scale-110">🔥</div>
                                <span class="font-black text-xs mt-2 uppercase text-primary">Siêu phẩm</span>
                            </label>
                            
                            <label class="cursor-pointer group flex flex-col items-center emoji-label" data-value="4">
                                <div class="text-4xl filter grayscale group-hover:grayscale-0 transition-all emoji-icon border-4 border-transparent p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transform hover:scale-110">😭</div>
                                <span class="font-black text-xs mt-2 uppercase text-gray-400">Cảm động</span>
                            </label>

                            <label class="cursor-pointer group flex flex-col items-center emoji-label" data-value="3">
                                <div class="text-4xl filter grayscale group-hover:grayscale-0 transition-all emoji-icon border-4 border-transparent p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transform hover:scale-110">🤣</div>
                                <span class="font-black text-xs mt-2 uppercase text-gray-400">Hài hước</span>
                            </label>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="block font-black text-dark dark:text-white uppercase mb-2">Bình luận của bạn:</label>
                        <textarea name="comment" rows="3" required class="w-full bg-white dark:bg-gray-700 text-dark dark:text-white border-4 border-black dark:border-white p-3 font-sans focus:outline-none focus:ring-4 ring-secondary shadow-comic dark:shadow-comic-dark" placeholder="Truyện nét vẽ cháy quá shop ơi..."></textarea>
                    </div>
                    <button type="submit" class="bg-accent dark:bg-teal-700 border-4 border-black dark:border-white px-6 py-2 font-black uppercase text-dark dark:text-white hover:bg-secondary dark:hover:bg-yellow-600 hover:-translate-y-1 hover:translate-x-1 shadow-comic dark:shadow-comic-dark transition-all">Gửi Đánh Giá</button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="bg-gray-100 dark:bg-gray-700 border-4 border-black dark:border-white p-4 text-center font-bold text-gray-600 dark:text-gray-300 mb-8 shadow-comic dark:shadow-comic-dark">
                    Bạn cần <a href="${pageContext.request.contextPath}/auth?action=login" class="text-primary hover:underline">Đăng nhập</a> để để lại bình luận!
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Danh sách bình luận -->
        <div class="space-y-6">
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="rv" items="${reviews}">
                        <div class="bg-white dark:bg-gray-700 border-4 border-black dark:border-white p-4 shadow-comic dark:shadow-comic-dark relative">
                            <div class="flex items-center gap-2 mb-2">
                                <div class="font-black text-dark dark:text-white text-lg">${rv.username}</div>
                                <div class="flex text-primary font-black text-lg items-center gap-2">
                                    <c:choose>
                                        <c:when test="${rv.rating == 5}"><span class="text-3xl">🔥</span> Siêu phẩm</c:when>
                                        <c:when test="${rv.rating == 4}"><span class="text-3xl">😭</span> Cảm động</c:when>
                                        <c:otherwise><span class="text-3xl">🤣</span> Hài hước</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-xs font-bold text-gray-500 dark:text-gray-400 ml-auto"><fmt:formatDate value="${rv.createdAt}" pattern="dd/MM/yyyy HH:mm" /></div>
                            </div>
                            <p class="text-gray-800 dark:text-gray-200 font-medium">${rv.comment}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="font-bold text-gray-500 text-center italic">Chưa có đánh giá nào. Hãy là người đầu tiên bóc tem!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<c:if test="${not empty relatedComics}">
    <div data-aos="fade-up" data-aos-delay="200" class="max-w-5xl mx-auto mt-12 mb-8 pl-14 md:pl-0">
        <h2 class="text-3xl font-comic text-primary uppercase mb-6 transform -rotate-1" style="-webkit-text-stroke: 1px black;">CÓ THỂ BẠN SẼ THÍCH</h2>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <c:forEach var="rc" items="${relatedComics}" varStatus="status">
                <div data-aos="flip-left" data-aos-delay="${status.index * 100}" class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark hover:-translate-y-2 transition-transform flex flex-col group relative">
                    <a href="${pageContext.request.contextPath}/customer?action=detail&id=${rc.maSach}" class="absolute inset-0 z-10"></a>
                    <div class="h-48 bg-secondary dark:bg-yellow-700 border-b-4 border-black dark:border-white p-2 flex items-center justify-center bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23000000\'/%3E%3C/svg%3E')] dark:bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23ffffff\' opacity=\'0.2\'/%3E%3C/svg%3E')]">
                        <c:choose>
                            <c:when test="${not empty rc.hinhAnh}">
                                <img src="${pageContext.request.contextPath}/img/${rc.hinhAnh}" alt="${rc.tenSach}" class="h-full w-auto object-contain drop-shadow-[4px_4px_0_rgba(0,0,0,1)] dark:drop-shadow-[4px_4px_0_rgba(255,255,255,0.2)] group-hover:scale-105 transition-transform">
                            </c:when>
                            <c:otherwise>
                                <div class="font-comic text-gray-500 dark:text-gray-300">NO IMAGE</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="p-3 flex-grow flex flex-col justify-between bg-white dark:bg-gray-800">
                        <h3 class="font-black text-dark dark:text-white text-sm line-clamp-2 uppercase leading-tight mb-2 group-hover:text-primary transition-colors">${rc.tenSach}</h3>
                        <div class="font-comic text-xl text-primary" style="-webkit-text-stroke: 0.5px black;"><fmt:formatNumber value="${rc.giaTien}" pattern="#,###" />Đ</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<!-- Xóa bớt các thẻ đóng div thừa -->

<!-- MANGA READER MODAL -->
<div id="mangaReaderModal" class="fixed inset-0 z-[100] bg-black hidden flex-col items-center justify-center overflow-hidden">
    <!-- Header: Close Button and Title -->
    <div class="absolute top-0 w-full p-4 flex justify-between items-center z-50 bg-gradient-to-b from-black/80 to-transparent">
        <h3 class="text-white font-comic text-xl md:text-2xl opacity-80 uppercase tracking-wider">${sach.tenSach} - Đọc thử</h3>
        <button id="closeReaderBtn" class="text-white hover:text-primary transition-colors flex items-center justify-center w-12 h-12 rounded-full bg-black/50 hover:bg-black border-2 border-transparent hover:border-white">
            <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"></path></svg>
        </button>
    </div>

    <!-- Pages Container -->
    <div id="readerPages" class="relative w-full h-full max-w-3xl mx-auto flex items-center justify-center">
        
        <!-- Page 1: Cover Image (Black & White Manga Style) -->
        <div class="manga-page absolute inset-0 flex flex-col items-center justify-center p-8 transition-opacity duration-300 opacity-100 z-30 pointer-events-none" id="page-1">
            <div class="bg-white p-2 border-4 border-black shadow-[10px_10px_0_0_rgba(255,255,255,0.2)]">
                <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}" class="max-h-[80vh] w-auto object-contain grayscale contrast-125 brightness-90">
            </div>
            <div class="mt-4 bg-black px-4 py-1 text-white font-bold font-comic transform -rotate-2">Trang 1</div>
        </div>

        <!-- Page 2: Dynamic CSS Manga Page (Synopsis) -->
        <div class="manga-page absolute inset-0 flex flex-col items-center justify-center p-4 md:p-8 transition-opacity duration-300 opacity-0 z-20 pointer-events-none" id="page-2">
            <div class="w-full h-full max-h-[80vh] bg-white border-[8px] border-black flex flex-col relative overflow-hidden font-comic p-4 md:p-6" style="background-image: radial-gradient(#6b7280 1.5px, transparent 1.5px); background-size: 10px 10px;">
                <!-- Panel 1: Title -->
                <div class="border-4 border-black bg-white p-4 mb-4 transform -skew-x-3 shadow-[8px_8px_0_0_#000] rotate-1">
                    <h2 class="text-3xl md:text-5xl font-black uppercase text-center leading-none" style="-webkit-text-stroke: 1px black; color: white; text-shadow: 4px 4px 0 #000;">${sach.tenSach}</h2>
                </div>
                <!-- Panel 2: Description / Plot -->
                <div class="flex-grow border-4 border-black bg-white p-6 relative shadow-[8px_8px_0_0_#000] transform -rotate-1">
                    <div class="absolute -top-4 left-1/2 w-8 h-8 bg-white border-l-4 border-t-4 border-black transform rotate-45 -translate-x-1/2"></div>
                    <p class="text-xl md:text-2xl font-bold leading-relaxed whitespace-pre-line text-justify">${sach.moTa != null ? sach.moTa : 'Cuộc hành trình kỳ thú bắt đầu từ đây...'}</p>
                    
                    <div class="absolute bottom-4 right-4 font-black text-4xl opacity-20">ゴゴゴゴ</div>
                    <div class="absolute top-4 left-4 font-black text-4xl opacity-20 transform -rotate-12">DON!</div>
                </div>
            </div>
            <div class="mt-4 bg-black px-4 py-1 text-white font-bold font-comic transform rotate-2">Trang 2</div>
        </div>

        <!-- Page 3: Buy CTA -->
        <div class="manga-page absolute inset-0 flex flex-col items-center justify-center p-8 transition-opacity duration-300 opacity-0 z-10 pointer-events-none" id="page-3">
            <div class="text-center bg-black/60 p-8 border-4 border-white border-dashed">
                <h1 class="text-5xl md:text-7xl font-black text-white uppercase mb-6" style="text-shadow: 0 0 20px rgba(255,255,255,0.8);">TO BE<br>CONTINUED...</h1>
                <p class="text-xl md:text-2xl text-gray-300 font-comic mb-8 max-w-lg mx-auto">Câu chuyện đang đến hồi gay cấn nhất! Hãy sở hữu ngay tập truyện để thưởng thức trọn vẹn từng khung hình!</p>
                <a href="${pageContext.request.contextPath}/customer?action=add-to-cart&id=${sach.maSach}" class="inline-block pointer-events-auto bg-primary border-4 border-white text-white font-black font-comic tracking-widest text-3xl md:text-4xl py-4 px-8 hover:scale-105 hover:-translate-y-2 transition-transform shadow-[0_0_30px_rgba(230,57,70,0.8)]">
                    MÚC LUÔN!
                </a>
            </div>
        </div>
    </div>

    <!-- Navigation Overlay Areas (Left/Right) -->
    <!-- Click on Left side to go Prev, Right side to go Next -->
    <div id="prevPageArea" class="absolute left-0 top-0 w-1/3 h-full cursor-w-resize z-40 flex items-center justify-start px-4 opacity-0 hover:opacity-100 transition-opacity">
        <div class="bg-black/50 text-white rounded-full p-4"><svg class="w-10 h-10" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"></path></svg></div>
    </div>
    <div id="nextPageArea" class="absolute right-0 top-0 w-1/3 h-full cursor-e-resize z-40 flex items-center justify-end px-4 opacity-0 hover:opacity-100 transition-opacity">
        <div class="bg-black/50 text-white rounded-full p-4"><svg class="w-10 h-10" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"></path></svg></div>
    </div>

    <!-- Page Indicator -->
    <div class="absolute bottom-6 w-full text-center z-50 pointer-events-none">
        <span class="bg-black text-white font-black px-6 py-2 rounded-full border-2 border-gray-600 tracking-widest text-lg font-comic">
            <span id="currentPageNum" class="text-secondary">1</span> / 3
        </span>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // --- MANGA READER LOGIC ---
        const readBtn = document.getElementById('btn-read-preview');
        const readerModal = document.getElementById('mangaReaderModal');
        const closeReaderBtn = document.getElementById('closeReaderBtn');
        const prevArea = document.getElementById('prevPageArea');
        const nextArea = document.getElementById('nextPageArea');
        const pageNumDisplay = document.getElementById('currentPageNum');
        const pages = document.querySelectorAll('.manga-page');
        let currentPage = 1;
        const totalPages = pages.length;
        const flipSound = new Audio('https://www.soundjay.com/misc/sounds/page-flip-01a.mp3');

        // Add CSS for flip animation
        const style = document.createElement('style');
        style.textContent = `
            .flip-out-left { animation: flipOutLeft 0.4s ease-in forwards; }
            .flip-in-right { animation: flipInRight 0.4s ease-out forwards; }
            .flip-out-right { animation: flipOutRight 0.4s ease-in forwards; }
            .flip-in-left { animation: flipInLeft 0.4s ease-out forwards; }
            
            @keyframes flipOutLeft { 0% { transform: perspective(1200px) rotateY(0deg); opacity: 1; } 100% { transform: perspective(1200px) rotateY(-90deg); opacity: 0; } }
            @keyframes flipInRight { 0% { transform: perspective(1200px) rotateY(90deg); opacity: 0; } 100% { transform: perspective(1200px) rotateY(0deg); opacity: 1; } }
            @keyframes flipOutRight { 0% { transform: perspective(1200px) rotateY(0deg); opacity: 1; } 100% { transform: perspective(1200px) rotateY(90deg); opacity: 0; } }
            @keyframes flipInLeft { 0% { transform: perspective(1200px) rotateY(-90deg); opacity: 0; } 100% { transform: perspective(1200px) rotateY(0deg); opacity: 1; } }
        `;
        document.head.appendChild(style);

        function updatePages(oldPage, newPage, direction) {
            // Play sound
            flipSound.currentTime = 0;
            flipSound.play().catch(e => console.log('Audio play failed: ', e));

            pages.forEach((page, index) => {
                const pNum = index + 1;
                // Remove all animation classes
                page.classList.remove('flip-out-left', 'flip-in-right', 'flip-out-right', 'flip-in-left', 'opacity-0', 'opacity-100');
                
                if (pNum === oldPage) {
                    // Page going out
                    page.classList.add(direction === 'next' ? 'flip-out-left' : 'flip-out-right');
                    page.style.zIndex = '10';
                } else if (pNum === newPage) {
                    // Page coming in
                    page.classList.add(direction === 'next' ? 'flip-in-right' : 'flip-in-left');
                    page.style.zIndex = '30';
                } else {
                    // Other pages
                    page.classList.add('opacity-0');
                    page.style.zIndex = '0';
                }
            });
            pageNumDisplay.textContent = newPage;
        }

        // Initialize state without animation
        function initPages() {
            pages.forEach((page, index) => {
                page.classList.remove('flip-out-left', 'flip-in-right', 'flip-out-right', 'flip-in-left', 'opacity-0', 'opacity-100');
                if (index + 1 === currentPage) {
                    page.classList.add('opacity-100');
                    page.style.zIndex = '30';
                } else {
                    page.classList.add('opacity-0');
                    page.style.zIndex = '0';
                }
            });
            pageNumDisplay.textContent = currentPage;
        }

        if (readBtn && readerModal) {
            readBtn.addEventListener('click', () => {
                readerModal.classList.remove('hidden');
                readerModal.classList.add('flex');
                document.body.style.overflow = 'hidden'; // block scroll
                currentPage = 1;
                initPages();
            });

            closeReaderBtn.addEventListener('click', () => {
                readerModal.classList.add('hidden');
                readerModal.classList.remove('flex');
                document.body.style.overflow = ''; // restore scroll
            });

            nextArea.addEventListener('click', () => {
                if (currentPage < totalPages) {
                    const oldPage = currentPage;
                    currentPage++;
                    updatePages(oldPage, currentPage, 'next');
                } else {
                    // Close if clicking next on last page
                    readerModal.classList.add('hidden');
                    readerModal.classList.remove('flex');
                    document.body.style.overflow = '';
                }
            });

            prevArea.addEventListener('click', () => {
                if (currentPage > 1) {
                    const oldPage = currentPage;
                    currentPage--;
                    updatePages(oldPage, currentPage, 'prev');
                }
            });
            
            // Close on Escape key
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && !readerModal.classList.contains('hidden')) {
                    readerModal.classList.add('hidden');
                    readerModal.classList.remove('flex');
                    document.body.style.overflow = '';
                }
                if (e.key === 'ArrowRight' && !readerModal.classList.contains('hidden')) {
                    if (currentPage < totalPages) { 
                        const oldPage = currentPage;
                        currentPage++; 
                        updatePages(oldPage, currentPage, 'next'); 
                    }
                }
                if (e.key === 'ArrowLeft' && !readerModal.classList.contains('hidden')) {
                    if (currentPage > 1) { 
                        const oldPage = currentPage;
                        currentPage--; 
                        updatePages(oldPage, currentPage, 'prev'); 
                    }
                }
            });
        }
        // --- END MANGA READER LOGIC ---

        const addBtn = document.querySelector('.btn-add-to-cart-ajax');
        if (!addBtn)
            return;

        addBtn.addEventListener('click', async (e) => {
            e.preventDefault();
            const url = addBtn.getAttribute('href') + '&ajax=true';

            try {
                const response = await fetch(url);
                const data = await response.json();

                if (data.success) {
                    // Update header cart badge
                    const headerBadge = document.getElementById('header-cart-badge');
                    if (headerBadge) {
                        headerBadge.textContent = data.cartSize;
                    }

                    // Show notification toast
                    if (typeof showToast === 'function') {
                        showToast("Đã thêm vào giỏ hàng", 'success');
                    }
                }
            } catch (err) {
                console.error('Error adding to cart:', err);
            }
        });

        // Star rating logic
        // Emoji rating logic
        const emojis = document.querySelectorAll('.emoji-label');
        const ratingInput = document.getElementById('ratingValue');
        
        if (emojis.length > 0) {
            emojis.forEach(emoji => {
                emoji.addEventListener('click', () => {
                    const value = parseInt(emoji.getAttribute('data-value'));
                    ratingInput.value = value;
                    
                    // Update emoji styles
                    emojis.forEach(e => {
                        const icon = e.querySelector('.emoji-icon');
                        const text = e.querySelector('span');
                        if (e.getAttribute('data-value') == value) {
                            icon.classList.remove('grayscale', 'border-transparent');
                            icon.classList.add('grayscale-0', 'border-black', 'bg-secondary');
                            text.classList.add('text-primary');
                            text.classList.remove('text-gray-400');
                        } else {
                            icon.classList.add('grayscale', 'border-transparent');
                            icon.classList.remove('grayscale-0', 'border-black', 'bg-secondary');
                            text.classList.remove('text-primary');
                            text.classList.add('text-gray-400');
                        }
                    });
                });
            });
        }

        // Review form submit logic
        const reviewForm = document.getElementById('reviewForm');
        if (reviewForm) {
            reviewForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                const formData = new FormData(reviewForm);
                const data = new URLSearchParams(formData);
                
                try {
                    const response = await fetch('${pageContext.request.contextPath}/customer?action=add-review', {
                        method: 'POST',
                        body: data,
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        }
                    });
                    const result = await response.json();
                    if (result.success) {
                        if (typeof showToast === 'function') {
                            showToast(result.message || "Thành công!", 'success');
                        }
                        // Reset form
                        reviewForm.reset();
                        // Trở về emoji mặc định
                        if (emojis && emojis.length > 0) {
                            emojis.forEach(e => {
                                const icon = e.querySelector('.emoji-icon');
                                const text = e.querySelector('span');
                                if (e.getAttribute('data-value') == 5) {
                                    icon.classList.remove('grayscale', 'border-transparent');
                                    icon.classList.add('grayscale-0', 'border-black', 'bg-secondary');
                                    text.classList.add('text-primary');
                                    text.classList.remove('text-gray-400');
                                } else {
                                    icon.classList.add('grayscale', 'border-transparent');
                                    icon.classList.remove('grayscale-0', 'border-black', 'bg-secondary');
                                    text.classList.remove('text-primary');
                                    text.classList.add('text-gray-400');
                                }
                            });
                            document.getElementById('ratingValue').value = 5;
                        }
                    } else {
                        alert(result.message || 'Lỗi gửi đánh giá');
                    }
                } catch (err) {
                    console.error('Error adding review:', err);
                }
            });
        }
    });

    // Handle Favorite Button
    const btnFavorite = document.getElementById('btn-favorite');
    if (btnFavorite) {
        btnFavorite.addEventListener('click', async function() {
            try {
                const response = await fetch('${pageContext.request.contextPath}/customer?action=toggle-favorite', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'id=${sach.maSach}'
                });
                
                const result = await response.json();
                if (result.success) {
                    const isFav = result.isFavorite;
                    const svg = btnFavorite.querySelector('svg');
                    
                    if (isFav) {
                        svg.setAttribute('fill', 'currentColor');
                        btnFavorite.classList.remove('text-dark', 'dark:text-white');
                        btnFavorite.classList.add('text-primary', 'dark:text-primary');
                        if (typeof showToast === 'function') {
                            showToast("Đã thêm vào mục yêu thích! ❤️", 'success');
                        }
                    } else {
                        svg.setAttribute('fill', 'none');
                        btnFavorite.classList.add('text-dark', 'dark:text-white');
                        btnFavorite.classList.remove('text-primary', 'dark:text-primary');
                        if (typeof showToast === 'function') {
                            showToast("Đã bỏ yêu thích! 💔", 'warning');
                        }
                    }
                } else {
                    if (typeof showToast === 'function') {
                        showToast(result.message || 'Có lỗi xảy ra', 'error');
                    } else {
                        alert(result.message || 'Có lỗi xảy ra');
                    }
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
    }
</script>