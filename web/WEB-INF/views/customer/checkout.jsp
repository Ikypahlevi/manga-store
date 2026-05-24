<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="max-w-4xl mx-auto mb-16 px-4">
    
    <!-- Tiêu đề -->
    <div class="mb-10 text-center">
        <div class="inline-block bg-accent dark:bg-teal-700 border-4 border-black dark:border-white px-6 py-2 transform -rotate-2 shadow-comic dark:shadow-comic-dark mb-4">
            <span class="font-black text-xl text-dark dark:text-white tracking-widest">BƯỚC CUỐI CÙNG!</span>
        </div>
        <h1 class="text-5xl md:text-6xl font-comic text-dark dark:text-white tracking-wider uppercase"
            style="-webkit-text-stroke: 2px black; text-shadow: 4px 4px 0 #06D6A0;">
            CHỐT ĐƠN SIÊU TỐC
        </h1>
    </div>

    <!-- Cảnh báo chưa đăng nhập -->
    <c:if test="${empty sessionScope.user}">
        <div class="bg-primary dark:bg-red-800 border-4 border-black dark:border-white p-4 mb-8 flex items-center justify-between shadow-comic dark:shadow-comic-dark transform rotate-1 transition-colors">
            <div class="flex items-center gap-3 text-white">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span class="font-black text-lg">HẸP! Đăng nhập để đơn hàng được lưu vào hồ sơ VIP nhé!</span>
            </div>
            <a href="${pageContext.request.contextPath}/auth?action=login" class="bg-white dark:bg-gray-700 text-dark dark:text-white font-black px-4 py-2 border-2 border-black dark:border-white hover:bg-secondary dark:hover:bg-yellow-600 transition shadow-comic dark:shadow-comic-dark uppercase text-sm">
                Đăng Nhập Ngay
            </a>
        </div>
    </c:if>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        
        <!-- Form Thông tin Giao hàng -->
        <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-8 shadow-comic-lg dark:shadow-comic-lg-dark flex flex-col transition-colors">
            <h2 class="text-3xl font-comic text-dark dark:text-white border-b-4 border-black dark:border-white pb-3 mb-6 uppercase">Thông Tin Phóng Ship</h2>
            
            <form action="${pageContext.request.contextPath}/customer" method="POST" id="checkout-form" class="flex flex-col gap-5" novalidate>
                <input type="hidden" name="action" value="place-order" />
                
                <div class="flex flex-col">
                    <label class="font-black text-dark dark:text-white uppercase mb-1">Tên Người Nhận <span class="text-primary">*</span></label>
                    <input type="text" id="customerName" name="customerName" required minlength="2" placeholder="Ví dụ: Lufy Mũ Rơm"
                           class="w-full bg-gray-50 dark:bg-gray-700 border-4 border-black dark:border-white p-3 font-bold text-dark dark:text-white focus:bg-yellow-50 dark:focus:bg-gray-600 focus:outline-none focus:-translate-y-1 focus:shadow-comic dark:focus:shadow-comic-dark transition-all" />
                </div>
                
                <div class="flex flex-col">
                    <label class="font-black text-dark dark:text-white uppercase mb-1">Số Điện Thoại Gọi Cửa <span class="text-primary">*</span></label>
                    <input type="text" id="customerPhone" name="customerPhone" required pattern="(84|0[3|5|7|8|9])+([0-9]{8})\b" placeholder="0987xxxxxx"
                           class="w-full bg-gray-50 dark:bg-gray-700 border-4 border-black dark:border-white p-3 font-bold text-dark dark:text-white focus:bg-yellow-50 dark:focus:bg-gray-600 focus:outline-none focus:-translate-y-1 focus:shadow-comic dark:focus:shadow-comic-dark transition-all" />
                </div>
                
                <div class="flex flex-col flex-grow">
                    <label class="font-black text-dark dark:text-white uppercase mb-1">Địa Chỉ Bàn Giao Cụ Thể <span class="text-primary">*</span></label>
                    <textarea id="customerAddress" name="customerAddress" required minlength="5" rows="3" placeholder="Ghi rõ số nhà, ngõ ngách, tọa độ..."
                              class="w-full bg-gray-50 dark:bg-gray-700 border-4 border-black dark:border-white p-3 font-bold text-dark dark:text-white focus:bg-yellow-50 dark:focus:bg-gray-600 focus:outline-none focus:-translate-y-1 focus:shadow-comic dark:focus:shadow-comic-dark transition-all resize-none"></textarea>
                </div>

                <div class="flex flex-col mt-2">
                    <label class="font-black text-dark dark:text-white uppercase mb-2">Phương thức thanh toán <span class="text-primary">*</span></label>
                    <div class="flex flex-col gap-3">
                        <label class="flex items-center gap-3 p-3 border-4 border-black dark:border-white bg-gray-50 dark:bg-gray-700 cursor-pointer hover:bg-yellow-50 dark:hover:bg-gray-600 transition-colors shadow-sm">
                            <input type="radio" name="paymentMethod" value="COD" checked class="w-5 h-5 text-primary focus:ring-primary border-black">
                            <span class="font-bold text-dark dark:text-white uppercase">Thanh toán khi nhận hàng (COD)</span>
                        </label>
                        <label class="flex items-center gap-3 p-3 border-4 border-black dark:border-white bg-gray-50 dark:bg-gray-700 cursor-pointer hover:bg-yellow-50 dark:hover:bg-gray-600 transition-colors shadow-sm">
                            <input type="radio" name="paymentMethod" value="QR" class="w-5 h-5 text-primary focus:ring-primary border-black">
                            <span class="font-bold text-dark dark:text-white uppercase flex items-center gap-2">
                                <svg class="w-6 h-6 text-accent" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v1m6 11h2m-6 0h-2v4m0-11v3m0 0h.01M12 12h4.01M16 20h4M4 12h4m12 0h.01M5 8h2a1 1 0 001-1V5a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1zm14 0h2a1 1 0 001-1V5a1 1 0 00-1-1h-2a1 1 0 00-1 1v2a1 1 0 001 1zM5 20h2a1 1 0 001-1v-2a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1z"></path></svg>
                                Chuyển khoản quét mã QR (VNPay/MoMo)
                            </span>
                        </label>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Tổng Kết Giỏ Hàng Mua -->
        <div class="bg-secondary dark:bg-yellow-700 border-4 border-black dark:border-white p-8 shadow-comic-lg dark:shadow-comic-lg-dark flex flex-col transform -rotate-1 transition-colors">
            <h2 class="text-3xl font-comic text-dark dark:text-white border-b-4 border-black dark:border-white pb-3 mb-6 uppercase">Đơn Hàng Của Bạn</h2>
            
            <div class="flex-grow flex flex-col gap-4 overflow-y-auto max-h-64 mb-6 pr-2">
                <c:set var="totalCheckoutAmount" value="0.0" />
                <c:forEach items="${sessionScope.cart.values()}" var="item">
                    <c:set var="totalCheckoutAmount" value="${totalCheckoutAmount + item.totalPrice}" />
                    <div class="flex justify-between items-center border-b-2 border-black dark:border-white border-dashed pb-3">
                        <div class="flex items-center gap-3 w-2/3">
                            <span class="font-black text-primary dark:text-red-400 bg-white dark:bg-gray-800 border-2 border-black dark:border-white px-2 py-0.5 shadow-comic dark:shadow-comic-dark text-xs">x${item.quantity}</span>
                            <span class="font-bold text-dark dark:text-white truncate uppercase text-sm">${item.sach.tenSach}</span>
                        </div>
                        <span class="font-black text-dark dark:text-white"><fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />đ</span>
                    </div>
                </c:forEach>
            </div>
            
            <div class="mt-auto">
                <!-- Voucher Form -->
                <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-4 shadow-comic dark:shadow-comic-dark mb-4 transition-colors">
                    <label class="font-black text-dark dark:text-white uppercase mb-2 block">MÃ KHUYẾN MÃI</label>
                    <div class="flex gap-2">
                        <input type="text" id="voucherCode" placeholder="Nhập mã..." class="flex-grow bg-white dark:bg-gray-700 text-dark dark:text-white border-4 border-black dark:border-white p-2 font-bold focus:outline-none focus:bg-yellow-50 dark:focus:bg-gray-600 uppercase" />
                        <button type="button" id="btnApplyVoucher" class="bg-dark text-white font-black px-4 py-2 border-4 border-black dark:border-white hover:bg-primary transition-colors uppercase">ÁP DỤNG</button>
                    </div>
                    <div id="voucherMessage" class="mt-2 text-sm font-bold hidden"></div>
                </div>

                <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-4 shadow-comic dark:shadow-comic-dark transform rotate-1 mb-6 transition-colors text-dark dark:text-white">
                    <div class="flex justify-between items-center mb-2">
                        <span class="font-black text-gray-500 dark:text-gray-400 uppercase">Tạm tính</span>
                        <span class="font-bold"><fmt:formatNumber value="${totalCheckoutAmount}" pattern="#,###" />đ</span>
                    </div>
                    <div class="flex justify-between items-center border-b-2 border-gray-300 dark:border-gray-600 pb-2 mb-2">
                        <span class="font-black text-gray-500 dark:text-gray-400 uppercase">Phí Hỏa Tốc</span>
                        <span class="font-black text-accent dark:text-teal-400 uppercase">FREE</span>
                    </div>

                    <c:set var="rankDiscountPercent" value="0" />
                    <c:if test="${sessionScope.user != null}">
                        <c:choose>
                            <c:when test="${sessionScope.user.rankTier == 'HACHIMAN'}"><c:set var="rankDiscountPercent" value="10" /></c:when>
                            <c:when test="${sessionScope.user.rankTier == 'WIBU CHÚA'}"><c:set var="rankDiscountPercent" value="8" /></c:when>
                            <c:when test="${sessionScope.user.rankTier == 'WIBU CHUẨN'}"><c:set var="rankDiscountPercent" value="2" /></c:when>
                        </c:choose>
                    </c:if>
                    <c:set var="rankDiscountAmount" value="${totalCheckoutAmount * rankDiscountPercent / 100}" />
                    <c:set var="totalAfterRank" value="${totalCheckoutAmount - rankDiscountAmount}" />

                    <c:if test="${rankDiscountPercent > 0}">
                        <div class="flex justify-between items-center border-b-2 border-gray-300 dark:border-gray-600 pb-2 mb-2">
                            <span class="font-black text-accent dark:text-teal-400 uppercase">Đặc Quyền ${sessionScope.user.rankTier} (-${rankDiscountPercent}%)</span>
                            <span class="font-black text-accent dark:text-teal-400 uppercase">-<fmt:formatNumber value="${rankDiscountAmount}" pattern="#,###" />đ</span>
                        </div>
                    </c:if>

                    <div id="discountRow" class="flex justify-between items-center border-b-2 border-gray-300 dark:border-gray-600 pb-2 mb-2 hidden">
                        <span class="font-black text-primary dark:text-red-400 uppercase">Giảm Giá Voucher</span>
                        <span id="discountText" class="font-black text-primary dark:text-red-400 uppercase">-0đ</span>
                    </div>
                    <div class="flex justify-between items-end">
                        <span class="font-black text-dark dark:text-white text-xl uppercase">Thành Tiền</span>
                        <span id="finalTotalText" class="font-comic text-4xl text-primary" style="-webkit-text-stroke: 1px black;" data-original="${totalAfterRank}">
                            <fmt:formatNumber value="${totalAfterRank}" pattern="#,###" />đ
                        </span>
                    </div>
                </div>
                
                <input type="hidden" form="checkout-form" name="appliedVoucherCode" id="appliedVoucherCode" value="">
                <input type="hidden" form="checkout-form" name="discountAmount" id="discountAmountInput" value="0">
                <input type="hidden" form="checkout-form" name="finalTotal" id="finalTotalInput" value="${totalCheckoutAmount}">
                
                <button type="submit" form="checkout-form" class="w-full bg-primary dark:bg-red-800 border-4 border-black dark:border-white text-white font-comic text-3xl tracking-widest py-4 rounded shadow-comic-lg dark:shadow-comic-lg-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-dark transition-all uppercase flex items-center justify-center gap-3">
                    XÁC NHẬN CHỐT ĐƠN!
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                </button>
            </div>
        </div>
        
    </div>
