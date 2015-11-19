{% from 'settings.sls' import user, home %}

sublime-text-command-line-tool:
  file.symlink:
    - name: /usr/local/bin/subl
    - target: "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"

sublime-text-package-control:
  file.managed:
    - name: "{{ home }}/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"
    - owner: {{ user }}
    - source: https://sublime.wbond.net/Package%20Control.sublime-package
    - source_hash: sha256=2915d1851351e5ee549c20394736b4428bc59f460fa1548d1514676163dafc88

sublime-text-config-symlink:
  file.symlink:
    - name: "{{ home }}/Library/Application Support/Sublime Text 3/Packages/User"
    - target: "{{ home }}/.config/sublime-text-3"
    - owner: {{ user }}
