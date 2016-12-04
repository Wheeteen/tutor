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


class Banner(models.Model):
    url = models.TextField()
    image_path = models.TextField()

    class Meta:
        managed = False
        db_table = 'banner'


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
    tea_id = models.AutoField(primary_key=True)
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
