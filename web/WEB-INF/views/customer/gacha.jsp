<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="max-w-5xl mx-auto mt-8 mb-20 px-4">
    <!-- Header -->
    <div class="text-center mb-16">
        <h1 class="text-5xl md:text-7xl font-comic text-white uppercase tracking-widest transform -rotate-2 inline-block bg-dark px-8 py-8 border-4 border-black shadow-[8px_8px_0_0_#06D6A0]">
            CỖ MÁY GACHA
        </h1>
        <div class="mt-8">
            <span class="font-black text-xl text-dark uppercase tracking-wider bg-yellow-400 inline-block px-6 py-2 border-4 border-black shadow-[4px_4px_0_0_#000] transform rotate-1">
                Test nhân phẩm - Săn siêu phẩm!
            </span>
        </div>
    </div>

    <!-- Main Content -->
    <div class="bg-white dark:bg-gray-800 border-[8px] border-black p-6 md:p-12 shadow-[16px_16px_0_0_#000] relative flex flex-col md:flex-row items-center justify-between gap-12 overflow-hidden">
        
        <!-- Background Pattern -->
        <div class="absolute inset-0 opacity-10 bg-[url('data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Ccircle cx=\'2\' cy=\'2\' r=\'2\' fill=\'%23000000\'/%3E%3C/svg%3E')] pointer-events-none"></div>
        
        <!-- Gacha Spinner Area -->
        <div class="w-full md:w-1/2 flex flex-col justify-center items-center relative z-10 min-h-[300px]">
            <div class="relative w-full max-w-sm mx-auto h-64 bg-white border-8 border-black shadow-[16px_16px_0_0_#000] overflow-hidden mb-8 flex justify-center items-center p-4">
                <!-- Single Item Card (Flash Animation) -->
                <div id="flashCard" class="w-full h-full flex flex-col items-center justify-center">
                    <img id="flashImg" src="https://api.dicebear.com/7.x/bottts/svg?seed=gacha&backgroundColor=ffb703" class="h-32 object-contain mb-4 drop-shadow-[4px_4px_0_rgba(0,0,0,1)] border-2 border-black bg-white animate-bounce">
                    <div id="flashName" class="font-black text-2xl text-center uppercase w-full px-2 text-primary drop-shadow-[2px_2px_0_#000] text-white">SẴN SÀNG!</div>
                </div>
            </div>
            <!-- Glow Effect -->
            <div id="glowEffect" class="absolute inset-0 bg-yellow-400 rounded-full blur-[80px] opacity-0 transition-opacity duration-300 pointer-events-none"></div>
        </div>

        <!-- Panel Controls Area -->
        <div class="w-full md:w-1/2 flex flex-col items-center bg-gray-100 dark:bg-gray-700 border-4 border-black p-8 transform rotate-1 relative z-10 shadow-[8px_8px_0_0_#000]">
            
            <!-- Price Info -->
            <div class="w-full flex justify-between items-center bg-dark text-white font-black text-2xl px-6 py-4 border-4 border-black mb-8 shadow-[6px_6px_0_0_#FF9F1C] transform -rotate-1">
                <span>GIÁ QUAY:</span>
                <span class="text-yellow-400 text-3xl">100 XU</span>
            </div>

            <!-- Current Coin -->
            <div class="flex items-center gap-4 mb-10 bg-white dark:bg-gray-800 border-4 border-black px-6 py-3 w-full justify-center shadow-[4px_4px_0_0_#000]">
                <span class="font-black text-xl uppercase text-dark dark:text-gray-200">Ví của bạn:</span>
                <span id="currentCoin" class="font-comic text-4xl text-accent drop-shadow-[2px_2px_0_#000] text-white">
                    ${empty sessionScope.user ? 0 : sessionScope.user.mangaCoin}
                </span>
            </div>

            <!-- Spin Button -->
            <button id="btnSpin" class="w-full bg-primary border-4 border-black text-white font-black text-4xl py-6 uppercase shadow-[8px_8px_0_0_#000] hover:translate-y-2 hover:translate-x-2 hover:shadow-none transition-all active:bg-red-700 focus:outline-none">
                QUAY NGAY!
            </button>
            
        </div>
    </div>
