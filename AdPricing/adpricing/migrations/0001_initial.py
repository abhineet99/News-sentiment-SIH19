# Generated by Django 2.1.7 on 2019-03-02 02:43

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
                ('edition_area', models.CharField(max_length=144)),
                ('newspaper_name', models.CharField(max_length=144)),
                ('periodicity', models.CharField(max_length=144)),
                ('rate', models.FloatField()),
                ('language', models.CharField(choices=[(1, 'English'), (2, 'Hindi'), (3, 'Punjabi'), (4, 'Urdu'), (5, 'Marathi'), (6, 'Others')], default=6, max_length=1)),
                ('phone', models.CharField(max_length=10)),
                ('regularity_status', models.BooleanField(default='True')),
                ('marks', models.BooleanField(default='True')),
                ('circulation_type', models.CharField(choices=[('RNI', 'RNI'), ('ABC', 'ABC'), ('CA', 'CA'), ('NA', 'Not Available')], default='NA', max_length=3)),
                ('circulation_score', models.IntegerField(blank=True, null=True)),
            ],
        ),
    ]