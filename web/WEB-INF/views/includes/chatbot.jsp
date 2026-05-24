<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Chatbot Mascot Widget -->
<div id="mascotWidget" class="fixed z-[99999] flex flex-col items-center" style="left: 20px; top: 80vh; cursor: grab; transition: top 3s ease-in-out, left 3s ease-in-out;">
    <!-- Chat Bubble -->
    <div id="mascotBubble" class="bg-white border-4 border-black p-4 mb-2 shadow-[4px_4px_0_0_#000] relative max-w-xs transform transition-all duration-300 scale-0 origin-bottom cursor-default">
        <div id="mascotDialogText" class="font-bold text-sm text-dark text-center">Xin chào! Tớ là trợ lý của sếp đây.</div>
        <div class="absolute -bottom-3 left-1/2 -translate-x-1/2 w-0 h-0 border-l-[10px] border-l-transparent border-t-[14px] border-t-black border-r-[10px] border-r-transparent"></div>
        <div class="absolute -bottom-1 left-1/2 -translate-x-1/2 w-0 h-0 border-l-[6px] border-l-transparent border-t-[8px] border-t-white border-r-[6px] border-r-transparent"></div>
        
        <!-- Button change skin inside bubble -->
        <button onclick="openSkinModal()" class="mt-2 w-full text-xs font-black text-primary hover:text-accent uppercase underline text-center">Đổi Waifu/Husbando</button>
    </div>

    <!-- Mascot Image -->
    <div id="mascotImageContainer" class="relative cursor-pointer" onclick="pokeMascot()">
        <img id="mascotImg" src="${pageContext.request.contextPath}/img/doraemon.png" 
             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/' + mascotSkins[currentSkin].img;"
             class="w-32 h-32 object-contain filter drop-shadow-[4px_4px_0_rgba(0,0,0,1)] hover:drop-shadow-[6px_6px_0_rgba(0,0,0,1)] transition-all">
    </div>
</div>

<!-- Modal Chọn Skin -->
<div id="skinModal" class="fixed inset-0 z-[9999] bg-black/80 hidden flex-col items-center justify-center p-4">
    <div class="bg-white border-[8px] border-black p-8 max-w-4xl w-full max-h-[90vh] overflow-y-auto shadow-[16px_16px_0_0_#F00] transform rotate-1">
        <div class="flex justify-between items-center mb-6 border-b-4 border-black pb-2">
            <h2 class="font-comic text-4xl uppercase" style="-webkit-text-stroke: 1px black;">Kho Skin Waifu & Husbando</h2>
            <button onclick="closeSkinModal()" class="font-black text-2xl hover:text-red-600">X</button>
        </div>
        
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6" id="skinGrid">
            <!-- Render via JS -->
        </div>
    </div>
</div>

