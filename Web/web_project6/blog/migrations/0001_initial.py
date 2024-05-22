# Generated by Django 5.0.1 on 2024-02-07 05:21

from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Post",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("title", models.CharField(max_length=30, verbose_name="TITLE")),
                ("content", models.TextField(verbose_name="CONTENT")),
                (
                    "created_at",
                    models.DateTimeField(auto_now_add=True, verbose_name="CREATE DT"),
                ),
            ],
        ),
    ]