from django.db import models

class Category_of_Machine(models.Model):
    name = models.CharField(max_length=250, blank=False, null=False)
    photo = models.ImageField(blank=False, null=False)
    created_date = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.name


class Machines(models.Model):
    IN_STOCK_CHOICES = [
        ('В наличии', 'В наличии'),
        ('Под заказ', 'Под заказ'),
    ]

    name = models.CharField(max_length=500, blank=False, null=False)
    name_2 = models.CharField(max_length=500, blank=False, null=False, default='')
    info = models.TextField(blank=False, null=False, default='')
    info_2 = models.TextField(blank=False, null=False, default='')
    photo = models.ImageField(blank=False, null=False)
    in_stock = models.CharField(max_length=20, choices=IN_STOCK_CHOICES)
    video_link = models.TextField(blank=False, null=False, default='')
    created_date = models.DateField(auto_now_add=True)
    category = models.ForeignKey(Category_of_Machine, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name

