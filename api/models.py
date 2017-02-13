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
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType')
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


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
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser)
    permission = models.ForeignKey(AuthPermission)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Banner(models.Model):
    url = models.TextField()
    image_path = models.TextField()

    class Meta:
        managed = False
        db_table = 'banner'


class Config(models.Model):
    id = models.IntegerField(primary_key=True)
    key = models.CharField(max_length=45, blank=True, null=True)
    value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'config'


class CorsheadersCorsmodel(models.Model):
    cors = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'corsheaders_corsmodel'


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


class Message(models.Model):
    msg_id = models.AutoField(primary_key=True)
    sender = models.ForeignKey(AuthUser, db_column='sender', blank=True, null=True, related_name="sender")
    message_content = models.TextField(blank=True, null=True)
    message_title = models.TextField(blank=True, null=True)
    status = models.IntegerField(blank=True, null=True)
    receiver = models.ForeignKey(AuthUser, db_column='receiver', blank=True, null=True,related_name="receiver")

    class Meta:
        managed = False
        db_table = 'message'


class OrderApply(models.Model):
    oa_id = models.AutoField(primary_key=True)
    apply_type = models.IntegerField()
    pd = models.ForeignKey('ParentOrder')
    tea = models.ForeignKey('Teacher')
    teacher_willing = models.IntegerField()
    parent_willing = models.IntegerField()
    update_time = models.DateTimeField()
    screenshot_path = models.TextField(blank=True, null=True)
    pass_not = models.IntegerField()
    expectation = models.TextField(blank=True, null=True)
    finished = models.IntegerField(default=0)
    tel =  models.CharField(max_length=45, null=True)

    class Meta:
        managed = False
        db_table = 'order_apply'


class ParentOrder(models.Model):
    pd_id = models.AutoField(primary_key=True)
    wechat = models.ForeignKey(AuthUser, blank=True, null=True)
    subject = models.TextField(blank=True, null=True)
    subject_other = models.TextField(blank=True, null=True)
    aim = models.TextField(blank=True, null=True)
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
    sat_morning = models.IntegerField(blank=True, null=True, default=0)
    sat_afternoon = models.IntegerField(blank=True, null=True, default=0)
    sat_evening = models.IntegerField(blank=True, null=True, default=0)
    sun_morning = models.IntegerField(blank=True, null=True, default=0)
    sun_afternoon = models.IntegerField(blank=True, null=True, default=0)
    sun_evening = models.IntegerField(blank=True, null=True, default=0)
    weekend_tutor_length = models.IntegerField(blank=True, null=True, default=0)
    teacher_sex = models.IntegerField(blank=True, null=True)
    teacher_method = models.TextField(blank=True, null=True)
    teacher_method_other = models.TextField(blank=True, null=True)
    learning_phase = models.IntegerField(blank=True, null=True)
    class_field = models.IntegerField(db_column='class', blank=True, null=True)  # Field renamed because it was a Python reserved word.
    grade = models.TextField(blank=True, null=True)
    require = models.TextField(blank=True, null=True)
    salary = models.DecimalField(max_digits=20, decimal_places=2, blank=True, null=True)
    allowance_not = models.IntegerField(blank=True, null=True, default=0)
    deadline = models.DateTimeField(blank=True, null=True)
    name = models.TextField(blank=True, null=True)
    tel = models.TextField(blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    pass_not = models.IntegerField(blank=True, null=True, default=1)
    create_time = models.DateTimeField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    status = models.IntegerField(blank=True, null=True, default=1)
    bonus = models.TextField(blank=True, null=True)

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
    tea_id = models.AutoField(primary_key=True)
    wechat = models.ForeignKey(AuthUser, blank=True, null=True)
    name = models.TextField(blank=True, null=True)
    qualification = models.IntegerField(blank=True, null=True)
    sex = models.IntegerField(blank=True, null=True)
    native_place = models.TextField(blank=True, null=True)
    campus_major = models.TextField(blank=True, null=True)
    tel = models.TextField(blank=True, null=True)
    subject = models.TextField(blank=True, null=True)
    subject_other = models.TextField(blank=True, null=True)
    place = models.TextField(blank=True, null=True)
    teacher_method = models.TextField(blank=True, null=True)
    teacher_method_other = models.TextField(blank=True, null=True)
    score = models.TextField(blank=True, null=True)
    self_comment = models.TextField(blank=True, null=True)
    salary_bottom = models.DecimalField(max_digits=20, decimal_places=2, blank=True, null=True)
    salary_top = models.DecimalField(max_digits=20, decimal_places=2, blank=True, null=True)
    certificate_photo = models.TextField(blank=True, null=True)
    teach_show_photo = models.TextField(blank=True, null=True)
    massage_warn = models.IntegerField(blank=True, null=True, default=1)
    create_time = models.DateTimeField(blank=True, null=True)
    update_time = models.DateTimeField(blank=True, null=True)
    pass_not = models.IntegerField(blank=True, null=True, default=1)
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
    sat_morning = models.IntegerField(blank=True, null=True, default=0)
    sat_afternoon = models.IntegerField(blank=True, null=True, default=0)
    sat_evening = models.IntegerField(blank=True, null=True, default=0)
    sun_morning = models.IntegerField(blank=True, null=True, default=0)
    sun_afternoon = models.IntegerField(blank=True, null=True, default=0)
    sun_evening = models.IntegerField(blank=True, null=True, default=0)
    hot_not = models.IntegerField(blank=True, null=True, default=0)
    grade = models.TextField(blank=True, null=True)
    number = models.CharField(max_length=45, null=True)

    class Meta:
        managed = False
        db_table = 'teacher'

class Feedback(models.Model):
    wechat = models.ForeignKey(AuthUser, db_column='wechat', blank=True, null=True)
    tutorservice = models.TextField(db_column='tutorService', blank=True, null=True)  # Field name made lowercase.
    appservice = models.TextField(db_column='appService', blank=True, null=True)  # Field name made lowercase.
    rate = models.FloatField(blank=True)
    create_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'feedback'
