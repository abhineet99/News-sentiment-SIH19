# Generated by Django 2.0.7 on 2019-03-01 10:22

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='NEWSPAPER_DATA',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('SNo', models.IntegerField()),
                ('EditionArea', models.TextField()),
                ('NewspaperName', models.TextField()),
                ('Periodicity', models.TextField()),
                ('Rate', models.FloatField()),
                ('Language', models.TextField()),
                ('Phone', models.TextField()),
                ('CirculationType', models.CharField(choices=[('RNI', 'RNI'), ('ABC', 'ABC'), ('CA', 'CA'), ('NA', 'Not Available')], default='NA', max_length=3)),
                ('CirculationScore', models.IntegerField()),
            ],
        ),
    ]
