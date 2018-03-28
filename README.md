## In English:
# Dehydrated NGINX automation
Script for restart NGINX only once when many ssl certificates are updated by dehydrated.

Suppose you have NGINX, which serves several sites with HTTPS, and you have used Dehydrated to obtain theese certificates. On CentOS 6 and Ubuntu 16.04 you _have to restart NGINX_ (I don't know why, but you have to) to get renewed certificates to work. 

Dehydrated provides a hook for working with certificates, but the hook works for each certificate separately. If you have more than one site, then restarting NGINX for each certificate is really pain in the ass.

To get rid of that pain I decided to work around this problem.

This works pretty simple:
1. Dehydrated's hook throws a flag, indicates than one or more certificates have been updated (or produced);
2. Worker catches that flag and restarts NGINX once a day.

This script saved my time. 

## Installation
1. Copy worker.sh to your system (to /opt/dna for example);
2. Update paths to logs and flag in worker.sh;
3. In /etc/dehydrated/hook.sh add `touch /_path_to_flag_/hasnewcerts.flag` to deploy_cert() function;
4. Update your crontabs to launch Dehydrated and worker.sh;
5. Enjoy!

## По-русски:
# Dehydrated NGINX automation
Скрипт единовременного перезапуска NGINX для подтягивания SSL сертификатов, обновлённых через Dehydrated.

Допустим у вас есть NGINX, который обслуживает несколько сайтов с HTTPS и для получения сертификатов вы использовали Dehydrated. На CentOS 6 и Ubuntu 16.04 вы _должны обязательно перезапускать NGINX_ (не знаю почему это так), чтобы обновлённые сертификаты подтянулись.

У Dehydrated есть хук, который позволяет работать с сертификатами, но этот хук срабатывает на каждый сертификат отдельно. Если у вас более одного сайта, то рестарт NGINX для обновления каждого сертификата - реальная головная боль.

Мне эта головная боль не нужна и я решил эту проблему.

Работает очень просто:
1. Dehydrated через хук выбрасывает флаг - признак того, что один или несколько сертификатов были обновлены или выпущены;
2. Скрипт ловит флаг и рестартует NGINX один раз в сутки.

## Установка
1. Положите worker.sh куда-нибудь в свою систему, например в /opt/dna;
2. Отредактируйте в worker.sh пути до логов и файла-флага;
3. Добавьте в /etc/dehydrated/hook.sh в функцию deploy_cert() строчку `touch /_путь_к_файлу-флагу_/hasnewcerts.flag`;
3. Обновите crontab чтобы Dehydrated и worker.sh запускались по расписанию;
4. Забудьте о перевыпуске сертификатов.
