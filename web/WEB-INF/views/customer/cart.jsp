<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="cart-container" class="max-w-6xl mx-auto mb-12">
    
    <!-- Tiêu đề giỏ hàng -->
    <div class="mb-8 pb-4 border-b-4 border-black dark:border-white">
        <h1 class="text-5xl font-comic text-dark dark:text-white tracking-widest uppercase transform -rotate-1"
            style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">
            GIỎ TRUYỆN CỦA BẠN
        </h1>
        <p class="font-black text-gray-500 dark:text-gray-400 mt-2 uppercase">Lựa chọn tối thượng trước khi thanh toán</p>
    </div>

    <c:choose>
        <c:when test="${empty sessionScope.cart || empty sessionScope.cart.values()}">
            <!-- Giỏ hàng trống -->
            <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-12 text-center shadow-comic-lg dark:shadow-comic-lg-dark my-12 transform rotate-1 transition-colors">
                <div class="inline-block bg-secondary dark:bg-yellow-700 border-4 border-black dark:border-white p-6 rounded-full shadow-comic dark:shadow-comic-dark mb-6">
                    <svg class="w-20 h-20 text-dark dark:text-white" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                    </svg>
                </div>
                <h2 class="text-4xl font-comic text-primary tracking-wider mb-4" style="-webkit-text-stroke: 1px black;">GIỎ HÀNG ĐANG TRỐNG RỖNG!</h2>
                <p class="font-black text-gray-600 dark:text-gray-300 mb-8 uppercase">Bạn chưa tuyển chọn cuốn siêu phẩm nào cho bộ sưu tập của mình sao?</p>
                <a href="${pageContext.request.contextPath}/customer" 
                   class="inline-block bg-accent dark:bg-teal-700 hover:bg-white dark:hover:bg-gray-700 text-dark dark:text-white border-4 border-black dark:border-white px-8 py-4 font-comic text-2xl tracking-widest shadow-comic dark:shadow-comic-dark hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark hover:-translate-y-1 transition uppercase">
                    QUAY LẠI CỬA HÀNG HỐT TRUYỆN!
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
            <!-- Có sản phẩm trong giỏ -->
            <div class="flex flex-col lg:flex-row gap-8">
                
                <!-- Danh sách sản phẩm (Bên trái) -->
                <div class="w-full lg:w-8/12 flex flex-col gap-6">
                    
                    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark p-6 flex flex-col gap-6 transition-colors">
                        <c:set var="totalCartAmount" value="0.0" />
                        
                        <c:forEach items="${sessionScope.cart.values()}" var="item">
                            <c:set var="totalCartAmount" value="${totalCartAmount + item.totalPrice}" />
                            
                            <div class="cart-item-row flex flex-col sm:flex-row items-center justify-between border-b-4 border-black dark:border-white pb-6 last:border-b-0 last:pb-0 gap-4" data-id="${item.sach.maSach}">
                                
                                <!-- Ảnh & Tên truyện -->
                                <div class="flex items-center gap-4 w-full sm:w-1/2">
                                    <div class="w-16 h-24 bg-secondary dark:bg-yellow-700 border-2 border-black dark:border-white p-1 shadow-comic dark:shadow-comic-dark flex-shrink-0 flex items-center justify-center">
                                        <c:choose>
                                            <c:when test="${not empty item.sach.hinhAnh}">
                                                <img src="${pageContext.request.contextPath}/img/${item.sach.hinhAnh}" 
                                                     alt="${item.sach.tenSach}" 
                                                     class="max-w-full max-h-full object-contain"
                                                     style="image-rendering: -webkit-optimize-contrast;" />
                                            </c:when>
                                            <c:otherwise>
                                                <span class="font-comic text-xs dark:text-white">NO IMG</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <div class="flex flex-col">
                                        <div class="bg-black text-white px-2 py-0.5 font-black text-[10px] uppercase tracking-wider self-start mb-1 transform -rotate-1">
                                            Mã: #${item.sach.maSach}
                                        </div>
                                        <h3 class="font-black text-lg text-dark dark:text-white uppercase line-clamp-2">${item.sach.tenSach}</h3>
                                        <p class="font-comic text-primary text-md mt-1 tracking-wider" style="-webkit-text-stroke: 0.5px black;">
                                            Đơn giá: <fmt:formatNumber value="${item.sach.giaTien}" pattern="#,###" />đ
                                        </p>
                                    </div>
                                </div>
                                
                                <!-- Bộ tăng giảm số lượng & thành tiền -->
                                <div class="flex items-center justify-between sm:justify-end gap-6 w-full sm:w-1/2">
                                    
                                    <!-- Số lượng -->
                                    <div class="flex items-center border-4 border-black dark:border-white shadow-comic dark:shadow-comic-dark bg-white dark:bg-gray-700 rounded text-dark dark:text-white">
                                        <a href="${pageContext.request.contextPath}/customer?action=update-cart&id=${item.sach.maSach}&quantity=${item.quantity - 1}" 
                                           class="px-3 py-1 font-black hover:bg-secondary dark:hover:bg-yellow-600 border-r-4 border-black dark:border-white transition-colors btn-update-qty" data-id="${item.sach.maSach}" data-type="dec">-</a>
                                        <span class="px-4 font-black text-base quantity-display">${item.quantity}</span>
                                        <a href="${pageContext.request.contextPath}/customer?action=update-cart&id=${item.sach.maSach}&quantity=${item.quantity + 1}" 
                                           class="px-3 py-1 font-black hover:bg-secondary dark:hover:bg-yellow-600 border-l-4 border-black dark:border-white transition-colors btn-update-qty" data-id="${item.sach.maSach}" data-type="inc">+</a>
                                    </div>
                                    
                                    <!-- Tổng giá sản phẩm -->
                                    <div class="text-right min-w-[100px]">
                                        <div class="font-black text-xs text-gray-400 uppercase">Thành tiền</div>
                                        <div class="font-comic text-xl text-primary tracking-widest mt-0.5" style="-webkit-text-stroke: 1px black;">
                                            <span class="item-total-price"><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" /></span>đ
                                        </div>
                                    </div>
                                    
                                    <!-- Nút xoá -->
                                    <a href="${pageContext.request.contextPath}/customer?action=remove-from-cart&id=${item.sach.maSach}" 
                                       class="bg-primary text-white border-2 border-black dark:border-white p-2 shadow-comic dark:shadow-comic-dark hover:bg-dark hover:text-white hover:-translate-y-0.5 transition-all rounded btn-remove-item"
                                       data-id="${item.sach.maSach}"
                                       title="Xoá truyện khỏi giỏ">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                        </svg>
                                    </a>
                                </div>
                                
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Bảng tổng quan thanh toán (Bên phải) -->
                <div class="w-full lg:w-4/12">
                    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-6 shadow-comic-lg dark:shadow-comic-lg-dark flex flex-col gap-6 sticky top-28 transform rotate-1 transition-colors">
                        
                        <div class="bg-secondary dark:bg-yellow-700 border-4 border-black dark:border-white p-4 shadow-comic dark:shadow-comic-dark transform -rotate-1">
                            <h4 class="font-comic text-2xl text-dark dark:text-white tracking-wider mb-1">TỔNG ĐƠN HÀNG:</h4>
                            <p class="font-bold text-gray-700 dark:text-gray-200 text-sm">Vui lòng rà soát kỹ lưỡng danh sách truyện trước khi tiến hành thanh toán!</p>
                        </div>
                        
                        <!-- Chi tiết thanh toán -->
                        <div class="flex flex-col gap-4 border-b-4 border-black dark:border-white pb-4">
                            <div class="flex justify-between items-center">
                                <span class="font-black text-gray-500 dark:text-gray-400 uppercase text-xs">Tổng số lượng</span>
                                <span class="font-black text-dark dark:text-white text-lg summary-cart-size">${sessionScope.cartSize} cuốn</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="font-black text-gray-500 dark:text-gray-400 uppercase text-xs">Phí vận chuyển</span>
                                <span class="font-comic text-accent text-lg tracking-wider" style="-webkit-text-stroke: 0.5px black;">FREE SHIP</span>
                            </div>
                        </div>
                        
                        <!-- Tổng cộng -->
                        <div class="flex justify-between items-center mb-2">
                            <span class="font-black text-dark dark:text-white uppercase text-sm">Tổng thanh toán</span>
                            <div class="font-comic text-3xl text-primary tracking-widest" style="-webkit-text-stroke: 1px black;">
                                <span class="summary-total-amount"><fmt:formatNumber value="${totalCartAmount}" pattern="#,###" /></span>đ
                            </div>
                        </div>
                        
                        <!-- Nút hành động -->
                        <div class="flex flex-col gap-4">
                            <a href="${pageContext.request.contextPath}/customer?action=checkout" 
                               class="w-full bg-accent dark:bg-teal-700 border-4 border-black dark:border-white text-dark dark:text-white font-comic text-3xl tracking-widest py-3 rounded shadow-comic-lg dark:shadow-comic-lg-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-white dark:hover:bg-gray-700 transition-all uppercase flex items-center justify-center gap-2"
                               style="-webkit-text-stroke: 1px black;">
                                MÚC LUÔN!
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/customer" 
                               class="w-full bg-white dark:bg-gray-700 border-4 border-black dark:border-white text-dark dark:text-white font-comic text-xl tracking-widest py-3 rounded shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-gray-100 dark:hover:bg-gray-600 transition-all uppercase text-center flex items-center justify-center">
                                TIẾP TỤC HỐT TRUYỆN
                            </a>
                        </div>
                        
                    </div>
                </div>
                
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- AJAX Dynamic Handling Script -->
<script>
document.addEventListener('DOMContentLoaded', () => {
    function formatNumber(num) {
        return new Intl.NumberFormat('vi-VN').format(num);
    }

    // Dynamic cart operations delegation
    document.addEventListener('click', async (e) => {
        const updateBtn = e.target.closest('.btn-update-qty');
        const removeBtn = e.target.closest('.btn-remove-item');
        
        if (updateBtn) {
            e.preventDefault();
            const url = updateBtn.getAttribute('href') + '&ajax=true';
            const itemId = updateBtn.getAttribute('data-id');
            const row = document.querySelector('.cart-item-row[data-id="' + itemId + '"]');
            if (!row) return;

            try {
                const response = await fetch(url);
                const data = await response.json();
                
                if (data.success) {
                    // Update header cart badge
                    const headerBadge = document.getElementById('header-cart-badge');
                    if (headerBadge) {
                        headerBadge.textContent = data.cartSize;
                    }
                    
                    if (data.cartSize === 0) {
                        location.reload();
                        return;
                    }
                    
                    if (data.itemTotalPrice === 0) {
                        // Fade and remove row
                        row.style.opacity = '0';
                        row.style.transform = 'scale(0.95)';
                        row.style.transition = 'all 0.3s ease';
                        setTimeout(() => {
                            row.remove();
                        }, 300);
                    } else {
                        // Update quantity text
                        const qtyDisplay = row.querySelector('.quantity-display');
                        const priceDisplay = row.querySelector('.item-total-price');
                        
                        const urlParams = new URLSearchParams(updateBtn.getAttribute('href').split('?')[1]);
                        const currentQty = parseInt(urlParams.get('quantity'));
                        
                        qtyDisplay.textContent = currentQty;
                        priceDisplay.textContent = formatNumber(data.itemTotalPrice);
                        
                        // Update URLs of the button links dynamically
                        const decBtn = row.querySelector('.btn-update-qty[data-type="dec"]');
                        const incBtn = row.querySelector('.btn-update-qty[data-type="inc"]');
                        const contextPath = '${pageContext.request.contextPath}';
                        
                        decBtn.setAttribute('href', contextPath + '/customer?action=update-cart&id=' + itemId + '&quantity=' + (currentQty - 1));
                        incBtn.setAttribute('href', contextPath + '/customer?action=update-cart&id=' + itemId + '&quantity=' + (currentQty + 1));
                    }
                    
                    // Update Right Summary Panel
                    const summarySize = document.querySelector('.summary-cart-size');
                    const summaryTotal = document.querySelector('.summary-total-amount');
                    if (summarySize) summarySize.textContent = data.cartSize + ' cuốn';
                    if (summaryTotal) summaryTotal.textContent = formatNumber(data.totalCartAmount);
                    
                    if (typeof showToast === 'function') showToast("Đã cập nhật giỏ hàng!", 'success');
                }
            } catch (err) {
                console.error('Error updating cart:', err);
            }
        }
        
        if (removeBtn) {
            e.preventDefault();
            const url = removeBtn.getAttribute('href') + '&ajax=true';
            const itemId = removeBtn.getAttribute('data-id');
            const row = document.querySelector('.cart-item-row[data-id="' + itemId + '"]');
            if (!row) return;

            try {
                const response = await fetch(url);
                const data = await response.json();
                
                if (data.success) {
                    const headerBadge = document.getElementById('header-cart-badge');
                    if (headerBadge) {
                        headerBadge.textContent = data.cartSize;
                    }
                    
                    if (data.cartSize === 0) {
                        location.reload();
                        return;
                    }
                    
                    row.style.opacity = '0';
                    row.style.transform = 'scale(0.95)';
                    row.style.transition = 'all 0.3s ease';
                    setTimeout(() => {
                        row.remove();
                    }, 300);
                    
                    const summarySize = document.querySelector('.summary-cart-size');
                    const summaryTotal = document.querySelector('.summary-total-amount');
                    if (summarySize) summarySize.textContent = data.cartSize + ' cuốn';
                    if (summaryTotal) summaryTotal.textContent = formatNumber(data.totalCartAmount);
                    
                    if (typeof showToast === 'function') showToast("Đã xóa truyện khỏi giỏ!", 'error');
                }
            } catch (err) {
                console.error('Error removing item from cart:', err);
            }
        }
    });
});
</script>