<script>
(function() {
const mascotSkins = {
    'luffy': {
        name: 'Monkey D. Luffy',
        gif: '${pageContext.request.contextPath}/img/luffy.gif',
        img: 'onepiece.png',
        dialogues: [
            "Đói bụng quá! Có cuốn nào hay cho ăn... à nhầm, cho đọc không?",
            "Ta sẽ trở thành Vua Truyện Tranh!",
            "Thịt! Nhớ nạp xu mua truyện rồi đi ăn thịt nhé!",
            "Chốt đơn lẹ đi, thủy thủ đoàn đang chờ kìa!"
        ]
    },
    'doraemon': {
        name: 'Doraemon',
        gif: '${pageContext.request.contextPath}/img/doraemon.gif',
        img: 'doraemon.png',
        dialogues: [
            "Bảo bối của tớ là... Nạp Xu Siêu Tốc!",
            "Trời ơi, lại nợ tiền bánh rán rồi...",
            "Đọc bộ này hay lắm, Nobita dạo này cũng ghiền á!",
            "Cẩn thận chuột kìa! Á á á á!"
        ]
    },
    'jinwoo': {
        name: 'Sung Jin-Woo',
        gif: '${pageContext.request.contextPath}/img/sololeving.gif',
        img: 'sololeveling.png',
        dialogues: [
            "ARISE! Hãy trỗi dậy và chốt đơn đi!",
            "Tôi không bao giờ bỏ cuộc... kể cả khi hết xu.",
            "Mua lẹ đi, Gate cấp S sắp mở rồi đấy.",
            "Cảm nhận sát khí không? Là vì bạn chưa mua truyện đó."
        ]
    },
    'slime': {
        name: 'Rimuru Tempest',
        gif: '${pageContext.request.contextPath}/img/slime.gif',
        img: 'slime.png',
        dialogues: [
            "Ta không phải slime xấu đâu nha!",
            "Chà, dạo này quốc gia Jura của ta cũng đọc bộ này đấy.",
            "Cần skill gì không? Ta cho mượn Đại Hiền Giả nè.",
            "Gacha 1 phát không? Đảm bảo tỷ lệ drop SSR!"
        ]
    },
    'tanjiro': {
        name: 'Tanjiro',
        gif: '${pageContext.request.contextPath}/img/tanjiro.gif',
        img: 'kimetsunoyaiba.png',
        dialogues: [
            "Hơi thở của Wibu... Thức thứ nhất: Chốt Đơn!",
            "Nezuko cũng thích đọc bộ này lắm đó.",
            "Dù nghèo đói ta vẫn quyết mua truyện bản quyền!",
            "Đánh bại Muzan xong ta sẽ về cày hết bộ này."
        ]
    },
    'inosuke': {
        name: 'Hashibira Inosuke',
        gif: '${pageContext.request.contextPath}/img/inosuke.gif',
        img: 'kimetsunoyaiba.png',
        dialogues: [
            "ĐẤU VỚI TA ĐI! Tên khốn nào không nạp xu hả?!",
            "Trư Đột Mãnh Tiến!!! Truyện nào hay nhào hết vô đây!",
            "Cái hộp phát sáng này là cái gì? Sao nó lại hiện ra hình ảnh hả?!",
            "Gonpachiro! Ngươi dám mua truyện mà không rủ ta à?!"
        ]
    },
    'gojo': {
        name: 'Gojo Satoru',
        gif: '${pageContext.request.contextPath}/img/gojo.gif',
        img: 'jujutsukaisen.png',
        dialogues: [
            "Yowai mo... Vì bạn quá yếu nên mới hết xu đúng không?",
            "Đừng lo, thầy mạnh nhất mà, thầy bao tiền... đùa đấy tự nạp đi.",
            "Bành trướng lãnh địa... Vô lượng truyện tranh!",
            "Mua cuốn này đi, thầy tin là học trò của thầy sẽ thích."
        ]
    }
};

let currentSkin = localStorage.getItem('mascotSkin') || 'doraemon';
let bubbleTimeout;

// Initialize Mascot
function initMascot() {
    applySkin(currentSkin);
    
    // Auto popup bubble randomly every 15-30s
    setInterval(() => {
        if(Math.random() > 0.3) {
            showRandomDialogue();
        }
    }, 20000);
}

function applySkin(skinKey) {
    if(!mascotSkins[skinKey]) skinKey = 'doraemon';
    currentSkin = skinKey;
    localStorage.setItem('mascotSkin', currentSkin);
    
    const skin = mascotSkins[currentSkin];
    // Prefer GIF over static img if available
    const imageSrc = skin.gif ? skin.gif : '${pageContext.request.contextPath}/img/' + skin.img;
    document.getElementById('mascotImg').src = imageSrc;
    
    // Reset transform when skin changes
    const img = document.getElementById('mascotImg');
    if (img) img.style.transform = 'scaleX(1)';
}

// Make functions global so inline onclick handlers can call them
window.pokeMascot = function() {
    showRandomDialogue();
    const img = document.getElementById('mascotImg');
    if (!img) return;
    img.classList.add('animate-bounce');
    setTimeout(() => img.classList.remove('animate-bounce'), 1000);
    
    // Pause roaming when poked
    clearTimeout(roamTimeout);
    scheduleRoam();
}

// --- SHIMEJI DRAG & ROAM LOGIC ---
const widget = document.getElementById('mascotWidget');
let isDragging = false;
let startX, startY, initialLeft, initialTop;
let roamTimeout;

// Khôi phục vị trí cũ (có chống lỗi văng màn hình)
let savedLeft = localStorage.getItem('mascotLeft');
let savedTop = localStorage.getItem('mascotTop');

if(savedLeft && savedTop && !savedLeft.includes('NaN') && !savedTop.includes('NaN')) {
    let l = parseFloat(savedLeft);
    let t = parseFloat(savedTop);
    
    if (isNaN(l) || l < 0) l = 20;
    if (isNaN(t) || t < 150) t = window.innerHeight - 200; // Để chừa chỗ cho bong bóng chat
    if (l > window.innerWidth - 128) l = window.innerWidth - 128;
    if (t > window.innerHeight - 128) t = window.innerHeight - 128;
    
    widget.style.left = l + 'px';
    widget.style.top = t + 'px';
} else {
    // Mặc định góc dưới trái
    widget.style.left = '20px';
    widget.style.top = (window.innerHeight - 200) + 'px';
}

// Lắng nghe sự kiện kéo thả
widget.addEventListener('mousedown', dragStart);
document.addEventListener('mousemove', drag);
document.addEventListener('mouseup', dragEnd);

// Touch events cho điện thoại
widget.addEventListener('touchstart', dragStart, {passive: false});
document.addEventListener('touchmove', drag, {passive: false});
document.addEventListener('touchend', dragEnd);

function dragStart(e) {
    if(e.target.closest('#mascotBubble') || e.target.closest('button')) return; 
    isDragging = true;
    widget.style.cursor = 'grabbing';
    widget.style.transition = 'none'; // Tắt transition khi kéo cho mượt
    
    const clientX = e.type.includes('mouse') ? e.clientX : e.touches[0].clientX;
    const clientY = e.type.includes('mouse') ? e.clientY : e.touches[0].clientY;
    
    startX = clientX;
    startY = clientY;
    
    const rect = widget.getBoundingClientRect();
    initialLeft = rect.left;
    initialTop = rect.top;
    
    clearTimeout(roamTimeout);
}

function drag(e) {
    if (!isDragging) return;
    e.preventDefault();
    
    const clientX = e.type.includes('mouse') ? e.clientX : e.touches[0].clientX;
    const clientY = e.type.includes('mouse') ? e.clientY : e.touches[0].clientY;
    
    const dx = clientX - startX;
    const dy = clientY - startY;
    
    let newLeft = initialLeft + dx;
    let newTop = initialTop + dy;
    
    const rect = widget.getBoundingClientRect();
    if(newLeft < 0) newLeft = 0;
    if(newTop < 0) newTop = 0;
    if(newLeft + rect.width > window.innerWidth) newLeft = window.innerWidth - rect.width;
    if(newTop + rect.height > window.innerHeight) newTop = window.innerHeight - rect.height;
    
    widget.style.left = newLeft + 'px';
    widget.style.top = newTop + 'px';
}

function dragEnd(e) {
    if (!isDragging) return;
    isDragging = false;
    widget.style.cursor = 'grab';
    widget.style.transition = 'top 3s ease-in-out, left 3s ease-in-out'; 
    
    localStorage.setItem('mascotLeft', widget.style.left);
    localStorage.setItem('mascotTop', widget.style.top);
    
    scheduleRoam();
}

function scheduleRoam() {
    clearTimeout(roamTimeout);
    roamTimeout = setTimeout(roam, Math.random() * 5000 + 5000); // 5-10s
}

function roam() {
    if(isDragging) return;
    
    const rect = widget.getBoundingClientRect();
    const maxMove = 150; 
    
    let dx = (Math.random() - 0.5) * maxMove * 2;
    let dy = (Math.random() - 0.5) * maxMove * 2;
    
    let newLeft = rect.left + dx;
    let newTop = rect.top + dy;
    
    if(newLeft < 0) newLeft = 0;
    if(newTop < 0) newTop = 0;
    if(newLeft + rect.width > window.innerWidth) newLeft = window.innerWidth - rect.width;
    if(newTop + rect.height > window.innerHeight) newTop = window.innerHeight - rect.height;
    
    widget.style.left = newLeft + 'px';
    widget.style.top = newTop + 'px';
    
    // Lật mặt Mascot theo hướng di chuyển
    const img = document.getElementById('mascotImg');
    if (dx > 0) {
        img.style.transform = 'scaleX(-1)';
    } else {
        img.style.transform = 'scaleX(1)';
    }
    
    localStorage.setItem('mascotLeft', widget.style.left);
    localStorage.setItem('mascotTop', widget.style.top);
    
    scheduleRoam();
}

// Khởi động Shimeji
scheduleRoam();
// --- END SHIMEJI LOGIC ---

window.showRandomDialogue = function() {
    const bubble = document.getElementById('mascotBubble');
    const textDiv = document.getElementById('mascotDialogText');
    if (!bubble || !textDiv) return;
    const skin = mascotSkins[currentSkin];
    
    const randomMsg = skin.dialogues[Math.floor(Math.random() * skin.dialogues.length)];
    textDiv.textContent = randomMsg;
    
    bubble.classList.remove('scale-0');
    bubble.classList.add('scale-100');
    
    clearTimeout(bubbleTimeout);
    bubbleTimeout = setTimeout(() => {
        bubble.classList.remove('scale-100');
        bubble.classList.add('scale-0');
    }, 5000);
}

window.openSkinModal = function() {
    const modal = document.getElementById('skinModal');
    if (modal) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
        renderSkinGrid();
    }
}

window.closeSkinModal = function() {
    const modal = document.getElementById('skinModal');
    if (modal) {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}

function renderSkinGrid() {
    const grid = document.getElementById('skinGrid');
    grid.innerHTML = '';
    
    Object.keys(mascotSkins).forEach(key => {
        const skin = mascotSkins[key];
        const isSelected = key === currentSkin;
        
        const card = document.createElement('div');
        card.className = `border-4 border-black p-4 flex flex-col items-center justify-center cursor-pointer transition-transform hover:-translate-y-1 min-h-[80px] ${isSelected ? 'bg-yellow-300 shadow-[8px_8px_0_0_#000]' : 'bg-gray-100 shadow-[4px_4px_0_0_#000]'}`;
        card.onclick = () => {
            applySkin(key);
            closeSkinModal();
            showRandomDialogue();
        };
        
        card.innerHTML = `
            <span class="font-black text-center text-sm md:text-base uppercase ${isSelected ? 'text-red-600' : 'text-black'} break-words">${skin.name}</span>
            ${isSelected ? '<span class="bg-black text-white text-xs px-2 mt-2">Đang Dùng</span>' : ''}
        `;
        
        grid.appendChild(card);
    });
}

// Start everything
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initMascot);
} else {
    initMascot();
}

})();
</script>
