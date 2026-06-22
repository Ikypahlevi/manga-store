<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="flex items-center justify-center py-12 px-4 w-full">
    <div class="bg-white dark:bg-gray-800 border-4 border-black dark:border-white p-8 shadow-comic-lg dark:shadow-comic-lg-dark w-full max-w-md transform rotate-1 transition-colors">
        
        <div class="text-center mb-8 border-b-4 border-black dark:border-white pb-4 transform -rotate-1">
            <h2 class="text-4xl font-comic text-dark dark:text-white tracking-widest uppercase"
                style="-webkit-text-stroke: 1px black; text-shadow: 2px 2px 0 #FFD166;">
                ĐĂNG NHẬP
            </h2>
            <p class="font-black text-xs text-gray-500 dark:text-gray-400 mt-1 uppercase">Cổng vào kho truyện tranh siêu cấp</p>
        </div>
        
        <form id="loginForm" action="${pageContext.request.contextPath}/auth" method="POST" class="space-y-6" novalidate>
            <input type="hidden" name="action" value="login">
            
            <div>
                <label class="block text-sm font-black text-dark dark:text-white uppercase mb-2">Tên đăng nhập</label>
                <input type="text" id="username" name="username" required minlength="3"
                    class="w-full px-4 py-3 border-4 border-black dark:border-white font-bold text-dark dark:text-white rounded bg-white dark:bg-gray-700 shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark focus:translate-y-0.5 focus:translate-x-0.5 outline-none transition-all placeholder:text-gray-400"
                    placeholder="Nhập tên đăng nhập (>= 3 ký tự)"
                    value="${param.username}">
            </div>
            
            <div>
                <label class="block text-sm font-black text-dark dark:text-white uppercase mb-2">Mật khẩu</label>
                <input type="password" id="password" name="password" required minlength="3"
                    class="w-full px-4 py-3 border-4 border-black dark:border-white font-bold text-dark dark:text-white rounded bg-white dark:bg-gray-700 shadow-comic dark:shadow-comic-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark focus:translate-y-0.5 focus:translate-x-0.5 outline-none transition-all placeholder:text-gray-400"
                    placeholder="Nhập mật khẩu (>= 3 ký tự)">
            </div>
            
            <button type="submit"
                class="w-full bg-primary dark:bg-red-800 border-4 border-black dark:border-white text-white font-comic text-2xl tracking-widest py-3 rounded shadow-comic-lg dark:shadow-comic-lg-dark hover:shadow-comic-hover dark:hover:shadow-comic-hover-dark hover:translate-y-1 hover:translate-x-1 hover:bg-secondary dark:hover:bg-yellow-600 hover:text-dark transition-all uppercase flex items-center justify-center gap-2"
                style="-webkit-text-stroke: 0.5px black;">
                ĐĂNG NHẬP NGAY!
            </button>
            
            <div class="text-center pt-4 border-t-2 border-dashed border-black dark:border-white">
                <span class="font-black text-sm text-gray-500 dark:text-gray-400 uppercase">Chưa có tài khoản?</span>
                <a href="${pageContext.request.contextPath}/auth?action=register" 
                   class="inline-block ml-1 font-black text-sm text-primary dark:text-red-400 uppercase hover:underline decoration-2">
                    ĐĂNG KÝ NGAY!
                </a>
            </div>
        </form>

        <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const u = document.getElementById('username');
            const p = document.getElementById('password');
            let errorMsg = '';
            
            // Xóa viền đỏ cũ
            u.classList.remove('border-primary');
            p.classList.remove('border-primary');
            
            if (!u.value.trim() || u.value.trim().length < 3) {
                errorMsg = 'Tên đăng nhập phải từ 3 ký tự trở lên!';
                u.classList.add('border-primary');
                u.focus();
            } else if (!p.value || p.value.length < 3) {
                errorMsg = 'Mật khẩu phải từ 3 ký tự trở lên!';
                p.classList.add('border-primary');
                p.focus();
            }
            
            if (errorMsg) {
                e.preventDefault(); // Ngăn submit form
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
