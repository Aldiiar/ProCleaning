from django.contrib import admin
from django.urls import path
from products.views import MainPageView, MachinePageView, MachineDetailView
from django.conf.urls.static import static
from .settings import MEDIA_URL, MEDIA_ROOT

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', MainPageView.as_view()),
    path('machines/<int:category_id>/', MachinePageView.as_view(), name='category_page'),
    path('machines/<int:category_id>/<int:id>/', MachineDetailView.as_view()),
]

urlpatterns += static(MEDIA_URL, document_root=MEDIA_ROOT)
