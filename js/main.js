(() => {
  const header = document.querySelector(".site-header");
  const toggle = document.querySelector(".nav-toggle");
  const nav = document.querySelector(".nav");
  const year = document.querySelector("#year");
  const reveals = document.querySelectorAll(".reveal");
  const sections = document.querySelectorAll("main section[id]");
  const navLinks = document.querySelectorAll("[data-nav]");
  const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  if (year) {
    year.textContent = String(new Date().getFullYear());
  }

  const onScroll = () => {
    if (!header) return;
    header.classList.toggle("is-scrolled", window.scrollY > 8);
  };

  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();

  if (toggle && nav) {
    const closeNav = () => {
      nav.classList.remove("is-open");
      toggle.setAttribute("aria-expanded", "false");
      toggle.setAttribute("aria-label", "Ouvrir le menu");
    };

    toggle.addEventListener("click", () => {
      const open = !nav.classList.contains("is-open");
      nav.classList.toggle("is-open", open);
      toggle.setAttribute("aria-expanded", String(open));
      toggle.setAttribute("aria-label", open ? "Fermer le menu" : "Ouvrir le menu");
    });

    nav.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", closeNav);
    });
  }

  const skipWrap = (el) =>
    Boolean(
      el.closest(
        "svg, script, style, button, .platform, .skill__logo, .tag-logos, .logo-rail, .cert-strip, .edu__logos, .edu__accreds, .role__company-logo"
      )
    );

  const wrapWords = (root) => {
    const walk = (node) => {
      if (node.nodeType === Node.TEXT_NODE) {
        const raw = node.textContent;
        if (!raw || !raw.trim()) return;
        const frag = document.createDocumentFragment();
        raw.split(/(\s+)/).forEach((part) => {
          if (!part) return;
          if (/^\s+$/.test(part)) {
            frag.appendChild(document.createTextNode(part));
            return;
          }
          const span = document.createElement("span");
          span.className = "word";
          span.textContent = part;
          frag.appendChild(span);
        });
        node.parentNode.replaceChild(frag, node);
        return;
      }
      if (node.nodeType !== Node.ELEMENT_NODE) return;
      if (node.classList.contains("word") || skipWrap(node)) return;
      [...node.childNodes].forEach(walk);
    };
    walk(root);
  };

  document
    .querySelectorAll(
      [
        ".hero__name-line",
        ".hero__title",
        ".hero__lead",
        ".profile-text",
        ".section__head h2",
        ".section__label",
        ".role__date",
        ".role__place",
        ".role__body h3",
        ".role__org",
        ".role__body > ul:not(.tag-logos) > li",
        ".edu h3",
        ".edu__school",
        ".edu__date",
        ".edu__place",
        ".skill h3",
        ".project h3",
        ".project p",
        ".contact-lead",
        ".contact-panel h2",
      ].join(",")
    )
    .forEach(wrapWords);

  document
    .querySelectorAll(".platform, .logo-rail li, .role__company-logo")
    .forEach((el) => el.classList.add("rise", "rise--logo"));

  document
    .querySelectorAll(".skill__logo, .tag-logos li")
    .forEach((el) => el.classList.add("rise", "rise--badge"));

  document
    .querySelectorAll(
      ".cert-strip span, .edu__logo, .edu__acred-logo, .project__index, .contact-actions .btn"
    )
    .forEach((el) => el.classList.add("rise", "rise--chip"));

  const show = (el, delay) => {
    el.style.transitionDelay = reduced ? "0ms" : `${Math.max(0, delay)}ms`;
    el.classList.add("is-visible");
  };

  const revealContent = (root) => {
    root.classList.add("is-visible");
    if (reduced) {
      root.querySelectorAll(".word, .rise").forEach((el) => el.classList.add("is-visible"));
      return;
    }

    const sequence = root.querySelectorAll(
      [
        ".section__label",
        ".section__head h2",
        ".hero__name-line",
        ".hero__title",
        ".hero__lead",
        ".profile-text",
        ".role__date",
        ".role__place",
        ".role__company-logo",
        ".role__body h3",
        ".role__org",
        ".platform",
        ".role__body > ul:not(.tag-logos) > li",
        ".tag-logos li",
        ".edu h3",
        ".edu__school",
        ".edu__date",
        ".edu__place",
        ".edu__logo",
        ".edu__acred-logo",
        ".skill h3",
        ".skill__logo",
        ".project__index",
        ".project h3",
        ".project p",
        ".logo-rail li",
        ".cert-strip span",
        ".contact-lead",
        ".contact-panel h2",
        ".contact-actions .btn",
      ].join(",")
    );

    let time = 80;
    sequence.forEach((el) => {
      if (el.classList.contains("rise")) {
        const step = el.classList.contains("rise--badge")
          ? 90
          : el.classList.contains("rise--chip")
            ? 70
            : 110;
        show(el, time);
        time += step;
        return;
      }

      const words = el.querySelectorAll(".word");
      if (!words.length) {
        time += 40;
        return;
      }
      words.forEach((word, i) => show(word, time + i * 28));
      time += words.length * 28 + 70;
    });
  };

  document.querySelectorAll(".role.reveal").forEach((el, i) => {
    el.classList.add(i % 2 === 0 ? "reveal--left" : "reveal--right");
  });

  const hero = document.querySelector(".hero");
  if (hero) {
    hero.querySelectorAll(".reveal").forEach((el) => el.classList.add("is-visible"));
    revealContent(hero);
  }

  if ("IntersectionObserver" in window) {
    const revealObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;
          revealContent(entry.target);
          revealObserver.unobserve(entry.target);
        });
      },
      { threshold: 0.12, rootMargin: "0px 0px -8% 0px" }
    );

    reveals.forEach((el) => {
      if (el.closest(".hero")) return;
      revealObserver.observe(el);
    });

    const navObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;
          const id = entry.target.getAttribute("id");
          navLinks.forEach((link) => {
            const active = link.getAttribute("href") === `#${id}`;
            link.classList.toggle("is-active", active);
          });
        });
      },
      { rootMargin: "-35% 0px -55% 0px", threshold: 0 }
    );

    sections.forEach((section) => navObserver.observe(section));
  } else {
    reveals.forEach(revealContent);
  }
})();