</div>

<!-- Modal Kết quả -->
<div id="resultModal" class="fixed inset-0 z-[9999] bg-black/90 hidden flex-col items-center justify-center p-4">
    <div class="bg-white border-[12px] border-black p-8 md:p-12 max-w-2xl w-full flex flex-col items-center transform scale-0 transition-transform duration-500 ease-out shadow-[20px_20px_0_0_#FF9F1C]" id="resultContent">
        <h2 id="resultTitle" class="font-comic text-5xl md:text-7xl uppercase mb-8 text-center" style="-webkit-text-stroke: 2px black; color: white; text-shadow: 6px 6px 0 #000;">CHÚC MỪNG!</h2>
        
        <div id="resultMsg" class="text-2xl md:text-3xl font-black text-center mb-12 bg-yellow-300 border-4 border-black px-8 py-6 transform -rotate-2 w-full break-words shadow-[6px_6px_0_0_#000] text-dark">
            Bạn nhận được XYZ
        </div>
        
        <button id="btnCloseResult" class="bg-dark text-white border-4 border-black hover:bg-accent hover:text-dark font-black text-3xl px-12 py-4 uppercase transition-colors shadow-[8px_8px_0_0_#000] hover:translate-y-1 hover:translate-x-1 hover:shadow-[4px_4px_0_0_#000] w-full">
            QUẤT TIẾP!
        </button>
    </div>
</div>

<!-- Audio Files -->
<audio id="sfxSpin" src="https://actions.google.com/sounds/v1/cartoon/cartoon_boing.ogg" preload="auto"></audio>
<audio id="sfxWin" src="https://actions.google.com/sounds/v1/cartoon/clown_horn.ogg" preload="auto"></audio>

