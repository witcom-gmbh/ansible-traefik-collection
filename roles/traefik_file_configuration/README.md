traefik_file_configuration
==========================

Deployment von Traefik-Konfigurationen für den File-Configuration-Provider

Requirements
------------

* Eine existierende Traefik-Installation

Role Variables
--------------

Verfügbare Variablen mit Default-Werten (siehe auch `defaults/main.yml`) werden hier aufgelistet

    traefik_dir: "/etc/traefik"

Basis-Host-Verzeichnis mit Traefik-Konfiguration. Unterhalb dieses Verzeichnisses     

    _file_provider_dir: "{{ traefik_dir }}/file-provider-config"

Verzeichnis für File-Provider-Config. Muss unterhalb von `traefik_dir` liegen

    traefik_configs: {}

Dictionary für Traefik-Konfigurationen. Details siehe `defaults/main.yml` 

Example Playbook
----------------

```
---
- hosts: all
  remote_user: "conductor"
  become: yes
  become_method: sudo
  collections:
    - witcom.traefik

- name: Configure traefik
  remote_user: "conductor"
  hosts: mrtg_hosts
  become: yes
  become_method: sudo
  vars:
    traefik_configs:
    - name: a-random-name
      state: present
      type: http
      definition:
      # siehe offizielle Traefik-Dokumentation
        routers:
          router0:
            entryPoints:
            - web
            middlewares:
            - my-basic-auth
            service: service-foo
            rule: Path(`/foo`)
            # ... usw
  roles:
    - name: witcom.traefik.traefik_file_configuration
```

License
-------

BSD

Author Information
------------------


