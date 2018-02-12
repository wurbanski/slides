---
title: Czy Windows w systemie Continuous Integration może być obywatelem pierwszej kategorii?
theme: white
presented:
  - date: 15.02.2018
    where: SysOps/DevOps Meetup Gdańsk #2
revealOptions:
  transition: none
  slideNumber: true
  overview: true
  width: 100%
  height: 100%

---

### Czy Windows w systemie Continuous Integration może być obywatelem pierwszej kategorii?

Wojciech Urbański


Note: Hi.

----

## Tl;dr

Prezentacja **będzie**:

- bazowała na prawdziwej historii
- o Windowsie w systemie CI
- ale nie tylko!

Prezentacja **nie będzie**:

- przepisem
- *obiektywnie idealnym* rozwiązaniem.

----

## Spis treści

TODO

---

## O mnie

TODO

[github](https://github.com/wurbanski/) - [twitter](https://twitter.com/wurbansk) - [blog](https://blog.wurbanski.me)

---

## Zadanie

Zajmij się systemem CI 

dla projektu Windowsowego... <!-- .element class="fragment" -->

związanego z SDN... <!-- .element class="fragment" -->

będącego portem z Linuksa. <!-- .element class="fragment" -->

----

## Wymagania

1. Ścisła definicja konfiguracji potrzebnych maszyn
2. Odporność na złośliwe akcje z zewnątrz
3. Określone wymagania sieciowe (o tym później)
4. Jak największa bezobsługowość

---

<!-- .slide data-background='./images/bg1.png' -->
# Zróbmy tak, żeby było dobrze :-)

----

## No Ops, please

System ma być dostępny dla programistów bez konieczności ciągłej kontroli i interwencji zespołu CI.


<div class="fragment">
<blockquote>
<p>Dawno temu ja też zaufałem pewnemu developerowi, wtedy dałbym sobie za niego rękę uciąć.</p>
<p>I wiesz, co... I bym teraz, windows, nie miał ręki.</p>
</blockquote>

<em>~Paulo DevOpselho</em>
</div>

----

## Projektowanie defensywne

>**Programowanie defensywne** - tworzenie oprogramowania z myślą o jego poprawnym działaniu nawet przy nieprzewidywalnych sposobach jego użycia.
>
>Techniki programowania defensywnego:
>- **Upraszczanie kodu źródłowego**
>- **Zewnętrzne audyty kodu źródłowego**
>- Wyjątki i asercje
>- **Testowanie oprogramowania**
>- Bezpieczna obsługa wejścia i wyjścia
>- Zapis danych w postaci kanonicznej
>- **Zasada najmniejszego uprzywilejowania**

*Źródło: [wiki](https://pl.wikipedia.org/wiki/Programowanie_defensywne)*

----

## Czego nam potrzeba?

1. Skutecznego i prostego zarządzania konfiguracją systemów
2. Niezmienności infrastruktury
3. Automatyzacji wprowadzania zmian (CI/CD dla infrastruktury)

---

## Zarządzanie konfiguracją na Windowsie

1. [Powershell Desired State Configuration](https://docs.microsoft.com/en-us/powershell/dsc/overview)
2. Polityki Active Directory
3. Chef, Puppet, Saltstack
4. Ansible

----

## Powershell DSC

TODO: FIX WRAPPING
```powershell
Configuration WebsiteTest {
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    Node 'localhost' {
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }
        File WebsiteContent {
            Ensure = 'Present'
            SourcePath = 'c:\test\index.htm'
            DestinationPath = 'c:\inetpub\wwwroot'
        }
    }
}
```
<!-- .element class="stretch" -->

----

## Polityki Active Directory

Plusy:

+ wszystko dzieje się w tle
+ natywny dla Windowsa sposób zarządzania
+ DHCP, DNS, LDAP
+ "wystrzel i zapomnij"

Minusy:

- względnie skomplikowana infrastruktura do utrzymywania
- dodatkowa warstwa abstrakcji
- wprowadzanie zmian na *żywym organizmie*
- trudna analiza i wersjonowanie kodu

----

## Chef, Puppet, Saltstack

**Chef, Puppet**: Ruby na windowsie = :(

**Saltstack**: zbyt skomplikowany jak na cel, który chcemy osiągnąć

----

## Ansible

- łatwy do nauki
- łączy się wykorzystując natywny mechanizm: *Windows Remote Management*
- wykorzystuje *Powershell* do wykonywania operacji
- można go wykorzystać jako wrapper na DSC
- zdecentralizowany

---

## Ansible + Windows = ❤️

Używa natywnego powershellowego połączenia przez bibliotekę `pywinrm`.

Wspiera wiele opcji uwierzytelnienia: `basic auth`, `certificate`, `kerberos`, `NTLM`, `CredSSP`.

`Kerberos` - do łączenia się do systemów podpiętych do AD.

`CredSSP` - do łaczenia się do maszyn bez i z AD.

[dokumentacja](http://docs.ansible.com/ansible/latest/intro_windows.html#windows-how-does-it-work)

----

## Konfiguracja Windowsa do pracy z Ansiblem

1. Automatyczna konfiguracja skryptem [ConfigureRemotingForAnsible.ps1](https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1)
```powershell
powershell.exe -File ConfigureRemotingForAnsible.ps1 -EnableCredSSP -ForceNewSSLCert
```
Uwaga: Wymaga Powershella **3.0 lub nowszego**
1. Odpowiednie zmienne w `inventory` dla ansible'a:
```yaml
ansible_user: Administrator
ansible_password: SecretPasswordGoesHere
ansible_port: 5986
ansible_connection: winrm
# The following is necessary for Python 2.7.9+ when using default WinRM self-signed certificates:
ansible_winrm_server_cert_validation: ignore
```

----

## Przykładowa rola

Zainstalujmy `Docker-EE` z natywnymi kontenerami na Windows Server 2016:
```yaml
- name: Instalacja Windows-Containers
  win_feature:
    name: 'Containers'
    state: present

- name: Instalacja Hyper-V
  win_feature:
    name: 'Hyper-V'
    include_management_tools: True
    state: present

- name: Instalacja DockerProvider
  win_psmodule:
    name: DockerProvider

- name: Restart (nadal jest to windows...)
  win_reboot:

- name: Instalacja Docker-EE
  win_shell: "Install-Package Docker -ProviderName DockerProvider -Force"
```
<!-- .element class="stretch" -->

----

## Zarządzanie zainstalowanymi aplikacjami

```yaml
# Korzystając z chocolatey!
- name: Install python 2.7.13
  win_chocolatey:
    name: python2
    version: 2.7.13
    state: present

# Korzystając z pakietów MSI!
- name: Install VisualCPP Build Tools
  win_package:
    path: '\\remote_location\\visualcppbuildtools_full.exe'
    state: present
    product_id: '{79750C81-714E-45F2-B5DE-42DEF00687B8}'
    arguments: /Quiet /NoWeb /InstallSelectableItems
```

---

## Niezmienność infrastruktury

TODO: Obrazek
```
Bazowy obraz systemu -> Obraz roli w systemie -> Deployment i finalizacja maszyny
```

----

## Coś więcej o tworzeniu obrazów

----

## Wprowadzanie zmian do obrazów

1. Zmiana w kodzie ansiblowym odpowiedniej roli
2. Jenkins uruchamia build nowego obrazu i zapisuje go jako template
3. 
4. 

---

## Janie, przetestuj proszę

Jenkins

pipeline plugin

----

## Dodatek: dynamiczne rozszerzanie Jenkinsa

Swarm plugin

rola ansiblowa

labelki 

---

## Środowiska testowe

Ansible + VMWare = :|

pyVmomi na ratunek

---

# Co na przyszłość?

Terraform?

Packer?

---

# Dziękuję! :)

[e-mail](mailto:hello@wurbanski.me)
