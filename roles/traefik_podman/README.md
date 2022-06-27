traefik_podman
=========

Deployment von Traefik als Podman-Container. Traefik ist in diesem Szenario als reiner HTTP-Reverse-Proxy mit File-Config-Provider vorgesehen

Requirements
------------

* Podman
* Container läuft als root

Role Variables
--------------

Verfügbare Variablen mit Default-Werten (siehe auch `defaults/main.yml`) werden hier aufgelistet

    traefik_instance_name: internal

Bezeichnung der Traefik-Instanz. Wird u.a. im Container-Namen & Systemd-Unit verwendet

    traefik_dir: "/etc/traefik"

Basis-Host-Verzeichnis mit Traefik-Konfiguration. Unterhalb dieses Verzeichnisses     

    _file_provider_dir: "{{ traefik_dir }}/file-provider-config"
    _acme_dir: "{{ traefik_dir }}/acme"

Verzeichnisse für File-Provider-Config & Zertifikatsdaten. Müssen unterhalb von `traefik_dir` liegen

    traefik_env: {}

Dictionary für Umgebungsvariablen, z.B: für Let's-Encrypt Zertifikats-Resolver    

     traefik_certificatesResolvers: {}

Dictionary mit Traefik-Zertifikatsresolvern. Konfiguration entspricht 1:1 der Konfiguration der certificateResolvers-Konfiguration von Traefik (https://doc.traefik.io/traefik/https/acme/#certificate-resolvers)

    traefik_image: "docker.io/library/traefik:v2.7"

Zu verwendendendes Container-Image     

    traefik_log_level: ERROR

Traefik Standard Log-Level 

    traefik_network: traefik

Container-Netzwerk für Traefik. Wird angelegt wenn es nicht existiert    

Dependencies
------------

* containers.podman

Example Playbook
----------------

Variablen-Definition

```

traefik_log_level: DEBUG

traefik_env:
  PDNS_API_KEY: "topsecret"
  PDNS_API_URL: "http://public-dns-api"
  PDNS_PROPAGATION_TIMEOUT: "120"
  PDNS_POLLING_INTERVAL: "2"

traefik_certificatesResolvers:
  pdns-staging-resolver:
    acme:
      email: systeme@org.tld
      dnsChallenge:
        provider: pdns
        resolvers:
          - "8.8.8.8"
      caServer: https://acme-staging-v02.api.letsencrypt.org/directory
      storage: /etc/traefik/acme/acme.json
  pdns-prod-resolver:
    acme:
      email: systeme@org.tld
      dnsChallenge:
        provider: pdns
        resolvers:
          - "8.8.8.8"
      storage: /etc/traefik/acme/acme.json
```


```
---
- hosts: all
  remote_user: "conductor"
  become: yes
  become_method: sudo
  collections:
    - witcom.traefik

- name: Deploy Traefik
  remote_user: "conductor"
  hosts: mrtg_hosts
  become: yes
  become_method: sudo
  roles:
    - name: witcom.traefik.traefik_podman
```

License
-------

BSD

Author Information
------------------

