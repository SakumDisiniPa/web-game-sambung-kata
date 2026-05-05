// Data untuk platform download
const downloadData = [
    {
        name: "Android",
        description: "Mainkan di smartphone kamu.",
        file: "https://github.com/SakumDisiniPa/game-sambung-kata/releases/download/V1.6.4/app-release.apk",
        icon: "assets/android.png",
        btnText: "Download APK",
        type: "android"
    },
    {
        name: "Windows",
        description: "Instalasi satu-klik untuk PC.",
        file: "app/installer/install.bat",
        icon: "assets/windows.png",
        btnText: "Download Installer",
        type: "windows"
    },
    {
        name: "Linux",
        description: "Instalasi cepat via terminal.",
        file: "app/installer/install.sh",
        icon: "assets/linux.png",
        btnText: "Download Installer",
        type: "linux"
    },
    {
        name: "Source Code",
        description: "Lihat kode sumber di GitHub.",
        file: "https://github.com/SakumDisiniPa/game-sambung-kata",
        icon: "assets/github.png",
        btnText: "View on GitHub",
        type: "github"
    }
];

// Fungsi untuk Tab Tutorial
window.openTab = function(evt, tabName) {
    let i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
        tabcontent[i].classList.remove("active");
    }
    tablinks = document.getElementsByClassName("tab-btn");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove("active");
    }
    document.getElementById(tabName).style.display = "block";
    document.getElementById(tabName).classList.add("active");
    evt.currentTarget.classList.add("active");
}

// Fungsi Copy to Clipboard
window.copyToClipboard = function(elementId) {
    const text = document.getElementById(elementId).innerText;
    navigator.clipboard.writeText(text).then(() => {
        const btn = document.querySelector(`button[onclick="copyToClipboard('${elementId}')"]`);
        const originalHTML = btn.innerHTML;
        btn.innerHTML = '<i data-lucide="check" style="color: #4ade80"></i>';
        lucide.createIcons();
        setTimeout(() => {
            btn.innerHTML = originalHTML;
            lucide.createIcons();
        }, 2000);
    }).catch(err => {
        console.error('Gagal menyalin: ', err);
    });
}

// Fungsi untuk me-render card download
function renderDownloads() {
    const grid = document.getElementById('download-grid');
    if (!grid) return;

    grid.innerHTML = downloadData.map(item => `
        <div class="download-card animate-card">
            <div class="platform-icon">
                <img src="${item.icon}" alt="${item.name} Icon">
            </div>
            <h3>${item.name}</h3>
            <p>${item.description}</p>
            <a href="${item.file}" class="btn btn-download" ${item.type !== 'github' ? 'download' : 'target="_blank"'}>
                <span>${item.btnText}</span>
            </a>
            ${item.type === 'linux' ? '<small>Jalankan <code>bash install.sh</code></small>' : ''}
            ${item.type === 'windows' ? '<small>Otomatis setup Desktop.</small>' : ''}
        </div>
    `).join('');
}

// Inisialisasi
document.addEventListener('DOMContentLoaded', () => {
    // Render downloads
    renderDownloads();

    // Initialize Lucide icons
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }

    // Mobile Menu Logic
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const navLinks = document.querySelector('nav ul');

    if (mobileMenuBtn && navLinks) {
        mobileMenuBtn.addEventListener('click', () => {
            navLinks.classList.toggle('nav-active');
            
            // Change icon based on state
            const icon = mobileMenuBtn.querySelector('i');
            if (navLinks.classList.contains('nav-active')) {
                icon.setAttribute('data-lucide', 'x');
            } else {
                icon.setAttribute('data-lucide', 'more-vertical');
            }
            lucide.createIcons();
        });

        // Close menu when clicking a link
        navLinks.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                navLinks.classList.remove('nav-active');
                const icon = mobileMenuBtn.querySelector('i');
                icon.setAttribute('data-lucide', 'more-vertical');
                lucide.createIcons();
            });
        });
    }

    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});
