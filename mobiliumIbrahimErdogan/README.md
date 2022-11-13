
merhaba.

bir kaç not bırakmak istedim.

- öncelikle slider (collectionView) içerisine gelen görsellerin çözünürlükleri çok hoş olmadı API helper içerisinde aradım ama farklı çözünürlük göremedim.
- gönderdiğiniz dökümanda safearea için bir şey söylemeişsiniz ama ben ignor ederek yaptım, aslında görsel çözünürlükleri uygun olsa daha güzel durabilirdi.
- tableView refresh kısmını yaptım ama ek olarak da listenin sonuna gittiğimizde yeni bir request ile yeni filmler de eklebiliriz diye bir fonksiyon hazırladım ama yorum satırı olarak bıraktım.
- şu durumda refresh yapıldığında sıraki sayfanın bilgilerini alıp ekrana basıyor.
- api kullanımı için bir Service layer oluşturdum ve tüm servis işlemlerini buradan yapıyorum
    -bu noktada yayında ve gelecek olarak iki adet temel sorgumnuz var aslında model olarak aynı yapıya sahipler ama ikisi için ayrı model oluşturmak istedim. çünkü sonrasında yeni eklemeler için daha rahat olacaktır.
    -movie için ise bir adet basemovidemodel oluşturdum yayında ve gelecek filmlerin result kısımları aynı base modele bağlanıyor ki burada karışıklık çıkmıyor.
    -tüm değişkenleri optional yaptığımı göreceksiniz. çünkü api gerçekten sorun çıkartıyor bir noktadan sonra :) böyle bir önlem aldım
    -service için bir adet ApiError oluşturdum farklı hatalar için hata mesajları yaratıp ekrana basaibliyoruz.
    -gelen tarih bilgileri ve title bilgileri için birer adet helper oluşturdum title+relaaseYear ve relaseDate format için.
   - istenen fontları projeye ekledim.
   -label text colorlar için appearence değişikliklerine uygun color set ekledim 
   


