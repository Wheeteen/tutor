# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
#
# Also note: You'll have to insert the output of 'django-admin sqlcustom [app_label]'
# into your database.
from __future__ import unicode_literals

from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=80)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup)
    permission = models.ForeignKey('AuthPermission')

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group_id', 'permission_id'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType')
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type_id', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=30)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser)
    group = models.ForeignKey(AuthGroup)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user_id', 'group_id'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser)
    permission = models.ForeignKey(AuthPermission)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user_id', 'permission_id'),)


class Banner(models.Model):
    url = models.TextField()
    image_path = models.TextField()

    class Meta:
        managed = False
        db_table = 'banner'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', blank=True, null=True)
    user = models.ForeignKey(AuthUser)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class OrderApply(models.Model):
    oa_id = models.IntegerField(primary_key=True)
    apply_type = models.IntegerField()
    pd = models.ForeignKey('ParentOrder')
    tea = models.ForeignKey('Teacher')
    teacher_willing = models.IntegerField()
    parent_willing = models.IntegerField()
    update_time = models.DateTimeField()
    screenshot_path = models.TextField(blank=True, null=True)
    pass_not = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'order_apply'


class ParentOrder(models.Model):
    pd_id = models.AutoField(primary_key=True)
    wechat_id = models.TextField()
    subject = models.TextField()
    aim = models.TextField()
    mon_begin = models.IntegerField(blank=True, null=True)
    mon_end = models.IntegerField(blank=True, null=True)
    tues_begin = models.IntegerField(blank=True, null=True)
    tues_end = models.IntegerField(blank=True, null=True)
    wed_begin = models.IntegerField(blank=True, null=True)
    wed_end = models.IntegerField(blank=True, null=True)
    thur_begin = models.IntegerField(blank=True, null=True)
    thur_end = models.IntegerField(blank=True, null=True)
    fri_begin = models.IntegerField(blank=True, null=True)
    fri_end = models.IntegerField(blank=True, null=True)
    sat_morning = models.IntegerField()
    sat_afternoon = models.IntegerField()
    sat_evening = models.IntegerField()
    sun_morning = models.IntegerField()
    sun_afternoon = models.IntegerField()
    sun_evening = models.IntegerField()
    weekend_tutor_length = models.IntegerField(unique=True)
    teacher_sex = models.IntegerField()
    teacher_method = models.TextField()
    learning_phase = models.IntegerField()
    class_field = models.IntegerField(db_column='class')  # Field renamed because it was a Python reserved word.
    grade = models.IntegerField()
    require = models.TextField(blank=True, null=True)
    salary = models.DecimalField(max_digits=20, decimal_places=2)
    allowance_not = models.IntegerField()
    deadline = models.DateTimeField()
    name = models.TextField()
    tel = models.TextField()
    address = models.TextField()
    pass_not = models.IntegerField()
    create_time = models.DateTimeField()
    update_time = models.DateTimeField()
    status = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'parent_order'


class SysText(models.Model):
    salary_standard = models.TextField()
    require_explain = models.TextField()

    class Meta:
        managed = False
        db_table = 'sys_text'


class Teacher(models.Model):
    tea = models.ForeignKey(AuthUser, primary_key=True)
    wechat_id = models.TextField()
    name = models.TextField()
    qualification = models.IntegerField()
    sex = models.IntegerField()
    native_place = models.TextField()
    campus_major = models.TextField()
    tel = models.TextField()
    subject = models.TextField()
    place = models.TextField()
    teacher_method = models.TextField()
    score = models.TextField(blank=True, null=True)
    self_comment = models.TextField()
    salary_bottom = models.DecimalField(max_digits=20, decimal_places=2)
    salary_top = models.DecimalField(max_digits=20, decimal_places=2)
    certificate_photo = models.TextField()
    teach_show_photo = models.TextField(blank=True, null=True)
    massage_warn = models.IntegerField()
    create_time = models.DateTimeField()
    pass_not = models.IntegerField()
    mon_begin = models.IntegerField(blank=True, null=True)
    mon_end = models.IntegerField(blank=True, null=True)
    tues_begin = models.IntegerField(blank=True, null=True)
    tues_end = models.IntegerField(blank=True, null=True)
    wed_begin = models.IntegerField(blank=True, null=True)
    wed_end = models.IntegerField(blank=True, null=True)
    thur_begin = models.IntegerField(blank=True, null=True)
    thur_end = models.IntegerField(blank=True, null=True)
    fri_begin = models.IntegerField(blank=True, null=True)
    fri_end = models.IntegerField(blank=True, null=True)
    sat_morning = models.IntegerField()
    sat_afternoon = models.IntegerField()
    sat_evening = models.IntegerField()
    sun_morning = models.IntegerField()
    sun_afternoon = models.IntegerField()
    sun_evening = models.IntegerField()
    hot_not = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'teacher'
