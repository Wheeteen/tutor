# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Config',
            fields=[
                ('id', models.IntegerField(serialize=False, primary_key=True)),
                ('key', models.CharField(max_length=45, null=True, blank=True)),
                ('value', models.TextField(null=True, blank=True)),
            ],
            options={
                'db_table': 'config',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='CorsheadersCorsmodel',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('cors', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'corsheaders_corsmodel',
                'managed': False,
            },
        ),
    ]
