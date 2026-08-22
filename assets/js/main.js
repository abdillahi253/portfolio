/* ============================================================
   Portfolio — Abdillahi Mohamed
   Script principal / Main script
   ============================================================ */

(function () {
  'use strict';

  var STORAGE_LANG = 'portfolio-lang';
  var STORAGE_THEME = 'portfolio-theme';
  var SUPPORTED_LANGS = ['fr', 'en'];
  var dict = window.TRANSLATIONS || {};

  /* --------------------------------------------------------
     Stockage local (peut échouer en navigation privée)
     -------------------------------------------------------- */
  function readStore(key) {
    try {
      return window.localStorage.getItem(key);
    } catch (e) {
      return null;
    }
  }

  function writeStore(key, value) {
    try {
      window.localStorage.setItem(key, value);
    } catch (e) {
      /* stockage indisponible : on ignore */
    }
  }

  /* --------------------------------------------------------
     LANGUE
     -------------------------------------------------------- */
  var currentLang = 'fr';

  function detectLang() {
    var stored = readStore(STORAGE_LANG);
    if (SUPPORTED_LANGS.indexOf(stored) !== -1) return stored;
    var nav = (navigator.language || 'fr').slice(0, 2).toLowerCase();
    return SUPPORTED_LANGS.indexOf(nav) !== -1 ? nav : 'fr';
  }

  function t(key) {
    var pack = dict[currentLang] || {};
    return Object.prototype.hasOwnProperty.call(pack, key) ? pack[key] : key;
  }

  function translateTree(root) {
    root.querySelectorAll('[data-i18n]').forEach(function (el) {
      el.textContent = t(el.getAttribute('data-i18n'));
    });

    // Contenu balisé provenant uniquement du dictionnaire interne (pas de saisie utilisateur)
    root.querySelectorAll('[data-i18n-html]').forEach(function (el) {
      el.innerHTML = t(el.getAttribute('data-i18n-html'));
    });

    root.querySelectorAll('[data-i18n-aria]').forEach(function (el) {
      el.setAttribute('aria-label', t(el.getAttribute('data-i18n-aria')));
    });

    root.querySelectorAll('[data-i18n-alt]').forEach(function (el) {
      el.setAttribute('alt', t(el.getAttribute('data-i18n-alt')));
    });

    root.querySelectorAll('[data-i18n-download]').forEach(function (el) {
      el.setAttribute('download', t(el.getAttribute('data-i18n-download')));
    });
  }

  function applyLang(lang) {
    if (SUPPORTED_LANGS.indexOf(lang) === -1) lang = 'fr';
    currentLang = lang;
    document.documentElement.setAttribute('lang', lang);

    translateTree(document);

    document.title = t('meta.title');
    var desc = document.querySelector('meta[name="description"]');
    if (desc) desc.setAttribute('content', t('meta.description'));

    writeStore(STORAGE_LANG, lang);
  }

  /* --------------------------------------------------------
     THÈME CLAIR / SOMBRE
     -------------------------------------------------------- */
  function applyTheme(theme) {
    var next = theme === 'dark' ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', next);
    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta) meta.setAttribute('content', next === 'dark' ? '#0c0c0e' : '#f6f4ef');
    writeStore(STORAGE_THEME, next);
  }

  function currentTheme() {
    return document.documentElement.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
  }

  /* --------------------------------------------------------
     MENU MOBILE
     -------------------------------------------------------- */
  var burger = document.getElementById('burger');
  var navLinks = document.getElementById('navLinks');

  function closeMenu() {
    if (!burger || !navLinks) return;
    burger.classList.remove('open');
    navLinks.classList.remove('open');
    burger.setAttribute('aria-expanded', 'false');
  }

  if (burger && navLinks) {
    burger.addEventListener('click', function () {
      var open = navLinks.classList.toggle('open');
      burger.classList.toggle('open', open);
      burger.setAttribute('aria-expanded', String(open));
    });
    navLinks.querySelectorAll('a').forEach(function (link) {
      link.addEventListener('click', closeMenu);
    });
  }

  /* --------------------------------------------------------
     BOUTONS LANGUE & THÈME
     -------------------------------------------------------- */
  var langToggle = document.getElementById('langToggle');
  if (langToggle) {
    langToggle.addEventListener('click', function () {
      applyLang(currentLang === 'fr' ? 'en' : 'fr');
    });
  }

  var themeToggle = document.getElementById('themeToggle');
  if (themeToggle) {
    themeToggle.addEventListener('click', function () {
      applyTheme(currentTheme() === 'dark' ? 'light' : 'dark');
    });
  }

  /* --------------------------------------------------------
     APPARITION AU SCROLL
     -------------------------------------------------------- */
  var revealObserver = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          revealObserver.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15 }
  );

  document.querySelectorAll('.reveal, .timeline-item').forEach(function (el) {
    revealObserver.observe(el);
  });

  /* --------------------------------------------------------
     BARRES DE COMPÉTENCES
     -------------------------------------------------------- */
  var skillsSection = document.getElementById('skills');
  if (skillsSection) {
    var skillsObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) return;
          document.querySelectorAll('.skill-fill').forEach(function (bar) {
            bar.style.width = bar.getAttribute('data-width') + '%';
          });
          skillsObserver.disconnect();
        });
      },
      { threshold: 0.2 }
    );
    skillsObserver.observe(skillsSection);
  }

  /* --------------------------------------------------------
     LIEN DE NAVIGATION ACTIF
     -------------------------------------------------------- */
  var sections = document.querySelectorAll('section[id]');
  var anchorLinks = document.querySelectorAll('.nav-links a[href^="#"]');

  if (sections.length && anchorLinks.length) {
    var navObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) return;
          var id = entry.target.getAttribute('id');
          anchorLinks.forEach(function (link) {
            link.classList.toggle('active', link.getAttribute('href') === '#' + id);
          });
        });
      },
      { threshold: 0.4 }
    );
    sections.forEach(function (s) {
      navObserver.observe(s);
    });
  }

  /* --------------------------------------------------------
     BARRE DE PROGRESSION
     -------------------------------------------------------- */
  var progressBar = document.querySelector('.scroll-progress');
  if (progressBar) {
    window.addEventListener(
      'scroll',
      function () {
        var max = document.body.scrollHeight - window.innerHeight;
        var scrolled = max > 0 ? (window.scrollY / max) * 100 : 0;
        progressBar.style.width = scrolled + '%';
      },
      { passive: true }
    );
  }

  /* --------------------------------------------------------
     INITIALISATION
     -------------------------------------------------------- */
  applyTheme(readStore(STORAGE_THEME) || 'light');
  applyLang(detectLang());
})();
