<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Chatbot Mascot Widget -->
<div id="mascotWidget" class="fixed bottom-4 left-4 z-[9000] flex flex-col items-start hidden">
    <!-- Chat Bubble -->
    <div id="mascotBubble" class="bg-white border-4 border-black p-4 mb-2 shadow-[4px_4px_0_0_#000] relative max-w-xs transform transition-all duration-300 scale-0 origin-bottom-left cursor-pointer hover:-translate-y-1">
        <div id="mascotDialogText" class="font-bold text-sm text-dark">Xin chào! Tớ là trợ lý của sếp đây.</div>
        <div class="absolute -bottom-3 left-6 w-0 h-0 border-l-[10px] border-l-transparent border-t-[14px] border-t-black border-r-[10px] border-r-transparent"></div>
        <div class="absolute -bottom-1 left-[26px] w-0 h-0 border-l-[6px] border-l-transparent border-t-[8px] border-t-white border-r-[6px] border-r-transparent"></div>
        
        <!-- Button change skin inside bubble -->
        <button onclick="openSkinModal()" class="mt-2 text-xs font-black text-primary hover:text-accent uppercase underline">Đổi Waifu/Husbando</button>
    </div>

    <!-- Mascot Image -->
    <div id="mascotImageContainer" class="relative cursor-pointer transition-transform hover:scale-110" onclick="pokeMascot()">
        <img id="mascotImg" src="${pageContext.request.contextPath}/img/doraemon.png" class="w-32 h-32 object-contain filter drop-shadow-[4px_4px_0_rgba(0,0,0,1)] hover:drop-shadow-[6px_6px_0_rgba(0,0,0,1)] transition-all">
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
const mascotSkins = {
    'luffy': {
        name: 'Monkey D. Luffy',
        img: 'onepiece.png',
        dialogues: [
            "Đói bụng quá! Có cuốn nào hay cho ăn... à nhầm, cho đọc không?",
            "Ta sẽ trở thành Vua Truyện Tranh!",
            "Thịt! Nhớ nạp xu mua truyện rồi đi ăn thịt nhé!",
            "Chốt đơn lẹ đi, thủy thủ đoàn đang chờ kìa!"
        ]
    },
    'frieren': {
        name: 'Frieren',
        img: 'frieren.png',
        dialogues: [
            "Hửm? Một ngày mới lại trôi qua à... Đọc truyện đi.",
            "Truyện này xem chừng cũng khá thú vị, ta đã sống đủ lâu để chứng kiến.",
            "Lại phải nạp xu à? Đời người thật ngắn ngủi...",
            "Phép thuật xịn nhất là voucher giảm giá đó."
        ]
    },
    'conan': {
        name: 'Edogawa Conan',
        img: 'conan.png',
        dialogues: [
            "Sự thật luôn chỉ có một! Bạn đang muốn mua cuốn này!",
            "Này chị Ran... à quên, này bạn đọc, cuốn này đang hot lắm đó!",
            "Hung thủ chính là... khoan, đọc tự hiểu đi nha!",
            "Đừng nhìn tớ, tớ chỉ là một học sinh tiểu học thôi..."
        ]
    },
    'doraemon': {
        name: 'Doraemon',
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
        img: 'kimetsunoyaiba.png',
        dialogues: [
            "Hơi thở của Wibu... Thức thứ nhất: Chốt Đơn!",
            "Nezuko cũng thích đọc bộ này lắm đó.",
            "Dù nghèo đói ta vẫn quyết mua truyện bản quyền!",
            "Đánh bại Muzan xong ta sẽ về cày hết bộ này."
        ]
    },
    'gojo': {
        name: 'Gojo Satoru',
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

document.addEventListener('DOMContentLoaded', () => {
    const widget = document.getElementById('mascotWidget');
    widget.classList.remove('hidden');
    applySkin(currentSkin);
    
    // Auto popup bubble randomly every 15-30s
    setInterval(() => {
        if(Math.random() > 0.3) {
            showRandomDialogue();
        }
    }, 20000);
});

function applySkin(skinKey) {
    if(!mascotSkins[skinKey]) skinKey = 'doraemon';
    currentSkin = skinKey;
    localStorage.setItem('mascotSkin', currentSkin);
    
    const skin = mascotSkins[currentSkin];
    document.getElementById('mascotImg').src = '${pageContext.request.contextPath}/img/' + skin.img;
}

function pokeMascot() {
    showRandomDialogue();
    const img = document.getElementById('mascotImg');
    img.classList.add('animate-spin');
    setTimeout(() => img.classList.remove('animate-spin'), 500);
}

function showRandomDialogue() {
    const bubble = document.getElementById('mascotBubble');
    const textDiv = document.getElementById('mascotDialogText');
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

function openSkinModal() {
    document.getElementById('skinModal').classList.remove('hidden');
    document.getElementById('skinModal').classList.add('flex');
    renderSkinGrid();
}

function closeSkinModal() {
    document.getElementById('skinModal').classList.add('hidden');
    document.getElementById('skinModal').classList.remove('flex');
}

function renderSkinGrid() {
    const grid = document.getElementById('skinGrid');
    grid.innerHTML = '';
    
    Object.keys(mascotSkins).forEach(key => {
        const skin = mascotSkins[key];
        const isSelected = key === currentSkin;
        
        const card = document.createElement('div');
        card.className = `border-4 border-black p-4 flex flex-col items-center cursor-pointer transition-transform hover:-translate-y-2 ${isSelected ? 'bg-yellow-300 shadow-[8px_8px_0_0_#000]' : 'bg-gray-100'}`;
        card.onclick = () => {
            applySkin(key);
            closeSkinModal();
            showRandomDialogue();
        };
        
        card.innerHTML = `
            <img src="${pageContext.request.contextPath}/img/${skin.img}" class="w-24 h-24 object-contain mb-4 filter drop-shadow-[2px_2px_0_#000]">
            <span class="font-black text-center uppercase ${isSelected ? 'text-red-600' : 'text-dark'}">${skin.name}</span>
            ${isSelected ? '<span class="bg-black text-white text-xs px-2 mt-2">Đang Dùng</span>' : ''}
        `;
        
        grid.appendChild(card);
    });
}
</script>
