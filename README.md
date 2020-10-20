# Bootstrap4 plugin for Difra Framework

Binds twbs/bootstrap to Difra.

## How to use

1. Add config inclusion to nginx's *server {}* section:
    ```
    include /full-project-path/vendor/difra/bootstrap4/bin/nginx.conf;
    ```
1. Include bootstrap instance in the config.php. For example:
    ```php
    'instances' => [
        'main' => [
             'include' => [
                'bootstrap' => true
             ]
        ]
    ],
    ```
