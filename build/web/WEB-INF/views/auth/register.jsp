<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="flex items-center justify-center py-12 px-4 w-full">
    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-8 shadow-comic-lg dark:shadow-comic-lg-dark w-full max-w-md transform -rotate-1 transition-colors">
        
        <div class="text-center mb-8 border-b-4 border-black dark:border-white pb-4 transform rotate-1">
            <h2 class="text-4xl font-comic text-dark dark:text-white tracking-widest uppercase"
                style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #06D6A0;">
                ĐĂNG KÝ
            </h2>
            <p class="font-black text-xs text-gray-500 dark:text-gray-400 mt-1 uppercase">Gia nhập liên minh fan truyện tranh đích thực</p>
        </div>
        
        <form id="registerForm" action="${pageContext.request.contextPath}/auth" method="POST" class="space-y-5" novalidate>
            <input type="hidden" name="action" value="register">
            
            <div>
                <label class="block text-sm font-black text-dark dark:text-white uppercase mb-2">Tên đăng nhập</label>
                <input type="text" name="username" required minlength="3"
                    class="w-full px-4 py-3 border-4 border-black dark:border-white font-bold text-dark dark:text-white rounded bg-white dark:bg-gray-700 shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark focus:translate-y-0.5 focus:translate-x-0.5 outline-none transition-all placeholder:text-gray-400"
                    placeholder="Chọn tên đăng nhập độc nhất (>= 3 ký tự)"
                    value="${username}">
            </div>
            
            <div>
                <label class="block text-sm font-black text-dark dark:text-white uppercase mb-2">Mật khẩu</label>
                <input type="password" name="password" required minlength="3"
                    class="w-full px-4 py-3 border-4 border-black dark:border-white font-bold text-dark dark:text-white rounded bg-white dark:bg-gray-700 shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark focus:translate-y-0.5 focus:translate-x-0.5 outline-none transition-all placeholder:text-gray-400"
                    placeholder="Mật khẩu của bạn (>= 3 ký tự)">
            </div>
            
            <div>
                <label class="block text-sm font-black text-dark dark:text-white uppercase mb-2">Xác nhận mật khẩu</label>
                <input type="password" name="confirmPassword" required
                    class="w-full px-4 py-3 border-4 border-black dark:border-white font-bold text-dark dark:text-white rounded bg-white dark:bg-gray-700 shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark focus:translate-y-0.5 focus:translate-x-0.5 outline-none transition-all placeholder:text-gray-400"
                    placeholder="Gõ lại mật khẩu để xác nhận">
            </div>
            
            <button type="submit"
                class="w-full bg-accent dark:bg-teal-700 border-4 border-black dark:border-white text-dark dark:text-white font-comic text-2xl tracking-widest py-3 rounded shadow-comic-lg dark:shadow-comic-lg-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-secondary dark:hover:bg-yellow-600 transition-all uppercase flex items-center justify-center gap-2"
                style="-webkit-text-stroke: 0.5px black;">
                ĐĂNG KÝ TÀI KHOẢN!
            </button>
            
            <div class="text-center pt-4 border-t-2 border-dashed border-black dark:border-white">
                <span class="font-black text-sm text-gray-500 dark:text-gray-400 uppercase">Đã là thành viên?</span>
                <a href="${pageContext.request.contextPath}/auth?action=login" 
                   class="inline-block ml-1 font-black text-sm text-primary dark:text-red-400 uppercase hover:underline decoration-2">
                    ĐĂNG NHẬP NGAY!
                </a>
            </div>
        </form>

        <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const u = document.querySelector('input[name="username"]');
            const p = document.querySelector('input[name="password"]');
            const cp = document.querySelector('input[name="confirmPassword"]');
            let errorMsg = '';
            
            [u, p, cp].forEach(el => el.classList.remove('border-primary'));
            
            if (!u.value.trim() || u.value.trim().length < 3) {
                errorMsg = 'Tên đăng nhập phải từ 3 ký tự trở lên!';
                u.classList.add('border-primary');
                u.focus();
            } else if (!p.value || p.value.length < 3) {
                errorMsg = 'Mật khẩu phải từ 3 ký tự trở lên!';
                p.classList.add('border-primary');
                p.focus();
            } else if (p.value !== cp.value) {
                errorMsg = 'Xác nhận mật khẩu không khớp!';
                cp.classList.add('border-primary');
                cp.focus();
            }
            
            if (errorMsg) {
                e.preventDefault();
                if(typeof showToast === 'function') {
                    showToast(errorMsg, 'error');
                } else {
                    alert(errorMsg);
                }
            }
        });
        </script>
    </div>
</div>
