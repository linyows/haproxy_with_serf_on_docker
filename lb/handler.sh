#!/bin/bash

case "$SERF_EVENT" in
    'member-join')
        if [ "x${SERF_TAG_ROLE}" != "xlb" ]; then
            echo "Not an lb. Ignoring member join."
            exit 0
        fi

        while read line; do
            ROLE=`echo $line | awk '{print \$3 }'`
            #if [ "x${ROLE}" != "xweb" ]; then
            #    continue
            #fi
            #
            #echo $line | awk \
            #    '{ printf "    server %s %s check\n", $1, $2 }' >>/etc/haproxy/haproxy.cfg

            if [ "x${ROLE}" == "xweb" ]; then
                echo $line | awk \
                    '{ printf "    server %s %s weight 99 check\n", $1, $2 }' >>/etc/haproxy/haproxy.cfg
            elif [ "x${ROLE}" == "xweb-release" ]; then
                echo $line | awk \
                    '{ printf "    server %s %s weight 1 check\n", $1, $2 }' >>/etc/haproxy/haproxy.cfg
            fi
        done
        ;;
    'member-leave' | 'member-failed')
        if [ "x${SERF_TAG_ROLE}" != "xlb" ]; then
            echo "Not an lb. Ignoring member leave"
            exit 0
        fi

        while read line; do
            NAME=`echo $line | awk '{print \$1 }'`
            sed -i "/${NAME} /d" /etc/haproxy/haproxy.cfg
        done
        ;;
esac

/etc/init.d/haproxy reload
