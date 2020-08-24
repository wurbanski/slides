---
title: Przemiana białka w kod - błyskawiczny wstęp do operatorów w Kubernetesie
theme: white
highlightTheme: ocean
presented:
  - date: 27.08.2020
    where: SysOps/DevOps Online MeetUp – Lightning Talk
    link:
      name: ""
      url: ""
revealOptions:
  transition: fade
  transitionSpeed: normal
  slideNumber: true
  overview: true
  center: false

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-mountainroad.jpg" -->

<style>

.reveal {
  font-size: 36px;
}

.reveal pre {
  font-size: .4em !important;
}

.reveal h1 {
  background: linear-gradient(to right, #4882e1, #285baf) !important;
  color: #fff;
  padding: 2rem;
  margin: 1% -5%;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.reveal h2 {
  background: linear-gradient(to right, #4882e1, #285baf) !important;
  color: #fff;
  padding: 20px;
  margin: .5em -5%;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.reveal blockquote {
  width: 100%;
  font-size: .8em;
}

.reveal .stretch > code {
  /*max-height: none !important;*/
  /*height: auto !important;*/
}

.reveal section img {
  background: none !important;
  border: none !important;
  box-shadow: none !important;
}

.reveal .slides {
  text-align: left !important;
}

.reveal .slides .center {
  text-align: center !important;
  margin: auto !important;
}

.reveal ul > li {
  margin: 0 .5em;
}

.reveal ol > li {
  margin: .5em .5em;
}

.reveal code:not(.hljs) {
  font-size: 0.8em;
}

.pic-bg p {
  background: rgba(255,255,255,0.75);
  border-radius: 10px;
  padding: 10px 40px;
  width: fit-content;
  margin: auto;
  margin-top: 1em;
}
</style>

## Przemiana białka w kod - błyskawiczny wstęp do operatorów w Kubernetesie

**Wojtek Urbański**

Note: Według *prawa nagłówków Betteridge'a* na każdy nagłówek będący pytaniem można odpowiedzieć przecząco. Odpowiedź na dzisiejsze pytanie pozwolę sobie oczywiście zostawić na koniec.

---



---

<!-- .slide: class="center pic-bg" data-background="./images/bg-theend.jpg" -->
# Dziękuję

[wojtek@ninefiveslabs.io](mailto:wojtek@ninefiveslabs.io) - [slides.wurbanski.me](https://slides.wurbanski.me/wstep-do-operatorow)

