# Generated by Django 2.1.7 on 2019-03-02 02:47

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('adpricing', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='NEWSPAPER_DATA',
            new_name='AdData',
        ),
    ]