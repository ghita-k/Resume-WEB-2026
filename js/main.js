(() => {
  const header = document.querySelector(".site-header");
  const toggle = document.querySelector(".nav-toggle");
  const nav = document.querySelector(".nav");
  const year = document.querySelector("#year");
  const reveals = document.querySelectorAll(".reveal");
  const sections = document.querySelectorAll("main section[id]");
  const navLinks = document.querySelectorAll("[data-nav]");

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

  const markVisible = (el) => {
    el.classList.add("is-visible");
    el.querySelectorAll(":scope .rise").forEach((kid, i) => {
      const step = kid.classList.contains("rise--logo")
        ? 70
        : kid.classList.contains("rise--point")
          ? 85
          : 60;
      kid.style.transitionDelay = `${120 + i * step}ms`;
      kid.classList.add("is-visible");
    });
  };

  const tagRise = (selector, extraClass) => {
    document.querySelectorAll(selector).forEach((el) => {
      el.classList.add("rise");
      if (extraClass) el.classList.add(extraClass);
    });
  };

  tagRise(
    ".platform, .skill__logo, .logo-rail li, .tag-logos li, .role__company-logo",
    "rise--logo"
  );
  tagRise(".role__body > ul:not(.tag-logos) > li, .project p, .contact-lead", "rise--point");
  tagRise(
    ".cert-strip span, .edu__logo, .edu__acred-logo, .project__index, .contact-actions .btn",
    "rise--chip"
  );
  tagRise(".role__body h3, .role__org, .edu h3, .skill h3, .project h3");

  const roleReveals = document.querySelectorAll(".role.reveal");
  roleReveals.forEach((el, i) => {
    el.classList.add(i % 2 === 0 ? "reveal--left" : "reveal--right");
  });

  if ("IntersectionObserver" in window) {
    const revealObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            markVisible(entry.target);
            revealObserver.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.14, rootMargin: "0px 0px -6% 0px" }
    );

    const bySection = new Map();
    reveals.forEach((el) => {
      const section = el.closest("section") || document.body;
      if (!bySection.has(section)) bySection.set(section, []);
      bySection.get(section).push(el);
    });

    bySection.forEach((items) => {
      items.forEach((el, index) => {
        if (el.closest(".hero")) {
          return;
        }
        el.style.transitionDelay = `${index * 95}ms`;
        revealObserver.observe(el);
      });
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
    reveals.forEach(markVisible);
  }
})();
