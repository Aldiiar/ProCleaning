# Generated by Django 4.2.7 on 2023-12-04 06:18

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0005_machines_info_machines_info_2_machines_name_2_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='machines',
            name='category',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='products.category_of_machine'),
        ),
    ]
