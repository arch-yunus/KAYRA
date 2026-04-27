document.addEventListener('DOMContentLoaded', () => {
    const checklist = document.getElementById('daily-checklist');
    const progressBar = document.getElementById('daily-progress');
    const completionText = document.getElementById('completion-text');
    const statusDesc = document.getElementById('status-desc');
    const updateChestBtn = document.getElementById('update-chest');
    const navLinks = document.querySelectorAll('.nav-links li');
    const tabContents = document.querySelectorAll('.tab-content');

    const ranks = ["Gafil", "Nefs-i Emmare", "Nefs-i Levvame", "Yolcu", "Alperen"];

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

    const updateProgress = () => {
        const checkboxes = checklist.querySelectorAll('input[type="checkbox"]');
        let total = 0, earned = 0;
        checkboxes.forEach(cb => {
            const pts = parseInt(cb.dataset.points);
            total += pts;
            if (cb.checked) earned += pts;
        });
        const percentage = Math.round((earned / total) * 100) || 0;
        progressBar.style.width = `${percentage}%`;
        completionText.innerText = `${percentage}%`;
        statusDesc.innerHTML = `Makam: <strong>${ranks[Math.floor(percentage / 21)] || "Alperen"}</strong>`;
        localStorage.setItem('kayra_state', JSON.stringify([...checkboxes].reduce((a, c) => ({...a, [c.id]: c.checked}), {})));
    };

    const updateWarChestVisuals = () => {
        const target = parseFloat(document.getElementById('target-saving').value) || 1;
        const current = parseFloat(document.getElementById('current-saving').value) || 0;
        const perc = Math.min(Math.round((current / target) * 100), 100);
        document.getElementById('saving-fill').style.width = `${perc}%`;
        localStorage.setItem('kayra_warchest', JSON.stringify({target, current}));
    };

    // Protocol Detail Data
    const protocolData = {
        bio: { title: "01. BİYOLOJİK SERMAYE", content: "<h3>Beslenme ve Oruç</h3><p>Paketli gıdayı terk et. Haftada 2 gün oruç tut. Bedenin senin karargahındır.</p><h3>Demir</h3><p>Kuvvet idmanı farz-ı kifaye düzeyindedir. Güçsüzlük, gafletin fiziksel formudur.</p>" },
        mental: { title: "02. ZİHİNSEL MÜHENDİSLİK", content: "<h3>Kripto-Tasavvuf</h3><p>Zihnini bir firewall gibi koru. Vesveseleri 'Hasbunallah' ile blokla. İhalas ile amellerini şifrele.</p><h3>Vesvese Filtresi</h3><p>Matrix manipülasyonlarını anında imha et.</p>" },
        social: { title: "03. SOSYAL STRATEJİ", content: "<h3>Kavvamlık</h3><p>Aileni ve ihvanını koruyan aşılmaz bir barikat ol. Adaletle yönet.</p><h3>Asabiyet</h3><p>Kenetlenmiş bir hücre yapısı kur. Yalnız kurt av olur.</p>" },
        logic: { title: "04. LOJİSTİK VE GÜÇ", content: "<h3>Ahi Sandığı</h3><p>Lojistik özgürlüktür. Rezervlerini her ay %20 artır.</p><h3>Siber Cihad</h3><p>Kod yazmak kılıç kuşanmaktır. Teknolojik dominans sağla.</p>" },
        legacy: { title: "05. SİBER VAKIF VE ZUNJİ", content: "<h3>Dijital Sadaka</h3><p>Ölümünden sonra da faydası sürecek kodlar, ilimler ve arşivler bırak.</p><h3>Zunji Stratejisi</h3><p>Mirasını ve ihvan hiyerarşisini planla. Sancağı devredecek aslanlar yetiştir.</p>" }
    };

    window.showModuleDetail = (key) => {
        const d = protocolData[key];
        document.getElementById('modal-title').innerText = d.title;
        document.getElementById('modal-body').innerHTML = d.content;
        document.getElementById('module-modal').style.display = 'block';
    };

    window.closeModal = () => document.getElementById('module-modal').style.display = 'none';
    checklist.addEventListener('change', updateProgress);
    updateChestBtn.addEventListener('click', () => { updateWarChestVisuals(); alert("Lojistik güncellendi."); });
    loadState();
});