</div>

<!-- SHATTER EFFECT OVERLAY -->
<div id="shatterOverlay" class="fixed inset-0 z-[9999] bg-dark flex items-center justify-center hidden opacity-0 transition-opacity duration-300 pointer-events-none">
    <div class="relative w-full h-full flex items-center justify-center overflow-hidden">
        <!-- Lines for cracks -->
        <div id="shatterCracks" class="absolute inset-0 opacity-0 transition-opacity duration-100">
            <svg class="w-full h-full" xmlns="http://www.w3.org/2000/svg">
                <line x1="50%" y1="50%" x2="0" y2="0" stroke="white" stroke-width="4" />
                <line x1="50%" y1="50%" x2="100%" y2="0" stroke="white" stroke-width="4" />
                <line x1="50%" y1="50%" x2="0" y2="100%" stroke="white" stroke-width="4" />
                <line x1="50%" y1="50%" x2="100%" y2="100%" stroke="white" stroke-width="4" />
                <line x1="50%" y1="50%" x2="0" y2="50%" stroke="white" stroke-width="4" />
                <line x1="50%" y1="50%" x2="100%" y2="50%" stroke="white" stroke-width="4" />
            </svg>
        </div>
        <h1 class="text-7xl md:text-9xl font-comic text-white uppercase tracking-widest z-10 scale-0 transition-transform duration-[800ms] cubic-bezier(0.175, 0.885, 0.32, 1.275)" id="shatterText" style="-webkit-text-stroke: 4px black; text-shadow: 10px 10px 0 #06D6A0;">CHỐT ĐƠN!</h1>
    </div>
