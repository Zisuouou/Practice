# Generated by Django 5.0.1 on 2024-02-07 05:39

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("blog", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="post",
            name="created_at",
            field=models.DateTimeField(auto_now_add=True, verbose_name="CREATE AT"),
        ),
    ]
