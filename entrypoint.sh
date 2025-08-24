#!/bin/bash
service cron start
exec apache2-foreground

