<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            </style>
        </head>

        <body
            class="bg-halftone min-h-screen flex flex-col font-sans text-dark dark:text-white selection:bg-secondary selection:text-dark overflow-x-hidden transition-colors duration-300">

            <!-- Header Comic Style -->
            <header class="bg-secondary dark:bg-gray-800 border-b-4 border-black dark:border-white sticky top-0 z-50 shadow-comic-lg dark:shadow-comic-lg-dark w-full transition-colors">
                <div class="max-w-screen-2xl mx-auto px-4 md:px-8 h-20 flex items-center justify-between">

                    <a href="${pageContext.request.contextPath}/customer"
                        class="text-4xl text-white font-comic tracking-wider flex items-center gap-2 transform -rotate-2 hover:rotate-0 transition-transform"
                        style="-webkit-text-stroke: 2px black;">
                        💥 MANGA STORE
                    </a>

                    <nav class="flex items-center gap-4">
                        <a href="${pageContext.request.contextPath}/customer"
                            class="text-lg font-black uppercase text-dark dark:text-white hover:bg-white dark:hover:bg-gray-700 border-2 border-transparent hover:border-black dark:hover:border-white hover:shadow-comic dark:hover:shadow-comic-dark px-3 py-1 transition-all rounded">Shop
                            Truyện</a>
                        
                        <a href="${pageContext.request.contextPath}/gacha"
                            class="text-lg font-black uppercase text-dark dark:text-white hover:bg-accent dark:hover:bg-teal-700 border-2 border-transparent hover:border-black dark:hover:border-white hover:shadow-comic dark:hover:shadow-comic-dark px-3 py-1 transition-all rounded">🎰 Gacha</a>

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

                                <div class="relative group pl-4 border-l-4 border-black dark:border-white ml-4 h-10 flex items-center">
                                    <button
                                        class="flex items-center gap-2 text-lg font-black text-dark dark:text-white bg-white dark:bg-gray-700 border-2 border-black dark:border-white px-3 py-1 rounded shadow-comic dark:shadow-comic-dark group-hover:-translate-y-0.5 group-hover:shadow-comic-lg dark:group-hover:shadow-comic-lg-dark transition-all">
                                        YO, ${sessionScope.user.username}!
                                        <span class="bg-secondary text-dark text-xs px-2 py-0.5 border-2 border-black rounded-full whitespace-nowrap shadow-comic-hover">💰 ${sessionScope.user.mangaCoin}</span>
                                        <svg class="w-4 h-4 transform group-hover:rotate-180 transition-transform"
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
                                <div class="flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/auth?action=login"
                                        class="px-5 py-2 text-lg font-comic tracking-wider bg-primary text-white border-2 border-black dark:border-white rounded shadow-comic dark:shadow-comic-dark hover:-translate-y-0.5 hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all">ĐĂNG
                                        NHẬP</a>
                                    <a href="${pageContext.request.contextPath}/auth?action=register"
                                        class="px-5 py-2 text-lg font-comic tracking-wider bg-accent text-dark border-2 border-black dark:border-white rounded shadow-comic dark:shadow-comic-dark hover:-translate-y-0.5 hover:shadow-comic-lg dark:hover:shadow-comic-lg-dark transition-all">ĐĂNG
                                        KÝ</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </nav>
                </div>
            </header>

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

            <c:choose>
                <c:when test="${view.contains('/admin')}">
                    <div class="flex flex-grow w-full max-w-screen-2xl mx-auto px-4 md:px-8 gap-8 relative mt-8 mb-8">
                        <c:if test="${!view.contains('orders.jsp')}">
                            <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" />
                        </c:if>
                        <main class="flex-grow min-w-0">
                </c:when>
                <c:otherwise>
                    <div class="flex flex-grow w-full max-w-screen-2xl mx-auto px-4 md:px-8 gap-8 relative mt-8 mb-8">
                        <jsp:include page="/WEB-INF/views/includes/sidebar.jsp" />
                        <main class="flex-grow min-w-0">
                </c:otherwise>
            </c:choose>