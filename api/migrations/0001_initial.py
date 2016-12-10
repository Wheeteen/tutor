# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='AuthGroup',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=80)),
            ],
            options={
                'db_table': 'auth_group',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthGroupPermissions',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
            ],
            options={
                'db_table': 'auth_group_permissions',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthPermission',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=255)),
                ('codename', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'auth_permission',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUser',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('password', models.CharField(max_length=128)),
                ('last_login', models.DateTimeField(null=True, blank=True)),
                ('is_superuser', models.IntegerField()),
                ('username', models.CharField(unique=True, max_length=30)),
                ('first_name', models.CharField(max_length=30)),
                ('last_name', models.CharField(max_length=30)),
                ('email', models.CharField(max_length=254)),
                ('is_staff', models.IntegerField()),
                ('is_active', models.IntegerField()),
                ('date_joined', models.DateTimeField()),
            ],
            options={
                'db_table': 'auth_user',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUserGroups',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
            ],
            options={
                'db_table': 'auth_user_groups',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='AuthUserUserPermissions',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
            ],
            options={
                'db_table': 'auth_user_user_permissions',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Banner',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('url', models.TextField()),
                ('image_path', models.TextField()),
            ],
            options={
                'db_table': 'banner',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoAdminLog',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('action_time', models.DateTimeField()),
                ('object_id', models.TextField(null=True, blank=True)),
                ('object_repr', models.CharField(max_length=200)),
                ('action_flag', models.SmallIntegerField()),
                ('change_message', models.TextField()),
            ],
            options={
                'db_table': 'django_admin_log',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoContentType',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('app_label', models.CharField(max_length=100)),
                ('model', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'django_content_type',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoMigrations',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('app', models.CharField(max_length=255)),
                ('name', models.CharField(max_length=255)),
                ('applied', models.DateTimeField()),
            ],
            options={
                'db_table': 'django_migrations',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DjangoSession',
            fields=[
                ('session_key', models.CharField(max_length=40, serialize=False, primary_key=True)),
                ('session_data', models.TextField()),
                ('expire_date', models.DateTimeField()),
            ],
            options={
                'db_table': 'django_session',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='OrderApply',
            fields=[
                ('oa_id', models.IntegerField(serialize=False, primary_key=True)),
                ('apply_type', models.IntegerField()),
                ('teacher_willing', models.IntegerField()),
                ('parent_willing', models.IntegerField()),
                ('update_time', models.DateTimeField()),
                ('screenshot_path', models.TextField(null=True, blank=True)),
                ('pass_not', models.IntegerField()),
            ],
            options={
                'db_table': 'order_apply',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ParentOrder',
            fields=[
                ('pd_id', models.AutoField(serialize=False, primary_key=True)),
                ('wechat_id', models.TextField()),
                ('subject', models.TextField()),
                ('aim', models.TextField()),
                ('mon_begin', models.IntegerField(null=True, blank=True)),
                ('mon_end', models.IntegerField(null=True, blank=True)),
                ('tues_begin', models.IntegerField(null=True, blank=True)),
                ('tues_end', models.IntegerField(null=True, blank=True)),
                ('wed_begin', models.IntegerField(null=True, blank=True)),
                ('wed_end', models.IntegerField(null=True, blank=True)),
                ('thur_begin', models.IntegerField(null=True, blank=True)),
                ('thur_end', models.IntegerField(null=True, blank=True)),
                ('fri_begin', models.IntegerField(null=True, blank=True)),
                ('fri_end', models.IntegerField(null=True, blank=True)),
                ('sat_morning', models.IntegerField()),
                ('sat_afternoon', models.IntegerField()),
                ('sat_evening', models.IntegerField()),
                ('sun_morning', models.IntegerField()),
                ('sun_afternoon', models.IntegerField()),
                ('sun_evening', models.IntegerField()),
                ('weekend_tutor_length', models.IntegerField(unique=True)),
                ('teacher_sex', models.IntegerField()),
                ('teacher_method', models.TextField()),
                ('learning_phase', models.IntegerField()),
                ('class_field', models.IntegerField(db_column='class')),
                ('grade', models.IntegerField()),
                ('require', models.TextField(null=True, blank=True)),
                ('salary', models.DecimalField(max_digits=20, decimal_places=2)),
                ('allowance_not', models.IntegerField()),
                ('deadline', models.DateTimeField()),
                ('name', models.TextField()),
                ('tel', models.TextField()),
                ('address', models.TextField()),
                ('pass_not', models.IntegerField()),
                ('create_time', models.DateTimeField()),
                ('update_time', models.DateTimeField()),
                ('status', models.IntegerField()),
            ],
            options={
                'db_table': 'parent_order',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='SysText',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('salary_standard', models.TextField()),
                ('require_explain', models.TextField()),
            ],
            options={
                'db_table': 'sys_text',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Teacher',
            fields=[
                ('tea_id', models.AutoField(serialize=False, primary_key=True)),
                ('name', models.TextField(null=True, blank=True)),
                ('qualification', models.IntegerField(null=True, blank=True)),
                ('sex', models.IntegerField(null=True, blank=True)),
                ('native_place', models.TextField(null=True, blank=True)),
                ('campus_major', models.TextField(null=True, blank=True)),
                ('tel', models.TextField(null=True, blank=True)),
                ('subject', models.TextField(null=True, blank=True)),
                ('place', models.TextField(null=True, blank=True)),
                ('teacher_method', models.TextField(null=True, blank=True)),
                ('score', models.TextField(null=True, blank=True)),
                ('self_comment', models.TextField(null=True, blank=True)),
                ('salary_bottom', models.DecimalField(null=True, max_digits=20, decimal_places=2, blank=True)),
                ('salary_top', models.DecimalField(null=True, max_digits=20, decimal_places=2, blank=True)),
                ('certificate_photo', models.TextField(null=True, blank=True)),
                ('teach_show_photo', models.TextField(null=True, blank=True)),
                ('massage_warn', models.IntegerField(null=True, blank=True)),
                ('create_time', models.DateTimeField(null=True, blank=True)),
                ('pass_not', models.IntegerField(null=True, blank=True)),
                ('mon_begin', models.IntegerField(null=True, blank=True)),
                ('mon_end', models.IntegerField(null=True, blank=True)),
                ('tues_begin', models.IntegerField(null=True, blank=True)),
                ('tues_end', models.IntegerField(null=True, blank=True)),
                ('wed_begin', models.IntegerField(null=True, blank=True)),
                ('wed_end', models.IntegerField(null=True, blank=True)),
                ('thur_begin', models.IntegerField(null=True, blank=True)),
                ('thur_end', models.IntegerField(null=True, blank=True)),
                ('fri_begin', models.IntegerField(null=True, blank=True)),
                ('fri_end', models.IntegerField(null=True, blank=True)),
                ('sat_morning', models.IntegerField(null=True, blank=True)),
                ('sat_afternoon', models.IntegerField(null=True, blank=True)),
                ('sat_evening', models.IntegerField(null=True, blank=True)),
                ('sun_morning', models.IntegerField(null=True, blank=True)),
                ('sun_afternoon', models.IntegerField(null=True, blank=True)),
                ('sun_evening', models.IntegerField(null=True, blank=True)),
                ('hot_not', models.IntegerField(null=True, blank=True)),
            ],
            options={
                'db_table': 'teacher',
                'managed': False,
            },
        ),
    ]
