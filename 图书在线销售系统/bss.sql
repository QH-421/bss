USE [bss]
GO
/****** Object:  Table [dbo].[图书]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[图书](
	[ISBN] [int] NOT NULL,
	[书名] [nvarchar](20) NULL,
	[作者] [nvarchar](10) NULL,
	[出版社] [nvarchar](20) NULL,
	[售价] [int] NULL,
	[进价] [int] NULL,
	[库存] [int] NULL,
	[图片] [nvarchar](20) NULL,
 CONSTRAINT [PK_图书] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[图书进货]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[图书进货](
	[流水号] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [int] NOT NULL,
	[图书数量] [int] NOT NULL,
	[日期] [datetime] NULL,
 CONSTRAINT [PK_图书进货] PRIMARY KEY CLUSTERED 
(
	[流水号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[图书进货单]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[图书进货单]
AS
SELECT   dbo.图书进货.流水号, dbo.图书进货.ISBN, dbo.图书.书名, dbo.图书进货.图书数量, dbo.图书.进价, dbo.图书.售价, 
                dbo.图书进货.日期
FROM      dbo.图书 INNER JOIN
                dbo.图书进货 ON dbo.图书.ISBN = dbo.图书进货.ISBN
GO
/****** Object:  Table [dbo].[销售列表]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[销售列表](
	[流水号] [int] IDENTITY(1,1) NOT NULL,
	[图书] [char](15) NULL,
	[数量] [int] NULL,
	[时间] [datetime] NOT NULL,
	[会员编号] [int] NULL,
	[金额] [int] NULL,
	[积分] [int] NULL,
 CONSTRAINT [PK_销售列表] PRIMARY KEY CLUSTERED 
(
	[流水号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[会员]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[会员](
	[编号] [varchar](50) NOT NULL,
	[密码] [varchar](20) NOT NULL,
	[身份证] [varchar](50) NOT NULL,
	[姓名] [nvarchar](50) NOT NULL,
	[有效期] [date] NULL,
	[会员等级] [int] NULL,
	[积分] [int] NULL,
	[余额] [int] NULL,
	[是否挂失] [varchar](50) NULL,
 CONSTRAINT [PK_会员] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[图书销售单]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[图书销售单]
AS
SELECT   dbo.销售列表.流水号, dbo.销售列表.图书, dbo.图书.书名, dbo.销售列表.会员编号, dbo.会员.姓名, dbo.销售列表.数量, 
                dbo.销售列表.金额, dbo.销售列表.积分, dbo.销售列表.时间, dbo.图书.进价, dbo.图书.售价
FROM      dbo.销售列表 INNER JOIN
                dbo.图书 ON dbo.销售列表.图书 = dbo.图书.ISBN INNER JOIN
                dbo.会员 ON dbo.销售列表.会员编号 = dbo.会员.编号
GO
/****** Object:  Table [dbo].[图书退货]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[图书退货](
	[流水号] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [int] NULL,
	[图书数量] [int] NULL,
	[日期] [datetime] NULL,
	[退货价] [int] NULL,
 CONSTRAINT [PK_图书退货] PRIMARY KEY CLUSTERED 
(
	[流水号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[图书退货单]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[图书退货单]
AS
SELECT   dbo.图书退货.流水号, dbo.图书退货.ISBN, dbo.图书.书名, dbo.图书退货.图书数量, dbo.图书.进价, dbo.图书退货.退货价, 
                dbo.图书退货.日期
FROM      dbo.图书 INNER JOIN
                dbo.图书退货 ON dbo.图书.ISBN = dbo.图书退货.ISBN
GO
/****** Object:  Table [dbo].[出版社]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[出版社](
	[ISBN] [int] NOT NULL,
	[出版社] [nvarchar](20) NOT NULL,
	[资料] [nvarchar](200) NULL,
 CONSTRAINT [PK_出版社] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[出版社] ([ISBN], [出版社], [资料]) VALUES (1, N'南海出版社', N'成立于1988年10月，秉承“出书育人、服务社会”的宗旨')
INSERT [dbo].[出版社] ([ISBN], [出版社], [资料]) VALUES (2, N'南海出版社', N'成立于1988年10月，秉承“出书育人、服务社会”的宗旨')
INSERT [dbo].[出版社] ([ISBN], [出版社], [资料]) VALUES (12, N'长江出版社', N'成立于2004年5月，是一家年轻而又富有朝气的出版社，是一个极具文化气息和学术关怀的文化传播机构。')
INSERT [dbo].[出版社] ([ISBN], [出版社], [资料]) VALUES (14, N'长江出版社', N'成立于2004年5月，是一家年轻而又富有朝气的出版社，是一个极具文化气息和学术关怀的文化传播机构。')
INSERT [dbo].[出版社] ([ISBN], [出版社], [资料]) VALUES (15, N' 长江出版社', NULL)
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'0', N'0', N'0', N'0', NULL, 5, 0, 0, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'1', N'1', N'500100199712020000', N'admin     ', CAST(N'2050-01-01' AS Date), 1, 664, 561, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'2', N'2', N'222', N'test', CAST(N'2050-01-01' AS Date), 2, 0, 110, N'1')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'3', N'3', N'3333', N'寒寒', CAST(N'2050-01-01' AS Date), 3, 4, 112, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'4', N'4', N'44446', N'啦啦啦', CAST(N'2050-01-01' AS Date), 4, 0, 120, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'5', N'55', N'54345344446757', N'admin5', CAST(N'2050-01-01' AS Date), 3, 4, 511, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'7', N'7', N'', N'admin7', CAST(N'2050-01-01' AS Date), 3, 0, 509, N'0')
INSERT [dbo].[会员] ([编号], [密码], [身份证], [姓名], [有效期], [会员等级], [积分], [余额], [是否挂失]) VALUES (N'8', N'888', N'500107111122223333', N'admin8', CAST(N'2050-01-01' AS Date), 4, 4, 1009, N'0')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (1, N'白夜行', N'东野圭吾', N'南海出版社', 40, 20, 0, N'~/image/1.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (2, N'恶意', N'东野圭吾', N'南海出版社', 20, 10, 35, N'~/image/2.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (3, N'嫌疑人x的献身', N'东野圭吾', N'南海出版社', 35, 15, 11, N'~/image/3.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (4, N'解忧杂货铺', N'东野圭吾', N'南海出版社', 20, 10, 23, N'~/image/4.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (5, N'我以前死去的家', N'东野圭吾', N'南海出版社', 25, 14, 16, N'~/image/5.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (6, N'虚无的十字架', N'东野圭吾', N'南海出版社', 25, 18, 24, N'~/image/6.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (7, N'生命不能承受之轻', N'米兰·昆德拉', N'上海译文出版社', 39, 10, 28, N'~/image/7.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (8, N'告别圆舞曲', N'米兰·昆德拉', N'上海译文出版社', 25, 15, 30, N'~/image/8.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (9, N'不朽', N'米兰·昆德拉', N'上海译文出版社', 42, 12, 31, N'~/image/9.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (10, N'生活在别处', N'米兰·昆德拉', N'上海译文出版社', 35, 15, 32, N'~/image/10.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (11, N'追风筝的人', N'卡勒德·胡塞尼', N'上海人民出版社', 25, 10, 3, N'~/image/11.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (12, N'惊悚乐园1', N'三天两觉', N' 长江出版社', 27, 17, 8, N'~/image/111.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (13, N'惊悚乐园2', N'三天两觉', N' 长江出版社', 27, 17, 10, N'~/image/113.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (14, N'惊悚乐园3', N'三天两觉', N'长江出版社', 28, 18, 10, N'~/image/112.jpg')
INSERT [dbo].[图书] ([ISBN], [书名], [作者], [出版社], [售价], [进价], [库存], [图片]) VALUES (15, N'惊悚乐园4', N'三天两觉', N' 长江出版社', 29, 19, 10, N'~/image/114.jpg')
SET IDENTITY_INSERT [dbo].[图书进货] ON 

INSERT [dbo].[图书进货] ([流水号], [ISBN], [图书数量], [日期]) VALUES (1, 1, 2, CAST(N'2018-06-25T17:16:01.530' AS DateTime))
INSERT [dbo].[图书进货] ([流水号], [ISBN], [图书数量], [日期]) VALUES (2, 1, 20, CAST(N'2018-06-25T17:17:49.180' AS DateTime))
INSERT [dbo].[图书进货] ([流水号], [ISBN], [图书数量], [日期]) VALUES (3, 2, 20, CAST(N'2018-06-26T15:30:08.457' AS DateTime))
INSERT [dbo].[图书进货] ([流水号], [ISBN], [图书数量], [日期]) VALUES (4, 13, 10, CAST(N'2018-06-26T23:55:12.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[图书进货] OFF
SET IDENTITY_INSERT [dbo].[图书退货] ON 

INSERT [dbo].[图书退货] ([流水号], [ISBN], [图书数量], [日期], [退货价]) VALUES (1, 1, 20, CAST(N'2018-06-25T17:17:58.197' AS DateTime), 20)
INSERT [dbo].[图书退货] ([流水号], [ISBN], [图书数量], [日期], [退货价]) VALUES (2, 5, 7, CAST(N'2018-06-25T22:11:49.860' AS DateTime), 10)
INSERT [dbo].[图书退货] ([流水号], [ISBN], [图书数量], [日期], [退货价]) VALUES (3, 3, 6, CAST(N'2018-06-26T11:49:46.780' AS DateTime), 10)
INSERT [dbo].[图书退货] ([流水号], [ISBN], [图书数量], [日期], [退货价]) VALUES (4, 13, 10, CAST(N'2018-06-26T23:55:37.863' AS DateTime), 17)
SET IDENTITY_INSERT [dbo].[图书退货] OFF
SET IDENTITY_INSERT [dbo].[销售列表] ON 

INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (1, N'1              ', 1, CAST(N'2018-06-24T20:09:11.000' AS DateTime), 1, 400, 20)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (3, N'1              ', 6, CAST(N'2018-06-24T20:09:38.000' AS DateTime), 1, 240, 100)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (5, N'3              ', 0, CAST(N'2018-06-24T22:12:08.177' AS DateTime), 1, 0, 0)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (6, N'3              ', 9, CAST(N'2018-06-25T01:22:29.743' AS DateTime), 1, 35, 35)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (7, N'5              ', 2, CAST(N'2018-06-25T01:23:59.763' AS DateTime), 1, 50, 50)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (8, N'3              ', 2, CAST(N'2018-06-25T01:44:06.883' AS DateTime), 3, 70, 70)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (9, N'3              ', 2, CAST(N'2018-06-25T01:44:06.887' AS DateTime), 3, 70, 70)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (10, N'2              ', 1, CAST(N'2018-06-25T01:46:06.580' AS DateTime), 3, 20, 20)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (11, N'2              ', 3, CAST(N'2018-06-25T01:48:20.147' AS DateTime), 3, 60, 60)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (13, N'1              ', 1, CAST(N'2018-06-25T02:10:36.470' AS DateTime), 3, 40, 40)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (14, N'1              ', 2, CAST(N'2018-06-25T02:14:36.397' AS DateTime), 3, 80, 80)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (15, N'2              ', 1, CAST(N'2018-06-25T02:18:02.540' AS DateTime), 3, 20, 20)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (16, N'2              ', 1, CAST(N'2018-06-25T02:20:08.000' AS DateTime), 3, 20, 200)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (17, N'3              ', 2, CAST(N'2018-06-25T02:25:14.907' AS DateTime), 3, 70, 70)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (18, N'3              ', 2, CAST(N'2018-06-25T02:28:46.533' AS DateTime), 3, 70, 70)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (19, N'3              ', 2, CAST(N'2018-06-25T02:28:50.690' AS DateTime), 3, 70, 70)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (20, N'2              ', 1, CAST(N'2018-06-25T08:23:07.330' AS DateTime), 3, 20, 20)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (21, N'1              ', 1, CAST(N'2018-06-25T09:31:18.880' AS DateTime), 4, 40, 40)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (22, N'1              ', 1, CAST(N'2018-06-25T17:13:57.553' AS DateTime), 1, 40, 40)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (23, N'1              ', 1, CAST(N'2018-06-25T17:14:03.117' AS DateTime), 1, 40, 40)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (24, N'3              ', 1, CAST(N'2018-06-26T07:21:19.717' AS DateTime), 1, 35, 35)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (25, N'12             ', 2, CAST(N'2018-06-26T23:53:03.000' AS DateTime), 1, 55, 55)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (26, N'6              ', 1, CAST(N'2018-06-27T14:13:22.217' AS DateTime), 3, 25, 25)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (27, N'1              ', 20, CAST(N'2018-06-27T23:08:46.640' AS DateTime), 3, 800, 800)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (28, N'7              ', 1, CAST(N'2018-06-28T16:34:54.803' AS DateTime), 1, 39, 39)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (29, N'2              ', 5, CAST(N'2018-06-28T17:16:40.520' AS DateTime), 0, 100, 100)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (30, N'5              ', 4, CAST(N'2018-06-28T17:17:09.093' AS DateTime), 0, 100, 100)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (31, N'6              ', 1, CAST(N'2018-06-28T17:17:54.160' AS DateTime), 1, 25, 25)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (32, N'6              ', 1, CAST(N'2018-06-28T17:19:17.230' AS DateTime), 0, 25, 25)
INSERT [dbo].[销售列表] ([流水号], [图书], [数量], [时间], [会员编号], [金额], [积分]) VALUES (33, N'6              ', 1, CAST(N'2018-06-28T17:19:37.240' AS DateTime), 0, 25, 25)
SET IDENTITY_INSERT [dbo].[销售列表] OFF
ALTER TABLE [dbo].[会员] ADD  CONSTRAINT [DF_会员_会员等级]  DEFAULT ((2)) FOR [会员等级]
GO
ALTER TABLE [dbo].[会员] ADD  CONSTRAINT [DF_会员_积分]  DEFAULT ((0)) FOR [积分]
GO
ALTER TABLE [dbo].[会员] ADD  CONSTRAINT [DF_会员_余额]  DEFAULT ((0)) FOR [余额]
GO
ALTER TABLE [dbo].[会员] ADD  CONSTRAINT [DF_会员_是否挂失]  DEFAULT ((0)) FOR [是否挂失]
GO
ALTER TABLE [dbo].[图书进货] ADD  CONSTRAINT [DF_图书进货_日期]  DEFAULT (getdate()) FOR [日期]
GO
ALTER TABLE [dbo].[图书退货] ADD  CONSTRAINT [DF_图书退货_日期]  DEFAULT (getdate()) FOR [日期]
GO
ALTER TABLE [dbo].[销售列表] ADD  CONSTRAINT [DF_销售列表_时间]  DEFAULT (getdate()) FOR [时间]
GO
/****** Object:  StoredProcedure [dbo].[scoretomoney]    Script Date: 2018/6/28 20:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[scoretomoney]
	-- Add the parameters for the stored procedure here
AS
declare @编号 int,@会员等级 int,@余额 int,@积分 int,@整数 int,@小数 int
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	begin try  
    begin tran 
DECLARE vip_message CURSOR  FOR SELECT 编号,会员等级,余额,积分 FROM 会员 where 会员等级!=1
OPEN vip_message
fetch next from vip_message into @编号,@会员等级,@余额,@积分
while @@fetch_status<>-1
begin
if @会员等级=2
begin
select @小数=@积分%10,@整数=@积分/10
 update 会员 set 余额=余额+@整数,积分=@小数 where 编号=@编号;
end
if @会员等级=3
begin
select @小数=@积分%8,@整数=@积分/8
 update 会员 set 余额=余额+@整数,积分=@小数 where 编号=@编号;
end
if @会员等级=4
begin
select @小数=@积分%5,@整数=@积分/5
 update 会员 set 余额=余额+@整数,积分=@小数 where 编号=@编号;
end
fetch next from vip_message into @编号,@会员等级,@余额,@积分
end
close vip_message
deallocate vip_message
COMMIT TRAN  
end try   
begin catch   
    ROLLBACK  
end catch  

	SET NOCOUNT ON;

END
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
         Begin Table = "图书"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "图书进货"
            Begin Extent = 
               Top = 28
               Left = 361
               Bottom = 168
               Right = 503
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书进货单'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书进货单'
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
         Begin Table = "图书"
            Begin Extent = 
               Top = 11
               Left = 284
               Bottom = 163
               Right = 426
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "图书退货"
            Begin Extent = 
               Top = 33
               Left = 491
               Bottom = 174
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 1
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书退货单'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书退货单'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[34] 2[7] 3) )"
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
         Left = -51
      End
      Begin Tables = 
         Begin Table = "销售列表"
            Begin Extent = 
               Top = 12
               Left = 332
               Bottom = 152
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "图书"
            Begin Extent = 
               Top = 12
               Left = 521
               Bottom = 152
               Right = 663
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "会员"
            Begin Extent = 
               Top = 12
               Left = 151
               Bottom = 152
               Right = 294
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书销售单'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'图书销售单'
GO