</div>

<!-- QR PAYMENT MODAL -->
<div id="qrPaymentModal" class="fixed inset-0 z-[200] bg-black/90 hidden flex-col items-center justify-center p-4">
    <div class="bg-white border-[8px] border-black p-8 max-w-sm w-full flex flex-col items-center shadow-[16px_16px_0_0_#06D6A0] transform rotate-1 relative">
        <h2 class="font-comic text-3xl text-center uppercase mb-4" style="-webkit-text-stroke: 1px black;">Quét Mã Nhanh</h2>
        <div class="bg-gray-100 p-4 border-4 border-black w-full flex justify-center mb-4 relative">
            <div class="absolute inset-0 border-4 border-accent border-dashed animate-pulse pointer-events-none"></div>
            <!-- Sử dụng API qrserver để tạo QR ngẫu nhiên chứa thông tin thanh toán giả lập -->
            <img id="qrImage" src="" alt="Mã QR Thanh Toán" class="w-48 h-48 object-contain">
        </div>
        <p class="font-bold text-center text-sm mb-2 uppercase text-gray-600">Nội dung chuyển khoản:</p>
        <div class="bg-yellow-200 border-4 border-black font-black text-xl px-4 py-2 mb-6 uppercase text-center w-full tracking-widest">
            MUASACH <span id="qrCustomerName"></span>
        </div>
        <button type="button" id="btnConfirmQR" class="w-full bg-primary border-4 border-black text-white font-black text-xl py-3 hover:bg-dark hover:text-primary transition-colors uppercase shadow-[4px_4px_0_0_#000]">
            Tôi Đã Chuyển Khoản
        </button>
        <button type="button" id="btnCancelQR" class="mt-4 font-bold text-gray-500 hover:text-black uppercase text-sm underline tracking-wide">
            Hủy & Đổi Phương Thức
        </button>

        <!-- Loading Overlay for Modal -->
        <div id="qrLoadingOverlay" class="absolute inset-0 bg-white/95 z-10 hidden flex-col items-center justify-center border-[8px] border-black">
            <svg class="animate-spin h-16 w-16 text-primary mb-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            <p class="font-black text-2xl text-center uppercase animate-pulse text-dark">Đang xác nhận<br>giao dịch...</p>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const btnApply = document.getElementById('btnApplyVoucher');
    const inputCode = document.getElementById('voucherCode');
    const msgDiv = document.getElementById('voucherMessage');
    const discountRow = document.getElementById('discountRow');
    const discountText = document.getElementById('discountText');
    const finalTotalText = document.getElementById('finalTotalText');
    
    const hiddenVoucher = document.getElementById('appliedVoucherCode');
    const hiddenDiscount = document.getElementById('discountAmountInput');
    const hiddenTotal = document.getElementById('finalTotalInput');
    
    let originalTotal = parseFloat(finalTotalText.getAttribute('data-original'));

    btnApply.addEventListener('click', async () => {
        const code = inputCode.value.trim();
        if (!code) return;
        
        try {
            const res = await fetch('${pageContext.request.contextPath}/customer?action=apply-voucher&code=' + encodeURIComponent(code));
            const data = await res.json();
            
            msgDiv.classList.remove('hidden');
            if (data.success) {
                msgDiv.className = 'mt-2 text-sm font-bold text-accent';
                msgDiv.textContent = data.message;
                
                discountRow.classList.remove('hidden');
                discountText.textContent = '-' + data.discountAmount.toLocaleString('vi-VN') + 'đ';
                finalTotalText.textContent = data.newTotal.toLocaleString('vi-VN') + 'đ';
                
                hiddenVoucher.value = data.code;
                hiddenDiscount.value = data.discountAmount;
                hiddenTotal.value = data.newTotal;
            } else {
                msgDiv.className = 'mt-2 text-sm font-bold text-primary';
                msgDiv.textContent = data.message;
                
                discountRow.classList.add('hidden');
                finalTotalText.textContent = originalTotal.toLocaleString('vi-VN') + 'đ';
                
                hiddenVoucher.value = '';
                hiddenDiscount.value = '0';
                hiddenTotal.value = originalTotal;
            }
        } catch (e) {
            console.error('Error applying voucher:', e);
        }
    });

    // --- QR PAYMENT FAKE LOGIC ---
    const form = document.getElementById('checkout-form');
    const qrModal = document.getElementById('qrPaymentModal');
    const btnConfirmQR = document.getElementById('btnConfirmQR');
    const btnCancelQR = document.getElementById('btnCancelQR');
    const qrImage = document.getElementById('qrImage');
    const qrCustomerName = document.getElementById('qrCustomerName');
    const qrLoadingOverlay = document.getElementById('qrLoadingOverlay');
    
    let isQRPaid = false; // flag to allow actual submission after QR fake payment

    form.addEventListener('submit', (e) => {
        // --- VALIDATION LOGIC ---
        const n = document.getElementById('customerName');
        const p = document.getElementById('customerPhone');
        const a = document.getElementById('customerAddress');
        let errorMsg = '';
        
        [n, p, a].forEach(el => el.classList.remove('border-primary'));
        
        if (!n.value.trim() || n.value.trim().length < 2) {
            errorMsg = 'Tên người nhận phải từ 2 ký tự!';
            n.classList.add('border-primary');
            n.focus();
        } else if (!p.value.trim() || !/^(84|0[3|5|7|8|9])+([0-9]{8})\b$/.test(p.value.trim())) {
            errorMsg = 'Số điện thoại không hợp lệ (vd: 0987654321)!';
            p.classList.add('border-primary');
            p.focus();
        } else if (!a.value.trim() || a.value.trim().length < 5) {
            errorMsg = 'Địa chỉ phải từ 5 ký tự!';
            a.classList.add('border-primary');
            a.focus();
        }
        
        if (errorMsg) {
            e.preventDefault();
            if(typeof showToast === 'function') showToast(errorMsg, 'error');
            else alert(errorMsg);
            return;
        }

        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        if (paymentMethod === 'QR' && !isQRPaid) {
            e.preventDefault(); // Stop normal submit
            
            // Generate QR url (total amount & mock momo number)
            const currentTotal = document.getElementById('finalTotalInput').value;
            let customerNameInput = document.querySelector('input[name="customerName"]').value;
            let customerName = customerNameInput.replace(/\s+/g, '').substring(0, 10).toUpperCase();
            if(!customerName) customerName = "VIP";
            
            qrImage.src = `https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=MOMO|0987654321|` + currentTotal + `|MUASACH` + customerName;
            qrCustomerName.textContent = customerName;
            
            // Show modal
            qrModal.classList.remove('hidden');
            qrModal.classList.add('flex');
            document.body.style.overflow = 'hidden';
        } else if (paymentMethod === 'COD') {
            e.preventDefault(); // Stop normal submit to play effect
            playShatterEffect(() => {
                form.submit();
            });
        }
    });

    function playShatterEffect(callback) {
        const overlay = document.getElementById('shatterOverlay');
        const text = document.getElementById('shatterText');
        const cracks = document.getElementById('shatterCracks');
        
        overlay.classList.remove('hidden');
        document.body.style.overflow = 'hidden';
        
        // Fade in overlay
        setTimeout(() => {
            overlay.classList.remove('opacity-0');
            overlay.classList.add('opacity-100');
            
            // Flash cracks
            setTimeout(() => {
                cracks.classList.remove('opacity-0');
                cracks.classList.add('opacity-100');
                
                // Pop text
                setTimeout(() => {
                    cracks.classList.add('opacity-0');
                    text.classList.remove('scale-0');
                    text.classList.add('scale-100');
                    text.classList.add('rotate-3');
                    
                    // Wait then submit
                    setTimeout(() => {
                        callback();
                    }, 1200);
                }, 150);
            }, 300);
        }, 50);
    }

    btnCancelQR.addEventListener('click', () => {
        qrModal.classList.add('hidden');
        qrModal.classList.remove('flex');
        document.body.style.overflow = '';
    });

    btnConfirmQR.addEventListener('click', () => {
        // Show loading
        qrLoadingOverlay.classList.remove('hidden');
        qrLoadingOverlay.classList.add('flex');
        
        setTimeout(() => {
            // Fake success and submit form
            qrLoadingOverlay.innerHTML = `
                <svg class="w-24 h-24 text-accent mb-6 transform hover:scale-110 transition-transform" fill="none" stroke="black" stroke-width="2" viewBox="0 0 24 24">
                    <path fill="#06D6A0" stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <p class="font-black text-3xl text-center uppercase text-accent" style="-webkit-text-stroke: 1px black;">Chuyển tiền<br>thành công!</p>
            `;
            setTimeout(() => {
                isQRPaid = true;
                qrModal.classList.add('hidden');
                qrModal.classList.remove('flex');
                document.body.style.overflow = '';
                
                playShatterEffect(() => {
                    form.submit();
                });
            }, 1500);
        }, 2500); // Fake waiting for bank API for 2.5s
    });
});
</script>
