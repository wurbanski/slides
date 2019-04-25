---
title: 12 Factor Apps - the steps between using cloud and being cloud ready
theme: white
highlightTheme: ocean
revealOptions:
  transition: fade
  transitionSpeed: normal
  slideNumber: true
  overview: true
  center: false

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-title.jpg" -->

<style>

.reveal {
  font-size: 36px;
}

.reveal .controls, .reveal .progress , .reveal a, .reveal a:hover {
  color: #98cf2b;
}

.reveal pre {
  font-size: .4em !important;
}

.reveal h1 {
  background: linear-gradient(to right, #98cf2b, #a2dd2c) !important;
  color: #fff;
  padding: 2rem;
  margin: 1% -5%;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.reveal h2 {
  background: linear-gradient(to right, #98cf2b, #a2dd2c) !important;
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
  border-radius: 5px;
  padding: 10px 40px;
  min-width: 5%;
  margin: auto;
  margin-top: 1em;
}

.twocolumn {
   display: grid;
   grid-template-columns: 1fr 1fr;
   grid-gap: 10px;
   text-align: left;
}

</style>

## 12 Factor Apps - the steps between using cloud and being cloud ready

**Wojciech Urbański**


---

<!-- .slide: data-background="./images/bg-about.jpg" -->
## Wojciech Urbański

**Początki:** Administrator SKOS PG. Całe *życie zawodowe* w CI.

**Zainteresowania IT:** Automatyzacja, statystyki, monitoring.

Gdy brakuje mi narzędzi, to je sobie piszę. (Głównie w pythonie)

GCP Certified Architect & Trainer

**Czas wolny:** gram, robię zdjęcia telefonem. (:

[github](https://github.com/wurbanski/) - [blog](https://blog.wurbanski.me) - [e-mail](mailto:hello@wurbanski.me)

Note: Aktualnie współpracuję z Codilime
---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## Cloud is (not) just someone else's computer...

----

## Cloud Enabled or Cloud Native?

Cloud Enabled:
* Taking advantage of flexible resources
* Moved existing applications from on-prem to cloud

Cloud Native:
* Designed with cloud in mind
* Using cloud-provided services

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 12 Factor Apps

presented by Adam Wiggins, Heroku, 2011

[https://12factor.net](https://12factor.net)

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 1. Codebase

One codebase tracked in revision control, many deploys

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 2. Dependencies

Explicitly declare and isolate dependencies

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 3. Config

Store config in the environment

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 4. Backing services

Treat backing services as attached resources

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 5. Build, release, run

Strictly separate build and run stages

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 6. Processes

Execute the app as one or more stateless processes

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 7. Port binding

Export services via port binding

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 8. Concurrency

Scale out via the process model

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 9. Disposability

Maximize robustness with fast startup and graceful shutdown

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 10. Dev/prod parity

Keep development, staging, and production as similar as possible

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 11. Logs

Treat logs as event streams

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

## 12. Admin processes

Run admin/management tasks as one-off processes

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-cloud.jpg" -->

# Theory meets practice

----

## Multiprocess containers

problem: **Separate application process from backing services**

(anti-)solution: **supervsisord in a container**

violates: 
* backing services
* processes
* port binding
* disposability
* logs

----

## Serverless vs 12 Factor Apps

<div class="twocolumn">
  <div>
<ol> 
<li><strong>Codebase</strong></li>
<li><strong>Dependencies</strong></li>
<li><strong>Config</strong></li>
<li><strong>Backing services</strong></li>
<li><strong>Build, release, run</strong></li>
<li><strike>Processes</strike></li>
</ol>
  </div>
  <div>
<ol start="7">
<li><strike>Port binding</strike></li>
<li><strike>Concurrency</strike></li>
<li><strong>Disposability</strong></li>
<li><strong>Dev/prod parity</strong></li>
<li><strong>Logs</strong></li>
<li><strike>Admin processes</strike></li>
</ol>
  </div>
</div>

---

<!-- .slide: class="center pic-bg" data-background="./images/bg-theend.jpg" -->
## Don't focus on the factors, focus on your application!

visit [12factor.net](https://12factor.net) for details, though ;-)
    
---
    
<!-- .slide: class="center pic-bg" data-background="./images/bg-theend.jpg" -->
# Thank you!

[hello@wurbanski.me](mailto:hello@wurbanski.me) - [slides.wurbanski.me](https://slides.wurbanski.me/)

[![codilime](images/codilime-bk.png)](mailto:wojciech.urbanski@codilime.com)

