# Generated by Django 2.1.7 on 2019-03-03 07:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adpricing', '0003_auto_20190302_0252'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='addata',
            name='marks',
        ),
        migrations.RemoveField(
            model_name='addata',
            name='regularity_status',
        ),
        migrations.AddField(
            model_name='addata',
            name='readers',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='addata',
            name='size',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='addata',
            name='state',
            field=models.CharField(max_length=100, null=True),
        ),
    ]
