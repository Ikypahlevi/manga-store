<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="max-w-3xl mx-auto bg-white border-4 border-black shadow-comic-lg overflow-hidden mt-8 transform rotate-1">
    
    <div class="bg-secondary border-b-4 border-black p-6 flex items-center justify-between">
        <h2 class="text-4xl font-comic text-dark tracking-widest uppercase" style="-webkit-text-stroke: 1px black;">THÊM MANGA MỚI!</h2>
        <span class="text-4xl">💥</span>
    </div>
    
    <div class="p-8">
        <form id="addBookForm" action="${pageContext.request.contextPath}/admin" method="POST" enctype="multipart/form-data" class="space-y-6" novalidate>
            <input type="hidden" name="action" value="add">
            
            <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                <label class="block text-xl font-black text-dark mb-2 uppercase">TÊN TRUYỆN TRANH <span class="text-primary">*</span></label>
                <input type="text" id="tenSach" name="tenSach" required minlength="3" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg" placeholder="Nhập tên siêu phẩm...">
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">GIÁ BÁN (VNĐ) <span class="text-primary">*</span></label>
                    <input type="number" id="giaTien" name="giaTien" required min="1000" class="w-full text-black px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg">
                </div>
                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">SỐ LƯỢNG NHẬP <span class="text-primary">*</span></label>
                    <input type="number" id="soLuong" name="soLuong" required min="0" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg" value="1">
                </div>
            </div>
            
            <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                <label class="block text-xl font-black text-dark mb-2 uppercase">LINK TRAILER YOUTUBE (Tùy chọn)</label>
                <input type="text" id="trailerUrl" name="trailerUrl" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg" placeholder="Ví dụ: https://www.youtube.com/embed/S8_YwFLCh4U">
            </div>

            <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform rotate-1">
                <label class="block text-xl font-black text-dark mb-2 uppercase">ẢNH BÌA</label>
                <input type="file" id="hinhAnh" name="hinhAnh" required accept="image/*" class="w-full text-black px-4 py-3 border-4 border-dashed border-black bg-white font-bold cursor-pointer">
            </div>
            
            <div class="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4">
                <a href="${pageContext.request.contextPath}/admin" class="w-full sm:w-auto text-center font-black uppercase border-4 border-black px-8 py-3 bg-white hover:bg-gray-200 shadow-comic transition">QUAY XE</a>
                <button type="submit" class="w-full sm:w-auto bg-primary text-white font-comic text-3xl tracking-widest uppercase border-4 border-black px-12 py-3 shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition" style="-webkit-text-stroke: 1px black;">
                    LÊN KỆ NGAY!
                </button>
            </div>
            </div>
        </form>

        <script>
        document.getElementById('addBookForm').addEventListener('submit', function(e) {
            const ten = document.getElementById('tenSach');
            const gia = document.getElementById('giaTien');
            const sl = document.getElementById('soLuong');
            const file = document.getElementById('hinhAnh');
            let errorMsg = '';
            
            [ten, gia, sl, file].forEach(el => el.classList.remove('border-primary'));
            
            if (!ten.value.trim() || ten.value.trim().length < 3) {
                errorMsg = 'Tên truyện phải từ 3 ký tự!';
                ten.classList.add('border-primary');
                ten.focus();
            } else if (!gia.value || parseInt(gia.value) < 1000) {
                errorMsg = 'Giá tiền phải lớn hơn 1000 VNĐ!';
                gia.classList.add('border-primary');
                gia.focus();
            } else if (!sl.value || parseInt(sl.value) < 0) {
                errorMsg = 'Số lượng không được âm!';
                sl.classList.add('border-primary');
                sl.focus();
            } else if (!file.value) {
                errorMsg = 'Vui lòng chọn ảnh bìa!';
                file.classList.add('border-primary');
                file.focus();
            }
            
            if (errorMsg) {
                e.preventDefault();
                if(typeof showToast === 'function') showToast(errorMsg, 'error');
                else alert(errorMsg);
            }
        });
        </script>
    </div>
</div>
