# Generated by Django 2.1.7 on 2019-03-01 09:59

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('mediamonitor', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='news',
            old_name='Date',
            new_name='date',
        ),
        migrations.RenameField(
            model_name='news',
            old_name='Headline',
            new_name='headline',
        ),
        migrations.RenameField(
            model_name='news',
            old_name='Sentiment',
            new_name='sentiment',
        ),
        migrations.RenameField(
            model_name='news',
            old_name='SentimentScore',
            new_name='sentiment_score',
        ),
        migrations.RenameField(
            model_name='news',
            old_name='Source',
            new_name='source',
        ),
        migrations.RenameField(
            model_name='news',
            old_name='SourceURL',
            new_name='sourceURL',
        ),
    ]
