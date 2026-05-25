<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        </main>
    </div> <!-- Close flex wrap -->

    <!-- Footer Comic Style -->
    <footer class="bg-primary dark:bg-red-900 text-white border-t-4 border-black dark:border-white mt-auto relative overflow-hidden transition-colors" data-aos="fade-up">
        <!-- Đường viền dích dắc / chấm bi trang trí nếu cần -->
        <div class="max-w-screen-2xl mx-auto px-4 md:px-8 py-12 relative z-10">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                
                <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-6 shadow-comic dark:shadow-comic-dark transform -rotate-1">
                    <h3 class="text-3xl font-comic text-dark dark:text-white mb-4 tracking-wide">VỀ MANGA STORE</h3>
                    <p class="text-dark dark:text-gray-300 font-bold">Căn cứ điểm của mọi Wibu! Nơi cập nhật truyện mới nhanh nhất hệ mặt trời. Mua ngay kẻo lỡ!</p>
                </div>
                
                <div class="bg-secondary dark:bg-yellow-600 border-4 border-black dark:border-white p-6 shadow-comic dark:shadow-comic-dark transform rotate-1">
                    <h3 class="text-3xl font-comic text-dark dark:text-white mb-4 tracking-wide">LUẬT LÀNG</h3>
                    <ul class="space-y-2 text-dark dark:text-white font-black">
                        <li>🔥 Đọc ké bị bế lên phường</li>
                        <li>🔥 Hàng mua rồi không đổi trả</li>
                        <li>🔥 Nhớ bọc bìa truyện cẩn thận</li>
                    </ul>
                </div>
                
                <div class="bg-accent dark:bg-teal-700 border-4 border-black dark:border-white p-6 shadow-comic dark:shadow-comic-dark transform -rotate-2">
                    <h3 class="text-3xl font-comic text-dark dark:text-white mb-4 tracking-wide">TỔNG ĐÀI GỌI HỘI</h3>
                    <ul class="space-y-2 text-dark dark:text-white font-black">
                        <li>📍 Ngõ 123 Làng Mộc Diệp</li>
                        <li>📞 0999-WIBU-NEVER-DIE</li>
                        <li>✉️ manga@shop.vn</li>
                    </ul>
                </div>

            </div>
            
            <div class="mt-12 text-center text-white font-black text-xl bg-black inline-block px-4 py-2 border-2 border-white transform rotate-1">
                &copy; 2026 MANGA STORE CO., LTD.
            </div>
        </div>
    </footer>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
    <script>
        // --- ÂM THANH VIP PRO MAX ---
        const popSound = new Audio('https://actions.google.com/sounds/v1/cartoon/pop.ogg');
        const clickSound = new Audio('https://actions.google.com/sounds/v1/cartoon/punch_thick.ogg');
        const successSound = new Audio('https://actions.google.com/sounds/v1/cartoon/clang_and_wobble.ogg');
        
        document.addEventListener('DOMContentLoaded', function() {
            AOS.init({
                duration: 800,
                easing: 'ease-out-back',
                once: true,
                offset: 50
            });
            
            // Gắn sự kiện âm thanh cho tất cả nút bấm và link
            document.querySelectorAll('a, button, input[type="submit"], input[type="button"], .btn').forEach(btn => {
                btn.addEventListener('mouseenter', () => {
                    let s = popSound.cloneNode(); s.volume = 0.1; s.play().catch(()=>{});
                });
                btn.addEventListener('mousedown', () => {
                    let s = clickSound.cloneNode(); s.volume = 0.3; s.play().catch(()=>{});
                });
            });
        });

        function showToast(message, type = 'success') {
            const oldToast = document.getElementById('neo-toast');
            if (oldToast) oldToast.remove();

            const isSuccess = type === 'success';
            const toast = document.createElement('div');
            toast.id = 'neo-toast';

            // Toast nhỏ gọn ở góc dưới
            toast.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 99999;
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px 20px;
                background: ${isSuccess ? '#06D6A0' : '#E63946'};
                color: ${isSuccess ? '#111827' : '#FFFFFF'};
                border: 3px solid #000;
                box-shadow: 4px 4px 0px 0px rgba(0,0,0,1);
                transform: translateY(100px);
                opacity: 0;
                transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
                font-family: 'Nunito', sans-serif;
                max-width: 300px;
            `;

            const icon = document.createElement('div');
            icon.style.cssText = `
                font-size: 1.5rem;
                line-height: 1;
                flex-shrink: 0;
            `;
            icon.textContent = isSuccess ? '✅' : '❌';

            const text = document.createElement('div');
            text.style.cssText = `
                font-weight: 800;
                font-size: 0.95rem;
                text-transform: uppercase;
                letter-spacing: 0.02em;
                line-height: 1.2;
            `;
            text.textContent = message;

            toast.appendChild(icon);
            toast.appendChild(text);
            document.body.appendChild(toast);

            // Bắn pháo hoa và âm thanh nếu thành công!
            if(isSuccess) {
                let s = successSound.cloneNode(); s.volume = 0.4; s.play().catch(()=>{});
                confetti({
                    particleCount: 150,
                    spread: 80,
                    origin: { y: 0.6 },
                    colors: ['#FFD166', '#06D6A0', '#EF476F', '#118AB2'],
                    zIndex: 999999
                });
            }

            // Animate in
            setTimeout(() => {
                toast.style.transform = 'translateY(0)';
                toast.style.opacity = '1';
            }, 10);

            // Auto hide
            setTimeout(() => {
                toast.style.transform = 'translateY(100px)';
                toast.style.opacity = '0';
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
        
        // Hiển thị toast từ JSP variables nếu có
        <c:if test="${not empty message}">
            showToast('${message}', 'success');
        </c:if>
        <c:if test="${not empty error}">
            showToast('${error}', 'error');
        </c:if>
    </script>
</body>
</html>
