USE [master]
GO
/****** Object:  Database [RTCollection]    Script Date: 10/08/2020 13:08:18 ******/
CREATE DATABASE [RTCollection]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RTCollection', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\RTCollection.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RTCollection_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\RTCollection_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [RTCollection] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RTCollection].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RTCollection] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RTCollection] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RTCollection] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RTCollection] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RTCollection] SET ARITHABORT OFF 
GO
ALTER DATABASE [RTCollection] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RTCollection] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RTCollection] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RTCollection] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RTCollection] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RTCollection] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RTCollection] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RTCollection] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RTCollection] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RTCollection] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RTCollection] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RTCollection] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RTCollection] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RTCollection] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RTCollection] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RTCollection] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RTCollection] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RTCollection] SET RECOVERY FULL 
GO
ALTER DATABASE [RTCollection] SET  MULTI_USER 
GO
ALTER DATABASE [RTCollection] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RTCollection] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RTCollection] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RTCollection] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RTCollection] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RTCollection] SET QUERY_STORE = OFF
GO
USE [RTCollection]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [RTCollection]
GO
/****** Object:  Table [dbo].[Karyawan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Karyawan](
	[kry_id] [varchar](12) NOT NULL,
	[kry_nama] [varchar](25) NULL,
	[kry_no_hp] [varchar](13) NULL,
	[kry_email] [varchar](30) NULL,
	[kry_tgl_lahir] [date] NULL,
	[alamat] [varchar](100) NULL,
	[kry_total_transaksi] [int] NULL,
	[kry_username] [varchar](25) NULL,
	[kry_password] [varchar](25) NULL,
	[kry_jabatan] [varchar](10) NULL,
 CONSTRAINT [PK__Karyawan__CD55C2457D72FF50] PRIMARY KEY CLUSTERED 
(
	[kry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pelanggan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pelanggan](
	[pgn_id] [int] NOT NULL,
	[pgn_nama] [varchar](25) NULL,
	[pgn_nama_toko] [varchar](25) NULL,
	[pgn_no_hp] [varchar](13) NULL,
	[pgn_email] [varchar](30) NULL,
	[pgn_alamat] [varchar](100) NULL,
	[pgn_nama_pasar] [varchar](25) NULL,
	[pgn_jumlah_transaksi] [int] NULL,
	[pgn_uang_transaksi] [money] NULL,
	[pgn_total_hutang] [money] NULL,
 CONSTRAINT [PK__Pelangga__A08A15952A61D5BD] PRIMARY KEY CLUSTERED 
(
	[pgn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pembayaran]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pembayaran](
	[pmby_id] [varchar](13) NOT NULL,
	[pgn_id] [int] NULL,
	[kry_id] [varchar](12) NULL,
	[pmby_tgl_transaksi] [date] NULL,
	[pmby_uang_masuk] [money] NULL,
 CONSTRAINT [PK_Pembayaran] PRIMARY KEY CLUSTERED 
(
	[pmby_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[laporanPembayaranPelanggan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[laporanPembayaranPelanggan] as
select pmby_id kode, py.pmby_tgl_transaksi tanggal, p.pgn_nama nama, p.pgn_nama_toko toko, p.pgn_nama_pasar pasar, py.pmby_uang_masuk pembayaran, k.kry_nama pelayan from Pembayaran py
inner join Pelanggan p on p.pgn_id = py.pgn_id
inner join Karyawan k on k.kry_id = py.kry_id
GO
/****** Object:  Table [dbo].[BayarPemasok]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BayarPemasok](
	[Bpmks_id] [varchar](13) NOT NULL,
	[pms_id] [int] NULL,
	[bpmks_tgl_transaksi] [date] NULL,
	[bpmks_uang_dibayar] [money] NULL,
	[kry_id] [varchar](12) NULL,
 CONSTRAINT [PK_BayarPemasok] PRIMARY KEY CLUSTERED 
(
	[Bpmks_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pemasok]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pemasok](
	[pms_id] [int] NOT NULL,
	[pms_nama] [varchar](25) NULL,
	[pms_alamat] [varchar](100) NULL,
	[pms_no_hp] [varchar](13) NULL,
	[pms_jumlah_transaksi] [int] NULL,
	[pms_uang_transaksi] [money] NULL,
	[pms_total_hutang] [money] NULL,
 CONSTRAINT [PK_Pemasok] PRIMARY KEY CLUSTERED 
(
	[pms_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[laporanPembayaranPemasok]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[laporanPembayaranPemasok] as
select bp.Bpmks_id kode, bp.bpmks_tgl_transaksi tanggal, p.pms_nama nama, p.pms_alamat alamat, bp.bpmks_uang_dibayar pembayaran, k.kry_nama pelayan from BayarPemasok bp
inner join Pemasok p on p.pms_id = bp.pms_id
inner join Karyawan k on k.kry_id = bp.kry_id
GO
/****** Object:  Table [dbo].[Barang]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Barang](
	[b_id] [int] NOT NULL,
	[jb_id] [int] NULL,
	[b_nama] [varchar](25) NULL,
	[b_bahan] [varchar](25) NULL,
	[b_ukuran] [varchar](5) NULL,
	[b_stok] [int] NULL,
	[b_harga_satuan] [money] NULL,
	[b_harga_kodian] [money] NULL,
	[b_harga_jual_satuan] [money] NULL,
	[b_harga_jual_kodian] [money] NULL,
	[pms_id] [int] NULL,
 CONSTRAINT [PK_Barang] PRIMARY KEY CLUSTERED 
(
	[b_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetailPemasokkan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailPemasokkan](
	[pmsk_id] [varchar](13) NOT NULL,
	[b_id] [int] NOT NULL,
	[detail_jumlah_barang] [int] NULL,
	[detail_jumlah_kodi] [int] NULL,
	[detail_harga] [money] NULL,
 CONSTRAINT [PK_DetailPemasokkan] PRIMARY KEY CLUSTERED 
(
	[pmsk_id] ASC,
	[b_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pemasokkan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pemasokkan](
	[pmsk_id] [varchar](13) NOT NULL,
	[pms_id] [int] NULL,
	[pmsk_tgl_transaksi] [date] NULL,
	[pmsk_jumlah_barang] [int] NULL,
	[pmsk_jumlah_kodi] [int] NULL,
	[pmsk_total_uang] [money] NULL,
	[pmsk_uang_dibayar] [money] NULL,
	[kry_id] [varchar](12) NULL,
	[status] [varchar](25) NULL,
 CONSTRAINT [PK_Pemasokkan] PRIMARY KEY CLUSTERED 
(
	[pmsk_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BarangMasuk]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[BarangMasuk] as
select distinct pmsk.pmsk_id,pms.pms_nama, pmsk.pmsk_tgl_transaksi, pmsk.pmsk_jumlah_kodi, pmsk.pmsk_total_uang, pmsk.status from Pemasokkan pmsk
inner join DetailPemasokkan dpmsk on pmsk.pmsk_id = dpmsk.pmsk_id
inner join Pemasok pms on pms.pms_id = pmsk.pms_id
inner join Barang b on b.b_id = dpmsk.b_id
inner join Karyawan k on k.kry_id = pmsk.kry_id
GO
/****** Object:  View [dbo].[DetailBarangMasuk]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[DetailBarangMasuk] as
select pmsk.pmsk_id, b.b_nama, b.b_ukuran, dpmsk.detail_jumlah_kodi, dpmsk.detail_harga from Pemasokkan pmsk
inner join DetailPemasokkan dpmsk on pmsk.pmsk_id = dpmsk.pmsk_id
inner join Pemasok pms on pms.pms_id = pmsk.pms_id
inner join Barang b on b.b_id = dpmsk.b_id
inner join Karyawan k on k.kry_id = pmsk.kry_id
GO
/****** Object:  Table [dbo].[Pemesanan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pemesanan](
	[pmsn_id] [varchar](13) NOT NULL,
	[pmsn_tgl_transaksi] [date] NULL,
	[pgn_id] [int] NULL,
	[pmsn_jumlah_barang] [int] NULL,
	[pmsn_jumlah_kodi] [int] NULL,
	[pmsn_total_uang] [money] NULL,
	[pmsn_status] [varchar](20) NULL,
	[kry_id] [varchar](12) NULL,
 CONSTRAINT [PK_Pemesanan] PRIMARY KEY CLUSTERED 
(
	[pmsn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BarangKeluar]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[BarangKeluar] as
select pmsn.pmsn_id, pgn.pgn_nama, pgn.pgn_nama_toko,pgn.pgn_nama_pasar, pmsn.pmsn_tgl_transaksi, pmsn.pmsn_jumlah_kodi, pmsn.pmsn_total_uang, pmsn.pmsn_status from Pemesanan pmsn
inner join Pelanggan pgn on pgn.pgn_id = pmsn.pgn_id
GO
/****** Object:  Table [dbo].[DetailPemesanan]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailPemesanan](
	[pmsn_id] [varchar](13) NOT NULL,
	[b_id] [int] NOT NULL,
	[detail_jumlah_barang] [int] NULL,
	[detail_jumlah_kodi] [int] NULL,
	[detail_total_uang] [money] NULL,
 CONSTRAINT [PK_DetailPemesanan] PRIMARY KEY CLUSTERED 
(
	[pmsn_id] ASC,
	[b_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DetailBarangKeluar]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[DetailBarangKeluar] as
select dpms.pmsn_id, b.b_nama, b.b_ukuran, dpms.detail_jumlah_kodi, dpms.detail_total_uang from DetailPemesanan dpms
inner join Barang b on b.b_id = dpms.b_id
GO
/****** Object:  Table [dbo].[Karung]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Karung](
	[krg_id] [varchar](15) NOT NULL,
	[pgrm_id] [varchar](13) NULL,
	[krg_jumlah_kodi] [int] NULL,
	[krg_jumlah_jenis_barang] [int] NULL,
	[keterangan] [varchar](50) NULL,
 CONSTRAINT [PK_Karung] PRIMARY KEY CLUSTERED 
(
	[krg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[KarungPengiriman]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[KarungPengiriman] as
select kr.krg_id, kr.keterangan, kr.krg_jumlah_kodi, kr.krg_jumlah_jenis_barang from Karung kr
GO
/****** Object:  Table [dbo].[DetailKarung]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailKarung](
	[krg_id] [varchar](15) NOT NULL,
	[b_id] [int] NOT NULL,
	[detail_jumlah_barang] [int] NULL,
	[detail_jumlah_kodi] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DetailKarungPengiriman]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[DetailKarungPengiriman] as
select b.b_nama, b.b_ukuran, dkr.detail_jumlah_kodi from Karung kr
inner join DetailKarung dkr on dkr.krg_id = kr.krg_id
inner join Barang b on b.b_id = dkr.b_id
GO
/****** Object:  Table [dbo].[Pengiriman]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pengiriman](
	[pgrm_id] [varchar](13) NOT NULL,
	[pgrm_tgl_transaksi] [date] NULL,
	[pgrm_jumlah_barang] [int] NULL,
	[pgrm_jumlah_kodi] [int] NULL,
	[pgrm_jumlah_karung] [int] NULL,
	[kry_id] [varchar](12) NULL,
	[status] [varchar](50) NULL,
	[pgn_id] [int] NULL,
 CONSTRAINT [PK_Pengiriman] PRIMARY KEY CLUSTERED 
(
	[pgrm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[KarungKonfirmasiKeluar]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[KarungKonfirmasiKeluar]
AS
SELECT        p.pgrm_id, k.krg_id, b.b_nama, b.b_ukuran, dk.detail_jumlah_barang, dk.detail_jumlah_kodi, k.keterangan
FROM            dbo.DetailKarung AS dk INNER JOIN
                         dbo.Karung AS k ON k.krg_id = dk.krg_id INNER JOIN
                         dbo.Pengiriman AS p ON p.pgrm_id = k.pgrm_id INNER JOIN
                         dbo.Barang AS b ON b.b_id = dk.b_id
GO
/****** Object:  View [dbo].[konfirmasiBarangKeluar]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[konfirmasiBarangKeluar]
AS
SELECT        p.pgrm_id, pgn.pgn_nama, p.pgrm_jumlah_barang, p.pgrm_jumlah_kodi, p.pgrm_jumlah_karung, p.pgrm_tgl_transaksi, k.kry_nama, p.status
FROM            dbo.Pengiriman AS p INNER JOIN
                         dbo.Pelanggan AS pgn ON pgn.pgn_id = p.pgn_id INNER JOIN
                         dbo.Karyawan AS k ON k.kry_id = p.kry_id
GO
/****** Object:  View [dbo].[laporanBarangMasuk]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[laporanBarangMasuk] as
SELECT pmsk.pmsk_id kode,b.b_nama,b.b_ukuran, pmsk.pmsk_tgl_transaksi tanggal,pms.pms_nama pemasok, dpmsk.detail_jumlah_kodi [jumlah kodi], dpmsk.detail_harga harga, pmsk.pmsk_jumlah_kodi [total kodi], pmsk.pmsk_total_uang [total uang], pmsk.status, k.kry_nama [pelayan]
FROM            dbo.Pemasokkan AS pmsk INNER JOIN
                         dbo.DetailPemasokkan AS dpmsk ON pmsk.pmsk_id = dpmsk.pmsk_id INNER JOIN
                         dbo.Pemasok AS pms ON pms.pms_id = pmsk.pms_id INNER JOIN
                         dbo.Barang AS b ON b.b_id = dpmsk.b_id INNER JOIN
                         dbo.Karyawan AS k ON k.kry_id = pmsk.kry_id
						 where status = 'Sukses'
GO
/****** Object:  View [dbo].[laporanBarangKeluar]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[laporanBarangKeluar] as
select bk.pmsn_id kode, pmsn_tgl_transaksi tanggal, pgn_nama_toko toko, pgn_nama nama, b_nama barang, b_ukuran ukuran, dbk.detail_jumlah_kodi [jumlah kodi], dbk.detail_total_uang harga, bk.pmsn_jumlah_kodi [total kodi], bk.pmsn_total_uang [total uang], bk.pmsn_status status from BarangKeluar bk
inner join DetailBarangKeluar dbk on bk.pmsn_id = dbk.pmsn_id where pmsn_status = 'Diterima'
GO
/****** Object:  Table [dbo].[DetailPengiriman]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailPengiriman](
	[pmsn_id] [varchar](13) NOT NULL,
	[pgrm_id] [varchar](13) NOT NULL,
 CONSTRAINT [PK_DetailPengiriman] PRIMARY KEY CLUSTERED 
(
	[pmsn_id] ASC,
	[pgrm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JenisBarang]    Script Date: 10/08/2020 13:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JenisBarang](
	[jb_id] [int] NOT NULL,
	[jb_nama] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[jb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (1, 1, N'Kiky Jenas', N'Katun', N'30', 8, 250000.0000, 5000000.0000, 270000.0000, 5200000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (2, 1, N'Kiky Jenas', N'Katun', N'31', 16, 250000.0000, 5000000.0000, 270000.0000, 5200000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (3, 1, N'Kiky Jenas', N'Katun', N'32', 3, 30000.0000, 5000000.0000, 270000.0000, 5200000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (4, 1, N'Kiky Jenas', N'Katun', N'29', 10, 250000.0000, 5000000.0000, 270000.0000, 5200000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (5, 1, N'Kiky Jenas', N'Katun', N'28', 14, 250000.0000, 5000000.0000, 270000.0000, 5200000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (6, 1, N'Testing', N'Katoen', N'28', 10, 100000.0000, 2000000.0000, 120000.0000, 2500000.0000, 1)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (7, 3, N'Levis Anak', N'Levis', N'28', 10, 30000.0000, 6000000.0000, 37000.0000, 7400000.0000, 2)
INSERT [dbo].[Barang] ([b_id], [jb_id], [b_nama], [b_bahan], [b_ukuran], [b_stok], [b_harga_satuan], [b_harga_kodian], [b_harga_jual_satuan], [b_harga_jual_kodian], [pms_id]) VALUES (8, 4, N'Tuwil Doreng', N'Tuwil', N'30', 20, 30000.0000, 600000.0000, 37000.0000, 740000.0000, 3)
INSERT [dbo].[BayarPemasok] ([Bpmks_id], [pms_id], [bpmks_tgl_transaksi], [bpmks_uang_dibayar], [kry_id]) VALUES (N'0001', 1, CAST(N'2020-07-29' AS Date), 5000000.0000, N'202006290001')
INSERT [dbo].[BayarPemasok] ([Bpmks_id], [pms_id], [bpmks_tgl_transaksi], [bpmks_uang_dibayar], [kry_id]) VALUES (N'03082020-0002', 1, CAST(N'2020-08-03' AS Date), 5000000.0000, N'202007010002')
INSERT [dbo].[BayarPemasok] ([Bpmks_id], [pms_id], [bpmks_tgl_transaksi], [bpmks_uang_dibayar], [kry_id]) VALUES (N'04082020-0003', 1, CAST(N'2020-08-04' AS Date), 10000000.0000, N'202007010002')
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200725-0001A', 1, 320, 16)
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200725-0001A', 3, 140, 7)
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200725-0002B', 1, 180, 9)
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200803-0003A', 1, 60, 3)
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200804-0004A', 1, 60, 3)
INSERT [dbo].[DetailKarung] ([krg_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi]) VALUES (N'20200725-0002A', 1, 800, 40)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0001', 1, 100, 5, 25000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0001', 2, 60, 3, 5000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0001', 5, 80, 4, 20000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0002', 2, 80, 4, 20000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0002', 3, 20, 1, 5000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0003', 1, 60, 3, 15000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'0003', 2, 60, 3, 15000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'03082020-0006', 1, 60, 3, 15000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'04082020-0007', 1, 60, 3, 15000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'13072020-0004', 1, 40, 2, 10000000.0000)
INSERT [dbo].[DetailPemasokkan] ([pmsk_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_harga]) VALUES (N'13072020-0005', 1, 80, 4, 20000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200711-0001', 3, 100, 5, 25000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200713-0002', 1, 100, 5, 25000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200713-0003', 1, 60, 3, 5000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200713-0003', 2, 60, 3, 5000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200714-0004', 1, 980, 49, 245000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200725-0005', 1, 320, 16, 80000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200725-0005', 3, 140, 7, 35000000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200803-0006', 1, 60, 3, 15600000.0000)
INSERT [dbo].[DetailPemesanan] ([pmsn_id], [b_id], [detail_jumlah_barang], [detail_jumlah_kodi], [detail_total_uang]) VALUES (N'20200804-0007', 1, 60, 3, 15600000.0000)
INSERT [dbo].[DetailPengiriman] ([pmsn_id], [pgrm_id]) VALUES (N'20200714-0004', N'20200725-0002')
INSERT [dbo].[DetailPengiriman] ([pmsn_id], [pgrm_id]) VALUES (N'20200725-0005', N'20200725-0001')
INSERT [dbo].[DetailPengiriman] ([pmsn_id], [pgrm_id]) VALUES (N'20200803-0006', N'20200803-0003')
INSERT [dbo].[DetailPengiriman] ([pmsn_id], [pgrm_id]) VALUES (N'20200804-0007', N'20200804-0004')
INSERT [dbo].[JenisBarang] ([jb_id], [jb_nama]) VALUES (1, N'Celana Jeans')
INSERT [dbo].[JenisBarang] ([jb_id], [jb_nama]) VALUES (2, N'Boxer')
INSERT [dbo].[JenisBarang] ([jb_id], [jb_nama]) VALUES (3, N'Levis-X')
INSERT [dbo].[JenisBarang] ([jb_id], [jb_nama]) VALUES (4, N'TuwilS')
INSERT [dbo].[Karung] ([krg_id], [pgrm_id], [krg_jumlah_kodi], [krg_jumlah_jenis_barang], [keterangan]) VALUES (N'20200725-0001A', N'20200725-0001', 23, 2, N'PERCOBAAN')
INSERT [dbo].[Karung] ([krg_id], [pgrm_id], [krg_jumlah_kodi], [krg_jumlah_jenis_barang], [keterangan]) VALUES (N'20200725-0002A', N'20200725-0002', 40, 1, N'ISI DI SAMPING')
INSERT [dbo].[Karung] ([krg_id], [pgrm_id], [krg_jumlah_kodi], [krg_jumlah_jenis_barang], [keterangan]) VALUES (N'20200725-0002B', N'20200725-0002', 9, 1, N'ISI DI SAMPING')
INSERT [dbo].[Karung] ([krg_id], [pgrm_id], [krg_jumlah_kodi], [krg_jumlah_jenis_barang], [keterangan]) VALUES (N'20200803-0003A', N'20200803-0003', 3, 1, N'Kiky Jenas 30/3')
INSERT [dbo].[Karung] ([krg_id], [pgrm_id], [krg_jumlah_kodi], [krg_jumlah_jenis_barang], [keterangan]) VALUES (N'20200804-0004A', N'20200804-0004', 3, 1, N'Tanah Abang Mank Ujang')
INSERT [dbo].[Karyawan] ([kry_id], [kry_nama], [kry_no_hp], [kry_email], [kry_tgl_lahir], [alamat], [kry_total_transaksi], [kry_username], [kry_password], [kry_jabatan]) VALUES (N'202006290001', N'Aqilah Rahma Tsabitah', N'0877661155323', N'aqilah.rtsabitah@gmail.com', CAST(N'2005-09-26' AS Date), N'Kauman Comal', 1, N'-', N'-', N'Pengemudi')
INSERT [dbo].[Karyawan] ([kry_id], [kry_nama], [kry_no_hp], [kry_email], [kry_tgl_lahir], [alamat], [kry_total_transaksi], [kry_username], [kry_password], [kry_jabatan]) VALUES (N'202007010000', N'Teddyanto IJ', N'0895606425999', N'Tedd@gmail.com', CAST(N'2000-05-17' AS Date), N'Kauman Comal', 0, N'Tedd', N'Tedd123', N'Manager')
INSERT [dbo].[Karyawan] ([kry_id], [kry_nama], [kry_no_hp], [kry_email], [kry_tgl_lahir], [alamat], [kry_total_transaksi], [kry_username], [kry_password], [kry_jabatan]) VALUES (N'202007010002', N'Kiky Rahmawati Sitombingg', N'0817273771773', N'KikyCants@gmail.com', CAST(N'2000-05-17' AS Date), N'Papanggo hehehe', 5, N'Kikis', N'Kiky123', N'Kasir')
INSERT [dbo].[Karyawan] ([kry_id], [kry_nama], [kry_no_hp], [kry_email], [kry_tgl_lahir], [alamat], [kry_total_transaksi], [kry_username], [kry_password], [kry_jabatan]) VALUES (N'202008030004', N'Wanda', N'0892764152412', N'Wanda@gmail.com', CAST(N'2000-02-11' AS Date), N'Tambun Selatan', 0, N'-', N'-', N'Pengemudi')
INSERT [dbo].[Karyawan] ([kry_id], [kry_nama], [kry_no_hp], [kry_email], [kry_tgl_lahir], [alamat], [kry_total_transaksi], [kry_username], [kry_password], [kry_jabatan]) VALUES (N'202008040005', N'Tubagus', N'0821764128471', N'Tubagus@gmai.com', CAST(N'2000-02-04' AS Date), N'Jalan pemalang timur', 0, N'-', N'-', N'Pengemudi')
INSERT [dbo].[Pelanggan] ([pgn_id], [pgn_nama], [pgn_nama_toko], [pgn_no_hp], [pgn_email], [pgn_alamat], [pgn_nama_pasar], [pgn_jumlah_transaksi], [pgn_uang_transaksi], [pgn_total_hutang]) VALUES (1, N'Mank Ujang', N'Ujang Sport', N'087832724931', N'ujang@gmail.com', N'Jakarta Utara  Japat', N'Tanah Abang', 4, 260000000.0000, 131200000.0000)
INSERT [dbo].[Pelanggan] ([pgn_id], [pgn_nama], [pgn_nama_toko], [pgn_no_hp], [pgn_email], [pgn_alamat], [pgn_nama_pasar], [pgn_jumlah_transaksi], [pgn_uang_transaksi], [pgn_total_hutang]) VALUES (2, N'Anggian Nur C', N'Anggi Shop', N'0000000004124', N'Amngg@gmail.com', N'Jl Merak Jakarta', N'Tanah Abang', 0, 0.0000, 0.0000)
INSERT [dbo].[Pelanggan] ([pgn_id], [pgn_nama], [pgn_nama_toko], [pgn_no_hp], [pgn_email], [pgn_alamat], [pgn_nama_pasar], [pgn_jumlah_transaksi], [pgn_uang_transaksi], [pgn_total_hutang]) VALUES (3, N'Aditya Prasetyo', N'Adit Shop', N'08888888888', N'Adit@gmail.com', N'Sungai Bambu 1', N'Sungai Bambu', 0, 0.0000, 0.0000)
INSERT [dbo].[Pemasok] ([pms_id], [pms_nama], [pms_alamat], [pms_no_hp], [pms_jumlah_transaksi], [pms_uang_transaksi], [pms_total_hutang]) VALUES (1, N'Teddyanto IJ', N'MUARA INTA', N'0888888888888', 4, 50000000.0000, 10000000.0000)
INSERT [dbo].[Pemasok] ([pms_id], [pms_nama], [pms_alamat], [pms_no_hp], [pms_jumlah_transaksi], [pms_uang_transaksi], [pms_total_hutang]) VALUES (2, N'Hj Mahmudia', N'Desa Konoha', N'0892764236472', 0, 0.0000, 0.0000)
INSERT [dbo].[Pemasok] ([pms_id], [pms_nama], [pms_alamat], [pms_no_hp], [pms_jumlah_transaksi], [pms_uang_transaksi], [pms_total_hutang]) VALUES (3, N'Tuwil Shop', N'Sunter Agung Raya', N'0892645126412', 0, 0.0000, 0.0000)
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'0001', 1, CAST(N'2020-07-06' AS Date), 240, 12, 5000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'0002', 1, CAST(N'2020-07-06' AS Date), 100, 5, 25000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'0003', 1, CAST(N'2020-07-12' AS Date), 120, 6, 30000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'03082020-0006', 1, CAST(N'2020-08-03' AS Date), 60, 3, 15000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'04082020-0007', 1, CAST(N'2020-08-04' AS Date), 60, 3, 15000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'13072020-0004', 1, CAST(N'2020-07-13' AS Date), 40, 2, 10000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pemasokkan] ([pmsk_id], [pms_id], [pmsk_tgl_transaksi], [pmsk_jumlah_barang], [pmsk_jumlah_kodi], [pmsk_total_uang], [pmsk_uang_dibayar], [kry_id], [status]) VALUES (N'13072020-0005', 1, CAST(N'2020-07-13' AS Date), 80, 4, 20000000.0000, 0.0000, N'202007010002', N'Sukses')
INSERT [dbo].[Pembayaran] ([pmby_id], [pgn_id], [kry_id], [pmby_tgl_transaksi], [pmby_uang_masuk]) VALUES (N'0001', 1, N'202006290001', CAST(N'2020-07-29' AS Date), 90000000.0000)
INSERT [dbo].[Pembayaran] ([pmby_id], [pgn_id], [kry_id], [pmby_tgl_transaksi], [pmby_uang_masuk]) VALUES (N'03082020-0002', 1, N'202007010002', CAST(N'2020-08-03' AS Date), 50000000.0000)
INSERT [dbo].[Pembayaran] ([pmby_id], [pgn_id], [kry_id], [pmby_tgl_transaksi], [pmby_uang_masuk]) VALUES (N'04082020-0003', 1, N'202007010002', CAST(N'2020-08-04' AS Date), 50000000.0000)
INSERT [dbo].[Pembayaran] ([pmby_id], [pgn_id], [kry_id], [pmby_tgl_transaksi], [pmby_uang_masuk]) VALUES (N'29072020-0001', 1, N'202006290001', CAST(N'2020-07-29' AS Date), 70000000.0000)
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200711-0001', CAST(N'2020-07-11' AS Date), 1, 100, 5, 25000000.0000, N'Disiapkan', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200713-0002', CAST(N'2020-07-13' AS Date), 1, 100, 5, 25000000.0000, N'Disiapkan', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200713-0003', CAST(N'2020-07-13' AS Date), 1, 60, 3, 5000000.0000, N'Disiapkan', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200714-0004', CAST(N'2020-07-14' AS Date), 1, 980, 49, 245000000.0000, N'Diterima', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200725-0005', CAST(N'2020-07-25' AS Date), 1, 460, 23, 115000000.0000, N'Diterima', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200803-0006', CAST(N'2020-08-03' AS Date), 1, 60, 3, 15600000.0000, N'Diterima', N'202007010002')
INSERT [dbo].[Pemesanan] ([pmsn_id], [pmsn_tgl_transaksi], [pgn_id], [pmsn_jumlah_barang], [pmsn_jumlah_kodi], [pmsn_total_uang], [pmsn_status], [kry_id]) VALUES (N'20200804-0007', CAST(N'2020-08-04' AS Date), 1, 60, 3, 15600000.0000, N'Diterima', N'202007010002')
INSERT [dbo].[Pengiriman] ([pgrm_id], [pgrm_tgl_transaksi], [pgrm_jumlah_barang], [pgrm_jumlah_kodi], [pgrm_jumlah_karung], [kry_id], [status], [pgn_id]) VALUES (N'20200725-0001', CAST(N'2020-07-25' AS Date), 460, 23, 1, N'202007010002', N'Diterima', 1)
INSERT [dbo].[Pengiriman] ([pgrm_id], [pgrm_tgl_transaksi], [pgrm_jumlah_barang], [pgrm_jumlah_kodi], [pgrm_jumlah_karung], [kry_id], [status], [pgn_id]) VALUES (N'20200725-0002', CAST(N'2020-07-25' AS Date), 980, 49, 2, N'202007010002', N'Diterima', 1)
INSERT [dbo].[Pengiriman] ([pgrm_id], [pgrm_tgl_transaksi], [pgrm_jumlah_barang], [pgrm_jumlah_kodi], [pgrm_jumlah_karung], [kry_id], [status], [pgn_id]) VALUES (N'20200803-0003', CAST(N'2020-08-03' AS Date), 60, 3, 1, N'202007010002', N'Diterima', 1)
INSERT [dbo].[Pengiriman] ([pgrm_id], [pgrm_tgl_transaksi], [pgrm_jumlah_barang], [pgrm_jumlah_kodi], [pgrm_jumlah_karung], [kry_id], [status], [pgn_id]) VALUES (N'20200804-0004', CAST(N'2020-08-04' AS Date), 60, 3, 1, N'202006290001', N'Diterima', 1)
ALTER TABLE [dbo].[Barang]  WITH CHECK ADD  CONSTRAINT [FK_Barang_JenisBarang] FOREIGN KEY([jb_id])
REFERENCES [dbo].[JenisBarang] ([jb_id])
GO
ALTER TABLE [dbo].[Barang] CHECK CONSTRAINT [FK_Barang_JenisBarang]
GO
ALTER TABLE [dbo].[Barang]  WITH CHECK ADD  CONSTRAINT [FK_Barang_Pemasok] FOREIGN KEY([pms_id])
REFERENCES [dbo].[Pemasok] ([pms_id])
GO
ALTER TABLE [dbo].[Barang] CHECK CONSTRAINT [FK_Barang_Pemasok]
GO
ALTER TABLE [dbo].[BayarPemasok]  WITH CHECK ADD  CONSTRAINT [FK_BayarPemasok_Pemasok] FOREIGN KEY([pms_id])
REFERENCES [dbo].[Pemasok] ([pms_id])
GO
ALTER TABLE [dbo].[BayarPemasok] CHECK CONSTRAINT [FK_BayarPemasok_Pemasok]
GO
ALTER TABLE [dbo].[DetailPemasokkan]  WITH CHECK ADD  CONSTRAINT [FK_DetailPemasokkan_Barang] FOREIGN KEY([b_id])
REFERENCES [dbo].[Barang] ([b_id])
GO
ALTER TABLE [dbo].[DetailPemasokkan] CHECK CONSTRAINT [FK_DetailPemasokkan_Barang]
GO
ALTER TABLE [dbo].[DetailPemasokkan]  WITH CHECK ADD  CONSTRAINT [FK_DetailPemasokkan_Pemasokkan] FOREIGN KEY([pmsk_id])
REFERENCES [dbo].[Pemasokkan] ([pmsk_id])
GO
ALTER TABLE [dbo].[DetailPemasokkan] CHECK CONSTRAINT [FK_DetailPemasokkan_Pemasokkan]
GO
ALTER TABLE [dbo].[DetailPemesanan]  WITH CHECK ADD  CONSTRAINT [FK_DetailPemesanan_Barang] FOREIGN KEY([b_id])
REFERENCES [dbo].[Barang] ([b_id])
GO
ALTER TABLE [dbo].[DetailPemesanan] CHECK CONSTRAINT [FK_DetailPemesanan_Barang]
GO
ALTER TABLE [dbo].[DetailPemesanan]  WITH CHECK ADD  CONSTRAINT [FK_DetailPemesanan_DetailPemesanan] FOREIGN KEY([pmsn_id])
REFERENCES [dbo].[Pemesanan] ([pmsn_id])
GO
ALTER TABLE [dbo].[DetailPemesanan] CHECK CONSTRAINT [FK_DetailPemesanan_DetailPemesanan]
GO
ALTER TABLE [dbo].[DetailPengiriman]  WITH CHECK ADD  CONSTRAINT [FK_DetailPengiriman_Pemesanan] FOREIGN KEY([pmsn_id])
REFERENCES [dbo].[Pemesanan] ([pmsn_id])
GO
ALTER TABLE [dbo].[DetailPengiriman] CHECK CONSTRAINT [FK_DetailPengiriman_Pemesanan]
GO
ALTER TABLE [dbo].[DetailPengiriman]  WITH CHECK ADD  CONSTRAINT [FK_DetailPengiriman_Pengiriman] FOREIGN KEY([pgrm_id])
REFERENCES [dbo].[Pengiriman] ([pgrm_id])
GO
ALTER TABLE [dbo].[DetailPengiriman] CHECK CONSTRAINT [FK_DetailPengiriman_Pengiriman]
GO
ALTER TABLE [dbo].[Karung]  WITH CHECK ADD  CONSTRAINT [FK_Karung_Pengiriman] FOREIGN KEY([pgrm_id])
REFERENCES [dbo].[Pengiriman] ([pgrm_id])
GO
ALTER TABLE [dbo].[Karung] CHECK CONSTRAINT [FK_Karung_Pengiriman]
GO
ALTER TABLE [dbo].[Pemasokkan]  WITH CHECK ADD FOREIGN KEY([kry_id])
REFERENCES [dbo].[Karyawan] ([kry_id])
GO
ALTER TABLE [dbo].[Pemasokkan]  WITH CHECK ADD  CONSTRAINT [FK_Pemasokkan_Pemasok] FOREIGN KEY([pms_id])
REFERENCES [dbo].[Pemasok] ([pms_id])
GO
ALTER TABLE [dbo].[Pemasokkan] CHECK CONSTRAINT [FK_Pemasokkan_Pemasok]
GO
ALTER TABLE [dbo].[Pembayaran]  WITH CHECK ADD  CONSTRAINT [FK_Pembayaran_Karyawan] FOREIGN KEY([kry_id])
REFERENCES [dbo].[Karyawan] ([kry_id])
GO
ALTER TABLE [dbo].[Pembayaran] CHECK CONSTRAINT [FK_Pembayaran_Karyawan]
GO
ALTER TABLE [dbo].[Pembayaran]  WITH CHECK ADD  CONSTRAINT [FK_Pembayaran_Pelanggan] FOREIGN KEY([pgn_id])
REFERENCES [dbo].[Pelanggan] ([pgn_id])
GO
ALTER TABLE [dbo].[Pembayaran] CHECK CONSTRAINT [FK_Pembayaran_Pelanggan]
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD FOREIGN KEY([kry_id])
REFERENCES [dbo].[Karyawan] ([kry_id])
GO
ALTER TABLE [dbo].[Pemesanan]  WITH CHECK ADD  CONSTRAINT [FK_Pemesanan_Pelanggan] FOREIGN KEY([pgn_id])
REFERENCES [dbo].[Pelanggan] ([pgn_id])
GO
ALTER TABLE [dbo].[Pemesanan] CHECK CONSTRAINT [FK_Pemesanan_Pelanggan]
GO
ALTER TABLE [dbo].[Pengiriman]  WITH CHECK ADD FOREIGN KEY([pgn_id])
REFERENCES [dbo].[Pelanggan] ([pgn_id])
GO
ALTER TABLE [dbo].[Pengiriman]  WITH CHECK ADD  CONSTRAINT [FK_Pengiriman_Karyawan] FOREIGN KEY([kry_id])
REFERENCES [dbo].[Karyawan] ([kry_id])
GO
ALTER TABLE [dbo].[Pengiriman] CHECK CONSTRAINT [FK_Pengiriman_Karyawan]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "dk"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KarungKonfirmasiKeluar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KarungKonfirmasiKeluar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "pgn"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 136
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'konfirmasiBarangKeluar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'konfirmasiBarangKeluar'
GO
USE [master]
GO
ALTER DATABASE [RTCollection] SET  READ_WRITE 
GO
