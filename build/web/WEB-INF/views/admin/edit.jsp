<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="max-w-3xl mx-auto bg-white border-4 border-black shadow-comic-lg overflow-hidden mt-8 transform -rotate-1">
    
    <div class="bg-accent border-b-4 border-black p-6 flex items-center justify-between">
        <div class="flex items-center gap-4">
            <h2 class="text-4xl font-comic text-dark tracking-widest uppercase" style="-webkit-text-stroke: 1px black;">SỬA TRUYỆN TRANH</h2>
            <span class="bg-white border-4 border-black font-black px-2 shadow-comic transform rotate-3">#${sach.maSach}</span>
        </div>
        <span class="text-4xl">🛠️</span>
    </div>
    
    <div class="p-8">
        <form id="editBookForm" action="${pageContext.request.contextPath}/admin" method="POST" enctype="multipart/form-data" class="space-y-6" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="maSach" value="${sach.maSach}">
            
            <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform rotate-1">
                <label class="block text-xl font-black text-dark mb-2 uppercase">TÊN TRUYỆN TRANH <span class="text-primary">*</span></label>
                <input type="text" id="tenSach" name="tenSach" value="${sach.tenSach}" required minlength="3" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg">
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">GIÁ BÁN (VNĐ) <span class="text-primary">*</span></label>
                    <input type="number" id="giaTien" name="giaTien" value="${sach.giaTien}" required min="1000" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg">
                </div>
                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">SỐ LƯỢNG KHO <span class="text-primary">*</span></label>
                    <input type="number" id="soLuong" name="soLuong" value="${sach.soLuong}" required min="0" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg">
                </div>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">CHỦ ĐỀ (THỂ LOẠI) <span class="text-primary">*</span></label>
                    <select name="theLoai" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg cursor-pointer">
                        <option value="Hành động" ${sach.theLoai == 'Hành động' ? 'selected' : ''}>Hành động</option>
                        <option value="Kỳ ảo" ${sach.theLoai == 'Kỳ ảo' ? 'selected' : ''}>Kỳ ảo</option>
                        <option value="Tình cảm" ${sach.theLoai == 'Tình cảm' ? 'selected' : ''}>Tình cảm</option>
                        <option value="Hài hước" ${sach.theLoai == 'Hài hước' ? 'selected' : ''}>Hài hước</option>
                        <option value="Thể thao" ${sach.theLoai == 'Thể thao' ? 'selected' : ''}>Thể thao</option>
                        <option value="Tâm lý" ${sach.theLoai == 'Tâm lý' ? 'selected' : ''}>Tâm lý</option>
                        <option value="Trinh thám" ${sach.theLoai == 'Trinh thám' ? 'selected' : ''}>Trinh thám</option>
                        <option value="Võ thuật" ${sach.theLoai == 'Võ thuật' ? 'selected' : ''}>Võ thuật</option>
                        <option value="Khác" ${sach.theLoai == 'Khác' || empty sach.theLoai ? 'selected' : ''}>Khác</option>
                    </select>
                </div>

                <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform rotate-1">
                    <label class="block text-xl font-black text-dark mb-2 uppercase">LINK TRAILER YOUTUBE (Tùy chọn)</label>
                    <input type="text" id="trailerUrl" name="trailerUrl" value="${sach.trailerUrl}" class="w-full px-4 py-3 border-4 border-black focus:ring-0 focus:outline-none focus:border-primary font-bold bg-white text-lg" placeholder="Ví dụ: https://www.youtube.com/embed/S8_YwFLCh4U">
                </div>
            </div>

            <div class="bg-gray-100 p-6 border-4 border-black shadow-comic transform -rotate-1">
                <label class="block text-xl font-black text-dark mb-4 uppercase">ẢNH BÌA</label>
                
                <div class="flex gap-6 items-start bg-white border-4 border-black p-4 shadow-inner">
                    <c:choose>
                        <c:when test="${not empty sach.hinhAnh}">
                            <div class="w-24 h-32 flex-shrink-0 border-4 border-black shadow-comic transform rotate-3 relative bg-white">
                                <img src="${pageContext.request.contextPath}/img/${sach.hinhAnh}" class="w-full h-full object-cover">
                                <div class="absolute -top-3 -right-3 bg-secondary text-dark text-xs font-black border-2 border-black px-1 transform rotate-12">BÌA CŨ</div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w-24 h-32 flex-shrink-0 border-4 border-dashed border-black bg-gray-200 flex items-center justify-center font-comic text-xl transform rotate-3">NO IMG</div>
                        </c:otherwise>
                    </c:choose>
                    
                    <input type="hidden" name="oldHinhAnh" value="${sach.hinhAnh}">
                    
                    <div class="flex-grow">
                        <label class="block text-sm font-black text-dark mb-2 uppercase">CHỌN ẢNH BÌA MỚI NẾU MUỐN ĐỔI:</label>
                        <input type="file" id="hinhAnh" name="hinhAnh" accept="image/*" class="w-full px-3 py-2 border-4 border-black bg-white cursor-pointer font-bold">
                    </div>
                </div>
            </div>
            
            <div class="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4">
                <a href="${pageContext.request.contextPath}/admin" class="w-full sm:w-auto text-center font-black uppercase border-4 border-black px-8 py-3 bg-white hover:bg-gray-200 shadow-comic transition">HỦY BỎ</a>
                <button type="submit" class="w-full sm:w-auto bg-primary text-white font-comic text-3xl tracking-widest uppercase border-4 border-black px-12 py-3 shadow-comic hover:shadow-comic-lg hover:-translate-y-1 transition" style="-webkit-text-stroke: 1px black;">
                    LƯU LẠI!
                </button>
            </div>
            </div>
        </form>

        <script>
        document.getElementById('editBookForm').addEventListener('submit', function(e) {
            const ten = document.getElementById('tenSach');
            const gia = document.getElementById('giaTien');
            const sl = document.getElementById('soLuong');
            let errorMsg = '';
            
            [ten, gia, sl].forEach(el => el.classList.remove('border-primary'));
            
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
