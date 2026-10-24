# Muck Mod Paketi

## Arkadaşlar için kurulum (internet kafede)

1. Steam'den **Muck**'ı kur (ücretsiz). Kafede zaten kuruluysa bu adımı atla.
2. Bu sayfada yeşil **Code** butonuna bas, sonra **Download ZIP** seç.
3. İnen zip'e sağ tıkla, **Tümünü ayıkla** de. (Zip'in içinden çalıştırırsan olmaz.)
4. Çıkan klasördeki **kur.bat** dosyasına çift tıkla.
   - "Windows bilgisayarınızı korudu" uyarısı çıkarsa **Ek bilgi**, sonra **Yine de çalıştır**.
5. "KURULUM TAMAM" yazınca Muck'ı Steam'den aç.

Kafe bilgisayarı yeniden başlayınca modlar silinebilir. O zaman sadece 4. adımı tekrarla.

**Herkeste aynı paket kurulu olmalı**, yoksa multiplayer'da sorun çıkar.

## Modlar

| Mod | Ne yapar |
|---|---|
| MuckSaveGame 0.9.1 | Oyunu kaydetme. Save'ler oyunu kuranda (host) durur. |
| Muck Gun Plugin 1.0.0 | Silah. Workbench veya Anvil'de **5 Iron Bar** ile yapılır, sol tık ateş. |
| Muck Upgrade Buildings 1.3.1 | Çekiç. Workbench'te **5 Wood** ile yapılır. Sol tık tamir, sağ tık basılı tut: yükseltme menüsü (duvarlar, fırın, kazan). |
| Better Stack Limits 1.0.1 | Bir slota daha çok eşya sığar. |
| Better Item Pickup 1.0.0 | Alınan eşyalar önce hotbar'a gider. |
| Item Stat Display 1.1.0 | Eşya ve powerup'ların üstüne gelince ne yaptığını gösterir. |
| Map Markers 1.0.0 | Haritada sol tık işaret koy, sağ tık sil, E ile renk değiştir. |
| Keep Inventory 1.0.1 | Ölünce eşyalar gitmez. |
| Free Chests 1.0.0 | Powerup sandıkları bedava açılır. |
| Faster Gathering 1.0.0 | Ağaç ve madenler daha hızlı kırılır. |
| Better Running 1.0.0 | Koşarken stamina yarı hızda biter. |
| Instant Eat 1.0.0 | Yemekler anında yenir. Sohbete `/instanteat` yazınca açılır/kapanır. |
| Faster Revive 1.0.0 | Arkadaşını kaldırma süresi 10 saniye. |
| Self Revive Multiplayer 1.0.3 | Multiplayer'da kendi kendini diriltme. |
| Better Multiplayer 1.0.0 | Sandık, fırın ve kazanı herkes aynı anda kullanabilir. Oyun bitince aynı lobiye dönülebilir. |
| Muck Time Modifier 1.3.1 | Gün uzunluğu ayarlanabilir (`BepInEx/config` içindeki ayar dosyasından). |
| Muck++ 1.0.1 | Bir sürü hata düzeltmesi. Better Stack Limits'in tek tutulan eşyaları bozmasını da düzeltir. |
| No Empty Chests 1.0.0 | Boş sandıklar kaybolur. |

## Paketi hazırlayan için

`mod/` klasörüne Muck klasörüne gidecek dosyalar konur:

```
mod/
  BepInEx/
    plugins/      <- mod .dll dosyaları (save modu dahil)
    config/       <- mod ayarları
  winhttp.dll
  doorstop_config.ini
```
