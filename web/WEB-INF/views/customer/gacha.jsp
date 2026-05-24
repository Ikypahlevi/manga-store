<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="max-w-4xl mx-auto mb-16 px-4">
    <div class="text-center mb-10">
        <h1 class="text-5xl md:text-7xl font-comic text-dark dark:text-white uppercase tracking-widest transform rotate-2" style="-webkit-text-stroke: 2px black; text-shadow: 6px 6px 0 #FF9F1C;">
            CỖ MÁY GACHA
        </h1>
        <p class="font-black text-xl text-gray-600 dark:text-gray-300 mt-4 uppercase tracking-wider">Test nhân phẩm - Săn siêu phẩm!</p>
    </div>

    <div class="bg-white dark:bg-gray-800 border-[8px] border-black p-8 shadow-[16px_16px_0_0_#000] relative overflow-hidden flex flex-col md:flex-row items-center justify-between gap-8">
        
        <!-- Loot Box Image -->
        <div class="w-full md:w-1/2 flex justify-center relative z-10 perspective-1000">
            <img id="gachaBox" src="${pageContext.request.contextPath}/img/gacha.png" alt="Gacha Box" class="w-64 h-64 object-contain filter drop-shadow-[8px_8px_0_#000] transition-transform duration-100 cursor-pointer hover:scale-105">
            <div id="glowEffect" class="absolute inset-0 bg-yellow-400 rounded-full blur-[50px] opacity-0 transition-opacity duration-300 -z-10"></div>
        </div>

        <!-- Panel Controls -->
        <div class="w-full md:w-1/2 flex flex-col items-center bg-gray-100 dark:bg-gray-700 border-4 border-black p-6 transform -rotate-1 relative z-10">
            <div class="bg-black text-white font-black text-2xl px-6 py-2 uppercase mb-6 shadow-[4px_4px_0_0_#FF9F1C] rotate-2">
                Giá: 100 Xu / Lần
            </div>

            <div class="flex items-center gap-4 mb-8">
                <span class="font-black text-xl uppercase text-dark dark:text-white">Xu hiện tại:</span>
                <span id="currentCoin" class="font-comic text-4xl text-accent" style="-webkit-text-stroke: 1px black;">${empty sessionScope.user ? 0 : sessionScope.user.mangaCoin}</span>
            </div>

            <button id="btnSpin" class="w-full bg-primary border-4 border-black text-white font-black text-3xl py-4 uppercase shadow-[8px_8px_0_0_#000] hover:translate-y-1 hover:translate-x-1 hover:shadow-[4px_4px_0_0_#000] transition-all relative overflow-hidden group">
                <span class="relative z-10">QUAY NGAY!</span>
                <div class="absolute inset-0 bg-white/20 transform -skew-x-12 -translate-x-full group-hover:animate-shine"></div>
            </button>
        </div>
        
        <!-- Background Pattern -->
        <div class="absolute inset-0 opacity-10 pointer-events-none bg-[url('data:image/svg+xml,%3Csvg width=\'40\' height=\'40\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath d=\'M0 0l40 40M40 0L0 40\' stroke=\'%23000\' stroke-width=\'2\'/%3E%3C/svg%3E')]"></div>
    </div>
</div>

<!-- Kết quả Modal -->
<div id="resultModal" class="fixed inset-0 z-[9999] bg-black/90 hidden flex-col items-center justify-center p-4">
    <div class="bg-white border-[12px] border-black p-10 max-w-lg w-full flex flex-col items-center transform scale-0 transition-transform duration-500 ease-out shadow-[20px_20px_0_0_#FF9F1C]" id="resultContent">
        <h2 id="resultTitle" class="font-comic text-5xl uppercase mb-6 text-center" style="-webkit-text-stroke: 2px black;">CHÚC MỪNG!</h2>
        <div id="resultMsg" class="text-2xl font-black text-center mb-8 bg-yellow-300 border-4 border-black px-6 py-4 transform -rotate-2">
            Bạn nhận được XYZ
        </div>
        <button id="btnCloseResult" class="bg-black text-white border-4 border-transparent hover:bg-white hover:text-black hover:border-black font-black text-2xl px-10 py-3 uppercase transition-colors w-full">
            QUẤT TIẾP!
        </button>
    </div>
</div>

<!-- Audio -->
<audio id="sfxSpin" src="https://actions.google.com/sounds/v1/cartoon/cartoon_boing.ogg" preload="auto"></audio>
<audio id="sfxWin" src="https://actions.google.com/sounds/v1/cartoon/clown_horn.ogg" preload="auto"></audio>

<style>
@keyframes shakeBox {
    0% { transform: rotate(0deg) scale(1); }
    25% { transform: rotate(10deg) scale(1.1); }
    50% { transform: rotate(-10deg) scale(1.1); }
    75% { transform: rotate(10deg) scale(1.1); }
    100% { transform: rotate(0deg) scale(1); }
}
.animate-shakeBox {
    animation: shakeBox 0.4s ease-in-out infinite;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const btnSpin = document.getElementById('btnSpin');
    const box = document.getElementById('gachaBox');
    const glow = document.getElementById('glowEffect');
    const currentCoinDisplay = document.getElementById('currentCoin');
    
    const resultModal = document.getElementById('resultModal');
    const resultContent = document.getElementById('resultContent');
    const resultTitle = document.getElementById('resultTitle');
    const resultMsg = document.getElementById('resultMsg');
    const btnCloseResult = document.getElementById('btnCloseResult');
    
    const sfxSpin = document.getElementById('sfxSpin');
    const sfxWin = document.getElementById('sfxWin');

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
        
        // Bắt đầu hiệu ứng rung
        box.classList.add('animate-shakeBox');
        glow.classList.remove('opacity-0');
        glow.classList.add('opacity-100');
        sfxSpin.currentTime = 0;
        sfxSpin.play().catch(e => console.log(e));

        try {
            const res = await fetch('${pageContext.request.contextPath}/gacha', { method: 'POST' });
            const data = await res.json();
            
            setTimeout(() => {
                box.classList.remove('animate-shakeBox');
                glow.classList.add('opacity-0');
                
                if (data.success) {
                    currentCoinDisplay.textContent = data.newCoin;
                    
                    if(data.rewardType === 'MISS') {
                        resultTitle.textContent = 'ĐEN THÔI!';
                        resultTitle.style.color = '#e63946'; // primary
                    } else {
                        resultTitle.textContent = 'CHÚC MỪNG!';
                        resultTitle.style.color = '#06D6A0'; // accent
                        sfxWin.currentTime = 0;
                        sfxWin.play().catch(e => console.log(e));
                    }
                    
                    resultMsg.textContent = data.rewardName;
                    
                    resultModal.classList.remove('hidden');
                    resultModal.classList.add('flex');
                    setTimeout(() => resultContent.classList.remove('scale-0'), 50);
                    
                } else {
                    if(typeof showToast === 'function') showToast(data.message, 'error');
                    else alert(data.message);
                }
                
                isSpinning = false;
                btnSpin.classList.remove('opacity-50', 'cursor-not-allowed');
            }, 2000); // Quay trong 2 giây

        } catch(e) {
            console.error(e);
            isSpinning = false;
            box.classList.remove('animate-shakeBox');
            glow.classList.add('opacity-0');
            btnSpin.classList.remove('opacity-50', 'cursor-not-allowed');
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
