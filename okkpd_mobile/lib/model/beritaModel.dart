class BeritaModel{
  String idBerita;
  String slug;
  String judulBerita;
  String previewBerita;
  String isiBerita;
  String gambar;
  String tanggalBuat;

  BeritaModel(this.idBerita,this.slug,this.judulBerita,this.previewBerita,this.isiBerita,this.gambar,this.tanggalBuat);

  BeritaModel.fromJson(Map<String, dynamic> json)
      : idBerita = json['id_berita'],
        slug= json['slug'],
        judulBerita= json['judul_berita'],
        previewBerita = json['preview_berita'],
        isiBerita = json['isi_berita'],
        gambar = json['gambar'],
        tanggalBuat = json['tanggal_buat'];

  Map<String, dynamic> toJson() =>
      {
        'id_berita': idBerita,
        'slug': slug,
        'judul_berita': judulBerita,
        'preview_berita': previewBerita,
        'isi_berita': isiBerita,
        'gambar': gambar,
        'tanggal_buat': tanggalBuat,
      };
}