<style>
@keyframes shakeBox {
    0% { transform: rotate(0deg) scale(1); }
    25% { transform: rotate(15deg) scale(1.1); }
    50% { transform: rotate(-15deg) scale(1.1); }
    75% { transform: rotate(15deg) scale(1.1); }
    100% { transform: rotate(0deg) scale(1); }
}
.animate-shakeBox {
    animation: shakeBox 0.3s ease-in-out infinite;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const btnSpin = document.getElementById('btnSpin');
    const glow = document.getElementById('glowEffect');
    const currentCoinDisplay = document.getElementById('currentCoin');
    
    const resultModal = document.getElementById('resultModal');
    const resultContent = document.getElementById('resultContent');
    const resultTitle = document.getElementById('resultTitle');
    const resultMsg = document.getElementById('resultMsg');
    const btnCloseResult = document.getElementById('btnCloseResult');
    
    const sfxSpin = document.getElementById('sfxSpin');
    const sfxWin = document.getElementById('sfxWin');

    const flashImg = document.getElementById('flashImg');
    const flashName = document.getElementById('flashName');

    // Mảng dữ liệu rewards từ server
    const rewards = [
        <c:forEach items="${rewards}" var="r" varStatus="status">
            <c:set var="imgPath" value="${r.image.startsWith('http') ? r.image : pageContext.request.contextPath.concat('/').concat(r.image)}" />
            {
                name: "${r.name.replace('\"', '\\\"')}",
                image: "${imgPath}"
            }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    let isSpinning = false;

    btnSpin.addEventListener('click', async () => {
        if(isSpinning) return;
        
        <c:if test="${empty sessionScope.user}">
            if(typeof showToast === 'function') showToast("Đăng nhập để quay nhé bro!", 'error');
            else alert("Đăng nhập để quay nhé bro!");
            return;
        </c:if>

        isSpinning = true;
        btnSpin.classList.add('opacity-50', 'cursor-not-allowed');
        
        // Bắt đầu hiệu ứng
        glow.classList.remove('opacity-0');
        glow.classList.add('opacity-100');
        sfxSpin.currentTime = 0;
        sfxSpin.loop = true;
        sfxSpin.play().catch(e => console.log(e));

        try {
            const res = await fetch('${pageContext.request.contextPath}/gacha', { method: 'POST' });
            const data = await res.json();
            
            if (!data.success) {
                if(typeof showToast === 'function') showToast(data.message, 'error');
                else alert(data.message);
                isSpinning = false;
                btnSpin.classList.remove('opacity-50', 'cursor-not-allowed');
                glow.classList.add('opacity-0');
                sfxSpin.pause();
                return;
            }

            const targetIndex = data.targetIndex;
            
            // Xử lý hiệu ứng flash (nháy ảnh liên tục)
            flashImg.classList.remove('animate-bounce');
            
            let currentFlashIndex = 0;
            let currentDelay = 30; // Nhanh nhất: 30ms
            const maxDelay = 400; // Chậm nhất khi gần dừng: 400ms
            const duration = 3500; // Tổng thời gian quay: 3.5 giây
            const startTime = Date.now();
            
            function flashNext() {
                const elapsed = Date.now() - startTime;
                
                if (elapsed >= duration) {
                    // Dừng đúng mục tiêu
                    sfxSpin.pause();
                    flashImg.src = rewards[targetIndex].image;
                    flashImg.className = 'h-40 object-contain mb-4 drop-shadow-[8px_8px_0_rgba(0,0,0,1)] border-4 border-black bg-white transform scale-110 transition-transform duration-300';
                    flashName.textContent = rewards[targetIndex].name;
                    flashName.className = 'font-black text-3xl text-center uppercase w-full px-2 text-accent drop-shadow-[2px_2px_0_#000] text-white';
                    
                    // Hiện modal kết quả
                    setTimeout(() => {
                        glow.classList.add('opacity-0');
                        currentCoinDisplay.textContent = data.newCoin;
                        
                        if(data.rewardType === 'MISS') {
                            resultTitle.textContent = 'ĐEN THÔI!';
                            resultTitle.style.color = 'white';
                            resultTitle.style.webkitTextStroke = '2px #e63946';
                            resultTitle.style.textShadow = '6px 6px 0 #e63946';
                        } else {
                            resultTitle.textContent = 'CHÚC MỪNG!';
                            resultTitle.style.color = 'white';
                            resultTitle.style.webkitTextStroke = '2px #06D6A0';
                            resultTitle.style.textShadow = '6px 6px 0 #06D6A0';
                            sfxWin.currentTime = 0;
                            sfxWin.play().catch(e => console.log(e));
                        }
                        
                        resultMsg.textContent = data.rewardName;
                        
                        resultModal.classList.remove('hidden');
                        resultModal.classList.add('flex');
                        setTimeout(() => resultContent.classList.remove('scale-0'), 50);
                        
                        isSpinning = false;
                        btnSpin.classList.remove('opacity-50', 'cursor-not-allowed');
                    }, 500);
                    
                    return;
                }
                
                // Chuyển sang ảnh tiếp theo
                currentFlashIndex = (currentFlashIndex + 1) % rewards.length;
                flashImg.src = rewards[currentFlashIndex].image;
                flashName.textContent = rewards[currentFlashIndex].name;
                flashImg.className = 'h-32 object-contain mb-4 drop-shadow-[4px_4px_0_rgba(0,0,0,1)] border-2 border-black bg-white transition-none';
                flashName.className = 'font-black text-xl text-center uppercase w-full px-2 text-gray-800 transition-none';
                
                // Tính độ trễ mới (chậm dần về cuối)
                const progress = elapsed / duration;
                const easeOut = 1 - Math.pow(1 - progress, 3); // easeOutCubic
                currentDelay = 30 + easeOut * (maxDelay - 30);
                
                setTimeout(flashNext, currentDelay);
            }
            
            // Bắt đầu vòng lặp flash
            flashNext();

        } catch(e) {
            console.error(e);
            isSpinning = false;
            glow.classList.add('opacity-0');
            btnSpin.classList.remove('opacity-50', 'cursor-not-allowed');
            sfxSpin.pause();
            alert('Lỗi hệ thống!');
        }
    });

    btnCloseResult.addEventListener('click', () => {
        resultContent.classList.add('scale-0');
        setTimeout(() => {
            resultModal.classList.add('hidden');
            resultModal.classList.remove('flex');
        }, 500);
    });
});
</script>
