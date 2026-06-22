<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>MANGA STORE - Siêu Thị Truyện Tranh</title>
            <!-- Google Fonts cho Comic Style -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Bangers&family=Nunito:wght@400;700;900&display=swap"
                rel="stylesheet">

            <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
            <!-- Tích hợp Tailwind CSS qua CDN -->
            <script src="https://cdn.tailwindcss.com"></script>
            <script>
                tailwind.config = {
                    darkMode: 'class',
                    theme: {
                        extend: {
                            colors: {
                                primary: '#E63946', /* Đỏ rực */
                                secondary: '#FFD166', /* Vàng chanh */
                                accent: '#06D6A0', /* Cyan/Xanh ngọc */
                                dark: '#111827',
                            },
                            fontFamily: {
                                sans: ['Nunito', 'sans-serif'],
                                comic: ['Bangers', 'cursive'],
                            },
                            boxShadow: {
                                'comic': '4px 4px 0px 0px rgba(0,0,0,1)',
                                'comic-lg': '8px 8px 0px 0px rgba(0,0,0,1)',
                                'comic-hover': '2px 2px 0px 0px rgba(0,0,0,1)',
                                'comic-dark': '4px 4px 0px 0px rgba(255,255,255,0.2)',
                                'comic-lg-dark': '8px 8px 0px 0px rgba(255,255,255,0.2)',
                                'comic-hover-dark': '2px 2px 0px 0px rgba(255,255,255,0.2)',
                            },
                            keyframes: {
                                'float-comic': {
                                    '0%, 100%': { transform: 'translateY(0) rotate(0deg)' },
                                    '50%': { transform: 'translateY(-10px) rotate(2deg)' },
                                },
                                'wobble-neo': {
                                    '0%, 100%': { transform: 'rotate(-2deg)' },
                                    '50%': { transform: 'rotate(2deg)' },
                                },
                                'pulse-shadow': {
                                    '0%, 100%': { boxShadow: '4px 4px 0px 0px rgba(0,0,0,1)' },
                                    '50%': { boxShadow: '8px 8px 0px 0px rgba(0,0,0,1)', transform: 'translateY(-2px)' },
                                }
                            },
                            animation: {
                                'float-comic': 'float-comic 3s ease-in-out infinite',
                                'wobble-neo': 'wobble-neo 2s ease-in-out infinite',
                                'pulse-shadow': 'pulse-shadow 2s infinite',
                            }
                        }
                    }
                }
            </script>
            <script>
                // Init Dark Mode
                if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
                    document.documentElement.classList.add('dark');
                } else {
                    document.documentElement.classList.remove('dark');
                }
                function toggleDarkMode() {
                    if (document.documentElement.classList.contains('dark')) {
                        document.documentElement.classList.remove('dark');
                        localStorage.theme = 'light';
                    } else {
                        document.documentElement.classList.add('dark');
                        localStorage.theme = 'dark';
                    }
                }
            </script>
            <style>
                /* Halftone background pattern */
                .bg-halftone {
                    background-color: #f8fafc;
                    background-image: radial-gradient(#cbd5e1 1.5px, transparent 1.5px);
                    background-size: 12px 12px;
                }
                .dark .bg-halftone {
                    background-color: #0f172a; /* Mượt hơn với slate-900 thay vì xám đen thuần */
                    background-image: radial-gradient(#334155 1.5px, transparent 1.5px); /* slate-700 */
                    background-size: 12px 12px;
                }
                
                /* Custom VIP PRO MAX Cursor */
                html, body {
                    cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28"><polygon points="2,2 20,10 12,14 16,24 12,26 8,16 2,22" fill="%23FFD166" stroke="black" stroke-width="2"/></svg>') 2 2, auto !important;
                }
                a, button, [role="button"], input, select, textarea {
                    cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"><polygon points="4,2 24,12 16,16 22,28 16,30 10,18 2,24" fill="%2306D6A0" stroke="black" stroke-width="2"/></svg>') 4 2, pointer !important;
                }
            </style>
        </head>

        <body
            class="bg-halftone min-h-screen flex flex-col font-sans text-dark dark:text-white selection:bg-secondary selection:text-dark overflow-x-hidden transition-colors duration-300">

            <!-- Header Comic Style -->
            <header data-aos="slide-down" data-aos-duration="500" class="bg-secondary dark:bg-gray-800 border-b-4 border-black dark:border-white sticky top-0 z-50 shadow-comic-lg dark:shadow-comic-lg-dark w-full transition-colors">
                <div class="max-w-screen-2xl mx-auto px-4 md:px-8 h-20 flex items-center justify-between">

                    <a href="${pageContext.request.contextPath}/customer"
                        class="text-4xl text-white font-comic tracking-wider flex items-center gap-2 transform -rotate-2 hover:rotate-0 transition-transform"
                        style="-webkit-text-stroke: 2px black;">
                        💥 MANGA STORE
                    </a>

                    <nav class="flex items-center gap-2 md:gap-4">
                        <div class="hidden lg:flex items-center gap-4">
                        <a href="${pageContext.request.contextPath}/customer"
                            class="text-lg font-black uppercase text-dark dark:text-white hover:bg-white dark:hover:bg-gray-700 border-2 border-transparent hover:border-black dark:hover:border-white hover:shadow-comic dark:hover:shadow-comic-dark px-3 py-1 transition-all rounded">Shop
                            Truyện</a>
                        
                        <a href="${pageContext.request.contextPath}/gacha"
                            class="text-lg font-black uppercase text-dark dark:text-white hover:bg-accent dark:hover:bg-teal-700 border-2 border-transparent hover:border-black dark:hover:border-white hover:shadow-comic dark:hover:shadow-comic-dark px-3 py-1 transition-all rounded">🎰 Gacha</a>

                        </div>

                        <!-- Nút Bật/Tắt Dark Mode -->
                        <button onclick="toggleDarkMode()"
                            class="relative flex items-center justify-center bg-dark text-white dark:bg-white dark:text-dark border-2 border-black p-2 rounded shadow-comic hover:shadow-comic-lg hover:-translate-y-0.5 transition-all group"
                            title="Bật/Tắt Dark Mode">
                            <!-- Icon Mặt trăng (hiện ở Light Mode) -->
                            <svg class="w-6 h-6 block dark:hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
                            </svg>
                            <!-- Icon Mặt trời (hiện ở Dark Mode) -->
                            <svg class="w-6 h-6 hidden dark:block" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
                            </svg>
                        </button>

                        <!-- Icon Giỏ Hàng -->
                        <a href="${pageContext.request.contextPath}/customer?action=cart"
                            id="header-cart-icon"
                            class="relative flex items-center justify-center bg-white dark:bg-gray-700 border-2 border-black dark:border-white p-2 rounded shadow-comic dark:shadow-comic-dark hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark hover:-translate-y-0.5 transition-all text-dark dark:text-white mr-2"
                            title="Xem Giỏ Hàng">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                            </svg>
                            <div id="header-cart-badge"
                                class="absolute -top-2.5 -right-2.5 bg-primary border-2 border-black dark:border-white text-white text-xs font-black rounded-full w-6 h-6 flex items-center justify-center shadow-comic-hover dark:shadow-comic-hover-dark">
                                ${sessionScope.cartSize != null ? sessionScope.cartSize : 0}
                            </div>
                        </a>

                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <!-- Nút Thông báo (Bell Icon) -->
                                <div class="relative ml-2 flex items-center" id="notification-container">
                                    <button id="btn-notifications" class="relative flex items-center justify-center bg-white dark:bg-gray-700 border-2 border-black dark:border-white p-2 rounded shadow-comic dark:shadow-comic-dark hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark hover:-translate-y-0.5 transition-all text-dark dark:text-white" title="Thông báo">
                                        <svg class="w-6 h-6 animate-pulse" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path></svg>
                                        <div id="header-notif-badge" class="absolute -top-2.5 -right-2.5 bg-accent border-2 border-black dark:border-white text-dark text-xs font-black rounded-full w-6 h-6 flex items-center justify-center shadow-comic-hover hidden">0</div>
                                    </button>
                                    
                                    <!-- Dropdown Thông Báo -->
                                    <div id="notif-dropdown" class="absolute right-0 top-full mt-3 w-80 bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark opacity-0 invisible transition-all flex flex-col z-[100] transform origin-top-right scale-95 max-h-96 overflow-y-auto">
                                        <div class="px-4 py-3 border-b-4 border-black dark:border-white bg-accent dark:bg-teal-700 text-dark dark:text-white font-black uppercase text-lg sticky top-0 z-10 flex justify-between items-center">
                                            THÔNG BÁO MỚI
                                        </div>
                                        <div id="notif-list" class="flex flex-col">
                                            <div class="p-4 text-center text-gray-500 font-bold italic">Đang tải...</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="relative group pl-2 md:pl-4 border-l-2 md:border-l-4 border-black dark:border-white ml-2 md:ml-4 h-10 flex items-center">
                                    <button
                                        class="flex items-center gap-1 md:gap-2 text-sm md:text-lg font-black text-dark dark:text-white bg-white dark:bg-gray-700 border-2 border-black dark:border-white px-2 md:px-3 py-1 rounded shadow-comic dark:shadow-comic-dark group-hover:-translate-y-0.5 group-hover:shadow-comic-lg dark:group-hover:shadow-comic-lg-dark transition-all">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user.avatar}">
                                                <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="w-6 h-6 rounded-full border border-black object-cover bg-white" alt="Avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://api.dicebear.com/7.x/bottts/svg?seed=${sessionScope.user.username}&backgroundColor=FFD166" class="w-6 h-6 rounded-full border border-black bg-secondary" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="hidden md:inline">YO, ${sessionScope.user.username}!</span>
                                        <span class="bg-secondary text-dark text-xs px-2 py-0.5 border-2 border-black rounded-full whitespace-nowrap shadow-comic-hover">💰 ${sessionScope.user.mangaCoin}</span>
                                        <svg class="hidden md:block w-4 h-4 transform group-hover:rotate-180 transition-transform"
                                            fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7">
                                            </path>
                                        </svg>
                                    </button>

                                    <!-- Dropdown Menu -->
                                    <div
                                        class="absolute right-0 top-full mt-2 w-56 bg-white dark:bg-gray-800 border-4 border-black dark:border-white shadow-comic-lg dark:shadow-comic-lg-dark opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all flex flex-col z-[100] transform origin-top-right scale-95 group-hover:scale-100">
                                        <a href="${pageContext.request.contextPath}/customer?action=profile"
                                            class="flex items-center gap-2 px-4 py-3 font-black text-dark dark:text-white hover:bg-secondary dark:hover:bg-gray-700 border-b-4 border-black dark:border-white uppercase text-sm transition-colors">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="3"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z">
                                                </path>
                                            </svg>
                                            Hồ Sơ VIP
                                        </a>
                                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                            <a href="${pageContext.request.contextPath}/admin"
                                                class="flex items-center gap-2 px-4 py-3 font-black text-dark dark:text-white hover:bg-accent dark:hover:bg-gray-700 border-b-4 border-black dark:border-white uppercase text-sm transition-colors">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="3"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z">
                                                    </path>
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                </svg>
                                                Quản Trị Admin
                                            </a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/auth?action=logout"
                                            class="flex items-center gap-2 px-4 py-3 font-black text-primary hover:bg-gray-100 dark:hover:bg-gray-700 uppercase text-sm transition-colors">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="3"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                                                </path>
                                            </svg>
                                            Đăng Xuất Nhé!
                                        </a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="hidden lg:flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/auth?action=login"
                                        class="px-5 py-2 text-lg font-comic tracking-wider bg-primary text-white border-2 border-black dark:border-white rounded shadow-comic dark:shadow-comic-dark hover:-translate-y-0.5 hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all">ĐĂNG
                                        NHẬP</a>
                                    <a href="${pageContext.request.contextPath}/auth?action=register"
                                        class="px-5 py-2 text-lg font-comic tracking-wider bg-accent text-dark border-2 border-black dark:border-white rounded shadow-comic dark:shadow-comic-dark hover:-translate-y-0.5 hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all">ĐĂNG
                                        KÝ</a>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- Hamburger Button (Mobile) -->
                        <button id="hamburgerBtn" onclick="toggleMobileMenu()" class="relative block lg:hidden ml-2 bg-white dark:bg-gray-700 border-2 border-black dark:border-white w-10 h-10 rounded shadow-comic dark:shadow-comic-dark text-dark dark:text-white transition-all hover:-translate-y-0.5 hover:shadow-comic-lg z-[60]">
                            <div class="absolute inset-0 flex flex-col justify-center items-center gap-1.5 transition-transform duration-300" id="hamburgerLines">
                                <span class="w-5 h-[3px] bg-current transition-all duration-300 origin-center rounded-full"></span>
                                <span class="w-5 h-[3px] bg-current transition-all duration-300 origin-center rounded-full"></span>
                                <span class="w-5 h-[3px] bg-current transition-all duration-300 origin-center rounded-full"></span>
                            </div>
                        </button>
                    </nav>
                </div>
            </header>

            <!-- Mobile Menu Overlay -->
            <div id="mobileMenuOverlay" onclick="toggleMobileMenu()" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-[100] opacity-0 invisible transition-all duration-300"></div>

            <!-- Mobile Menu Content -->
            <div id="mobileMenuPanel" class="fixed top-0 right-0 h-[100dvh] w-4/5 max-w-[320px] bg-white dark:bg-gray-800 border-l-4 border-black dark:border-white shadow-comic-lg-dark z-[110] flex flex-col px-6 pt-24 gap-6 transform translate-x-full transition-transform duration-500 ease-[cubic-bezier(0.175,0.885,0.32,1.275)]">
                
                <h2 class="font-comic text-3xl tracking-widest border-b-4 border-black dark:border-white pb-2 mb-2 uppercase text-primary" style="-webkit-text-stroke: 1px black;">MENU SIÊU CẤP</h2>
                
                <div class="flex flex-col gap-4">
                    <a href="${pageContext.request.contextPath}/customer" class="mobile-menu-item translate-x-8 opacity-0 transition-all duration-300 delay-100 flex items-center gap-3 font-black text-xl text-dark dark:text-white hover:text-primary dark:hover:text-primary uppercase group">
                        <span class="w-3 h-3 bg-primary border-2 border-black rounded-full group-hover:scale-150 transition-transform"></span>
                        Shop Truyện
                    </a>
                    <a href="${pageContext.request.contextPath}/gacha" class="mobile-menu-item translate-x-8 opacity-0 transition-all duration-300 delay-150 flex items-center gap-3 font-black text-xl text-dark dark:text-white hover:text-accent dark:hover:text-accent uppercase group">
                        <span class="w-3 h-3 bg-accent border-2 border-black rounded-full group-hover:scale-150 transition-transform"></span>
                        🎰 Gacha
                    </a>
                    
                    <c:if test="${sessionScope.user == null}">
                        <div class="h-1 bg-black dark:bg-white w-full rounded-full my-2 mobile-menu-item translate-x-8 opacity-0 transition-all duration-300 delay-200"></div>
                        
                        <div class="flex flex-col gap-6 mt-2">
                            <a href="${pageContext.request.contextPath}/auth?action=login" class="mobile-menu-item translate-x-8 opacity-0 transition-all duration-300 delay-250 flex items-center justify-center bg-primary text-white font-comic tracking-widest text-xl border-4 border-black px-4 py-3 rounded-lg shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all">
                                ĐĂNG NHẬP
                            </a>
                            <a href="${pageContext.request.contextPath}/auth?action=register" class="mobile-menu-item translate-x-8 opacity-0 transition-all duration-300 delay-300 flex items-center justify-center bg-accent text-dark font-comic tracking-widest text-xl border-4 border-black px-4 py-3 rounded-lg shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition-all">
                                ĐĂNG KÝ
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- Comic decoration -->
                <div class="mt-auto mb-8 flex justify-center">
                    <div class="bg-secondary px-6 py-2 border-4 border-black transform -rotate-6 shadow-comic font-comic text-xl text-dark animate-pulse-shadow">
                        MANGA STORE
                    </div>
                </div>
            </div>

            <script>
                function toggleMobileMenu() {
                    const panel = document.getElementById('mobileMenuPanel');
                    const overlay = document.getElementById('mobileMenuOverlay');
                    const lines = document.getElementById('hamburgerLines').children;
                    const items = document.querySelectorAll('.mobile-menu-item');
                    const isOpen = !panel.classList.contains('translate-x-full');

                    if (isOpen) {
                        // Close menu
                        panel.classList.add('translate-x-full');
                        overlay.classList.add('opacity-0', 'invisible');
                        overlay.classList.remove('opacity-100');
                        
                        // Animate items out
                        items.forEach(item => {
                            item.classList.add('translate-x-8', 'opacity-0');
                            item.classList.remove('translate-x-0', 'opacity-100');
                        });

                        // Animate hamburger to lines
                        lines[0].style.transform = 'translateY(0) rotate(0)';
                        lines[1].style.opacity = '1';
                        lines[2].style.transform = 'translateY(0) rotate(0)';
                    } else {
                        // Open menu
                        panel.classList.remove('translate-x-full');
                        overlay.classList.remove('opacity-0', 'invisible');
                        overlay.classList.add('opacity-100');
                        
                        // Animate items in
                        items.forEach(item => {
                            item.classList.remove('translate-x-8', 'opacity-0');
                            item.classList.add('translate-x-0', 'opacity-100');
                        });

                        // Animate hamburger to X
                        lines[0].style.transform = 'translateY(9px) rotate(45deg)';
                        lines[1].style.opacity = '0';
                        lines[2].style.transform = 'translateY(-9px) rotate(-45deg)';
                    }
                }
            </script>

            <!-- TOAST CONTAINER -->
            <div id="toast-container" class="fixed bottom-4 right-4 z-[200] flex flex-col gap-3 pointer-events-none"></div>

            <script>
                function showToast(message, type = 'success') {
                    const container = document.getElementById('toast-container');
                    if (!container) return;
                    
                    const toast = document.createElement('div');
                    toast.className = `flex items-center gap-3 bg-white border-4 border-black p-4 shadow-comic-lg transform translate-y-10 opacity-0 transition-all duration-300 pointer-events-auto ` + (type === 'success' ? 'border-l-8 border-l-accent' : 'border-l-8 border-l-primary');
                    toast.innerHTML = `
                        <div class="font-bold text-dark font-sans flex-grow pr-4">` + message + `</div>
                        <button class="text-gray-500 hover:text-black font-black" onclick="this.parentElement.remove()">X</button>
                    `;
                    container.appendChild(toast);
                    
                    // Animate in
                    setTimeout(() => {
                        toast.classList.remove('translate-y-10', 'opacity-0');
                    }, 10);
                    
                    // Auto remove
                    setTimeout(() => {
                        if (toast.parentElement) {
                            toast.classList.add('translate-y-10', 'opacity-0');
                            setTimeout(() => { if (toast.parentElement) toast.remove(); }, 300);
                        }
                    }, 5000);
                }
            </script>

            <c:if test="${sessionScope.user != null}">
            <script>
            document.addEventListener('DOMContentLoaded', () => {
                const badge = document.getElementById('header-notif-badge');
                const list = document.getElementById('notif-list');
                const dropdown = document.getElementById('notif-dropdown');
                const btnNotif = document.getElementById('btn-notifications');
                let displayedIds = new Set();
                let isFirstLoad = true;
                
                if(!btnNotif || !dropdown) return;

                // Toggle dropdown
                btnNotif.addEventListener('click', (e) => {
                    e.stopPropagation();
                    if(dropdown.classList.contains('invisible')) {
                        dropdown.classList.remove('invisible', 'opacity-0', 'scale-95');
                        dropdown.classList.add('opacity-100', 'scale-100');
                    } else {
                        dropdown.classList.add('invisible', 'opacity-0', 'scale-95');
                        dropdown.classList.remove('opacity-100', 'scale-100');
                    }
                });
                
                // Click outside to close
                document.addEventListener('click', (e) => {
                    if(!btnNotif.contains(e.target) && !dropdown.contains(e.target)) {
                        dropdown.classList.add('invisible', 'opacity-0', 'scale-95');
                        dropdown.classList.remove('opacity-100', 'scale-100');
                    }
                });

                async function fetchNotifications() {
                    try {
                        const res = await fetch('${pageContext.request.contextPath}/customer/notifications');
                        const data = await res.json();
                        if(data.success && data.notifications) {
                            const notifs = data.notifications;
                            
                            // Update badge
                            if(notifs.length > 0) {
                                badge.textContent = notifs.length;
                                badge.classList.remove('hidden');
                            } else {
                                badge.classList.add('hidden');
                            }
                            
                            // Check for new notifications to show toast
                            notifs.forEach(n => {
                                if(!displayedIds.has(n.id)) {
                                    displayedIds.add(n.id);
                                    if(!isFirstLoad) { 
                                        if(typeof showToast === 'function') {
                                            showToast(n.message, 'success');
                                            // Play notification sound
                                            let audio = new Audio('https://www.soundjay.com/buttons/sounds/button-10.mp3');
                                            audio.volume = 0.3;
                                            audio.play().catch(e => {});
                                        }
                                    }
                                }
                            });
                            isFirstLoad = false;
                            
                            // Render list
                            if(notifs.length > 0) {
                                list.innerHTML = '';
                                notifs.forEach(n => {
                                    const div = document.createElement('div');
                                    div.className = 'p-4 border-b-2 border-gray-200 dark:border-gray-600 hover:bg-yellow-50 dark:hover:bg-gray-700 transition-colors';
                                    div.innerHTML = `
                                        <p class="text-sm font-bold text-dark dark:text-white mb-2">` + n.message + `</p>
                                        <button class="text-xs font-black uppercase text-accent hover:text-primary underline" onclick="markRead(` + n.id + `, this)">Đánh dấu đã đọc</button>
                                    `;
                                    list.appendChild(div);
                                });
                            } else {
                                list.innerHTML = '<div class="p-4 text-center text-gray-500 font-bold italic">Không có thông báo mới.</div>';
                            }
                        }
                    } catch (e) { console.error('Error fetching notifications', e); }
                }
                
                // Initial fetch
                fetchNotifications();
                
                // Poll every 5s
                setInterval(fetchNotifications, 5000);
            });

            window.markRead = async function(id, btnElement) {
                try {
                    await fetch('${pageContext.request.contextPath}/customer/notifications?action=mark-read&id=' + id);
                    const div = btnElement.parentElement;
                    div.style.opacity = '0';
                    setTimeout(() => div.remove(), 300);
                    
                    // Update badge locally
                    const badge = document.getElementById('header-notif-badge');
                    let count = parseInt(badge.textContent || '0') - 1;
                    if(count > 0) {
                        badge.textContent = count;
                    } else {
                        badge.classList.add('hidden');
                        document.getElementById('notif-list').innerHTML = '<div class="p-4 text-center text-gray-500 font-bold italic">Không có thông báo mới.</div>';
                    }
                } catch (e) { console.error(e); }
            }
            </script>
            </c:if>

            <div class="flex flex-grow w-full max-w-screen-2xl mx-auto px-4 md:px-8 gap-8 relative mt-8 mb-8 items-start">
                <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" />
                <main class="flex-grow min-w-0">
