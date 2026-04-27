document.addEventListener('DOMContentLoaded', () => {
    const checklist = document.getElementById('daily-checklist');
    const progressBar = document.getElementById('daily-progress');
    const completionText = document.getElementById('completion-text');
    const statusDesc = document.getElementById('status-desc');
    const updateChestBtn = document.getElementById('update-chest');
    const navLinks = document.querySelectorAll('.nav-links li');
    const tabContents = document.querySelectorAll('.tab-content');

    const ranks = [
        "Gafil (Uykuda)",
        "Nefs-i Emmare",
        "Nefs-i Levvame",
        "Fütüvvet Yolcusu",
        "Alperen (Gazi-Derviş)"
    ];

    // Tab Navigation
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            const target = link.dataset.tab;
            
            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
            
            tabContents.forEach(content => {
                content.classList.remove('active');
                if (content.id === target) content.classList.add('active');
            });
        });
    });

    // Load State
    const loadState = () => {
        const saved = JSON.parse(localStorage.getItem('kayra_state') || '{}');
        checklist.querySelectorAll('input[type="checkbox"]').forEach(cb => {
            if (saved[cb.id]) cb.checked = true;
        });
        
        const warchest = JSON.parse(localStorage.getItem('kayra_warchest') || '{"target": 10000, "current": 0}');
        document.getElementById('target-saving').value = warchest.target;
        document.getElementById('current-saving').value = warchest.current;
        
        updateProgress();
        updateWarChestVisuals();
    };

    // Save State
    const saveState = () => {
        const state = {};
        checklist.querySelectorAll('input[type="checkbox"]').forEach(cb => {
            state[cb.id] = cb.checked;
        });
        localStorage.setItem('kayra_state', JSON.stringify(state));
    };

    const updateProgress = () => {
        const checkboxes = checklist.querySelectorAll('input[type="checkbox"]');
        let totalPoints = 0;
        let earnedPoints = 0;

        checkboxes.forEach(cb => {
            const points = parseInt(cb.dataset.points);
            totalPoints += points;
            if (cb.checked) earnedPoints += points;
        });

        const percentage = Math.round((earnedPoints / totalPoints) * 100) || 0;
        progressBar.style.width = `${percentage}%`;
        completionText.innerText = `${percentage}%`;

        // Update Rank
        let rankIndex = Math.floor(percentage / 21);
        if (rankIndex >= ranks.length) rankIndex = ranks.length - 1;
        statusDesc.innerHTML = `Makam: <strong>${ranks[rankIndex]}</strong>`;
        
        saveState();
    };

    const updateWarChestVisuals = () => {
        const target = parseFloat(document.getElementById('target-saving').value) || 1;
        const current = parseFloat(document.getElementById('current-saving').value) || 0;
        const fill = document.getElementById('saving-fill');
        
        const percentage = Math.min(Math.round((current / target) * 100), 100);
        fill.style.width = `${percentage}%`;
        
        localStorage.setItem('kayra_warchest', JSON.stringify({target, current}));
    };

    // Protocol Data for Modals
    const protocolData = {
        bio: {
            title: "01. BİYOLOJİK SERMAYE",
            content: `<h3>Sünnet Beslenme ve Oruç</h3><p>Alperen, midenin üçte birini gıdaya, üçte birini suya ayıran <strong>Sünnetullah</strong> üzere yaşar. İşlenmiş sentetik gıdalar iradeyi felç eden biyokimyasal silahlardır.</p><h3>Vücut Dili</h3><p>Dik bir duruş, kararlı bakışlar ve heybetli bir vakar... Kuvvetli mümin, zayıf müminden daha hayırlıdır.</p><h3>Aksiyon</h3><p>Haftalık Pazartesi-Perşembe oruçları ve ağır direnç antrenmanları biyolojik donanımı şahlandırır.</p>`
        },
        mental: {
            title: "02. ZİHİNSEL MÜHENDİSLİK",
            content: `<h3>Gaflet Detoksu</h3><p>Dopamin sarmalından kurtulmak için dijital izolasyon ve tefekkür şarttır. Matrix'in vesveselerine karşı <strong>Zihinsel Kalkan</strong> örülür.</p><h3>Tevekkül ve Rıza</h3><p>Kriz anında "Hasbunallah" frekansına geçmek ve neticeden razı olmak, stoacılığın ötesindeki Alperen derinliğidir. Kader, gayrete aşıktır.</p>`
        },
        social: {
            title: "03. SOSYAL STRATEJİ",
            content: `<h3>Kavvamlık</h3><p>Erkeğin asli vazifesi evini ve sevdiklerini zehirli kültürden koruyan bir <strong>Barikat</strong> olmaktır. Adaletle yönet, merhametle kolla.</p><h3>İhvan Ağı</h3><p>Fasıkları ele, sırtını dayayabileceğin sadık kardeşlerle bir Siber-Asabiyet kur. Kardeşlik asıldır.</p>`
        },
        logic: {
            title: "04. LOJİSTİK VE GÜÇ",
            content: `<h3>Ahi Sandığı</h3><p>Parasız dava edebiyattır. <strong>War Chest</strong> (Savaş Sandığı) özgürlük mermindir. Faizin (Riba) kölesi olma. Kendi helal ekosistemini kur.</p><h3>Helal Kazanç</h3><p>Ticarette dürüstlük, yüksek katma değer ve infak kültürü... Lojistik, ebedi cihadın yakıtıdır.</p>`
        }
    };

    window.showModuleDetail = (key) => {
        const data = protocolData[key];
        document.getElementById('modal-title').innerText = data.title;
        document.getElementById('modal-body').innerHTML = data.content;
        document.getElementById('module-modal').style.display = 'block';
    };

    window.closeModal = () => {
        document.getElementById('module-modal').style.display = 'none';
    };

    window.onclick = (event) => {
        const modal = document.getElementById('module-modal');
        if (event.target == modal) closeModal();
    };

    // Events
    checklist.addEventListener('change', updateProgress);
    
    updateChestBtn.addEventListener('click', () => {
        updateWarChestVisuals();
        alert("Lojistik sandığı güncellendi. Bereketli olsun!");
    });

    // Initial Load
    loadState();
});
