from django.contrib import admin
from django.urls import path
from products.views import main_page_view, machine_page_view
from django.conf.urls.static import static
from .settings import MEDIA_URL, MEDIA_ROOT

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', main_page_view),
    path('machines/<int:category_id>/', machine_page_view, name='category_page'),
]

urlpatterns += static(MEDIA_URL, document_root=MEDIA_ROOT)
