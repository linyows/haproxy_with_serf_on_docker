#!/bin/bash

exec serf agent \
    -tag role=lb \
    -event-handler '/bin/bash /handler.sh'
