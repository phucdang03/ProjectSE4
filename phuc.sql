USE [master]
GO
/****** Object:  Database [PRJ_BookStore]    Script Date: 20/07/2023 10:56:10 ******/
CREATE DATABASE [PRJ_BookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRJ_BookStore', FILENAME = N'E:\SQL\MSSQL16.MSSQLSERVER\MSSQL\DATA\PRJ_BookStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRJ_BookStore_log', FILENAME = N'E:\SQL\MSSQL16.MSSQLSERVER\MSSQL\DATA\PRJ_BookStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PRJ_BookStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRJ_BookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRJ_BookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PRJ_BookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRJ_BookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRJ_BookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRJ_BookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRJ_BookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PRJ_BookStore] SET  MULTI_USER 
GO
ALTER DATABASE [PRJ_BookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRJ_BookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRJ_BookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRJ_BookStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRJ_BookStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRJ_BookStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PRJ_BookStore] SET QUERY_STORE = OFF
GO
USE [PRJ_BookStore]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 20/07/2023 10:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[fullname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [varchar](50) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[role] [int] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bills]    Script Date: 20/07/2023 10:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bills](
	[bid] [varchar](50) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[pid] [varchar](50) NOT NULL,
	[date] [datetime] NOT NULL,
	[amount] [int] NOT NULL,
	[total] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 20/07/2023 10:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[username] [nvarchar](50) NOT NULL,
	[pid] [varchar](50) NOT NULL,
	[amount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 20/07/2023 10:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[catid] [varchar](50) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[catid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 20/07/2023 10:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[pid] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[catid] [varchar](50) NOT NULL,
	[image] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([username], [password], [fullname], [email], [phone], [address], [role]) VALUES (N'admin', N'123', N'Đặng Vĩnh Phúc', N'admin@gmail.com', N'0974182365', N'Hola', 1)
INSERT [dbo].[Accounts] ([username], [password], [fullname], [email], [phone], [address], [role]) VALUES (N'user1', N'123', N'Phúc', N'phucdvhe170157@fpt.edu.vn', N'0974182365', N'abc', 2)
INSERT [dbo].[Accounts] ([username], [password], [fullname], [email], [phone], [address], [role]) VALUES (N'user2', N'123', N'Phúc', N'phucdvhe170157@fpt.edu.vn', N'0974182365', N'hanoi', 2)
GO
INSERT [dbo].[Bills] ([bid], [username], [pid], [date], [amount], [total]) VALUES (N'5f7c79e1-c78c-420a-9a2a-aa7905116b0c', N'user2', N'b1', CAST(N'2023-07-17T06:13:11.727' AS DateTime), 1, 28.399999618530273)
GO
INSERT [dbo].[Carts] ([username], [pid], [amount]) VALUES (N'user2', N'1984', 3)
INSERT [dbo].[Carts] ([username], [pid], [amount]) VALUES (N'admin', N'b1', 1)
INSERT [dbo].[Carts] ([username], [pid], [amount]) VALUES (N'user1', N'b1', 2)
INSERT [dbo].[Carts] ([username], [pid], [amount]) VALUES (N'user1', N'1984', 1)
INSERT [dbo].[Carts] ([username], [pid], [amount]) VALUES (N'user1', N'b2', 3)
GO
INSERT [dbo].[Categories] ([catid], [name]) VALUES (N'cat1', N'Literature')
INSERT [dbo].[Categories] ([catid], [name]) VALUES (N'cat2', N'Mystery')
INSERT [dbo].[Categories] ([catid], [name]) VALUES (N'cat3', N'Romance')
GO
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'1984', N'1984', N'A minor member of the ruling Party in near-future London, Winston Smith is a thin, frail, contemplative, intellectual, and fatalistic thirty-nine-year-old. Winston hates the totalitarian control and enforced repression that are characteristic of his government. He harbors revolutionary dreams.', 20.200000762939453, 10, N'cat1', N'1984.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b1', N'Romancing Mister Bridgerton (Bridgertons Book 4)', N'Everyone knows that Colin Bridgerton is the most charming man in London . . .Penelope Featherington has secretly adored her best friend''s brother for . . . well, it feels like forever. After half a lifetime of watching Colin Bridgerton from afar, she thinks she knows everything about him, until she stumbles across his deepest secret . . . and fears she doesn''t know him at all.Colin Bridgerton is tired of being thought of as nothing but an empty-headed charmer, tired of the notorious gossip columnist Lady Whistledown, who can''t seem to publish an edition without mentioning him. But when Colin returns to London from a trip abroad, he discovers nothing in his life is quite the sameÃÂ¢ÃÂÃÂespecially Penelope Featherington! The girl who was always simply there is suddenly the girl haunting his dreams. When he discovers that Penelope has secrets of her own, this elusive bachelor must decide . . . is she his biggest threatÃÂ¢ÃÂÃÂ or his promise of a happy ending?This novel includes the 2nd epilogue, a peek at the story after the story.', 28.399999618530273, 4, N'cat1', N'Literature1.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b10', N'The Secret Library', N'Everyone knows that Colin Bridgerton is the most charming man in London . . .Penelope Featherington has secretly adored her best friend''s brother for . . . well, it feels like forever. After half a lifetime of watching Colin Bridgerton from afar, she thinks she knows everything about him, until she stumbles across his deepest secret . . . and fears she doesn''t know him at all.Colin Bridgerton is tired of being thought of as nothing but an empty-headed charmer, tired of the notorious gossip columnist Lady Whistledown, who can''t seem to publish an edition without mentioning him. But when Colin returns to London from a trip abroad, he discovers nothing in his life is quite the sameÃÂ¢ÃÂÃÂespecially Penelope Featherington! The girl who was always simply there is suddenly the girl haunting his dreams. When he discovers that Penelope has secrets of her own, this elusive bachelor must decide . . . is she his biggest threatÃÂ¢ÃÂÃÂ or his promise of a happy ending?This novel includes the 2nd epilogue, a peek', 24, 10, N'cat1', N'literature.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b2', N'Let Me Tell You What I Mean', N'These twelve pieces from 1968 to 2000, never before gathered together, offer an illuminating glimpse into the mind and process of a legendary figure. They showcase Joan Didion''s incisive reporting, her empathetic gaze, and her role as "an articulate witness to the most stubborn and intractable truths of our time" (The New York Times Book Review).

Here, Didion touches on topics ranging from newspapers ("the problem is not so much whether one trusts the news as to whether one finds it"), to the fantasy of San Simeon, to not getting into Stanford. In "Why I Write," Didion ponders the act of writing: "I write entirely to find out what I''m thinking, what I''m looking at, what I see and what it means." From her admiration for Hemingway''s sentences to her acknowledgment that Martha Stewart''s story is one "that has historically encouraged women in this country, even as it has threatened men," these essays are acutely and brilliantly observed. Each piece is classic Didion: incisive, bemused, and stunningly prescient.', 14.41, 0, N'cat1', N'Literature2.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b3', N'Mike Nichols: A Life', N'Mike Nichols burst onto the scene as a wunderkind: while still in his twenties, he was half of a hit improv duo with Elaine May that was the talk of the country. Next he directed four consecutive hit plays, won back-to-back Tonys, ushered in a new era of Hollywood moviemaking with Who''s Afraid of Virginia Woolf?, and followed it with The Graduate, which won him an Oscar and became the third-highest-grossing movie ever. At thirty-five, he lived in a three-story Central Park West penthouse, drove a Rolls-Royce, collected Arabian horses, and counted Jacqueline Kennedy, Elizabeth Taylor, Leonard Bernstein, and Richard Avedon as friends.

Where he arrived is even more astonishing given where he had begun: born Igor Peschkowsky to a Jewish couple in Berlin in 1931, he was sent along with his younger brother to America on a ship in 1939. The young immigrant boy caught very few breaks. He was bullied and ostracized--an allergic reaction had rendered him permanently hairless--and his father died when he was just twelve, leaving his mother alone and overwhelmed.

The gulf between these two sets of facts explains a great deal about Nichols''s transformation from lonely outsider to the center of more than one cultural universe--the acute powers of observation that first made him famous; the nourishment he drew from his creative partnerships, most enduringly with May; his unquenchable drive; his hunger for security and status; and the depressions and self-medications that brought him to terrible lows. It would take decades for him to come to grips with his demons. In an incomparable portrait that follows Nichols from Berlin to New York to Chicago to Hollywood, Mark Harris explores, with brilliantly vivid detail and insight, the life, work, struggle, and passion of an artist and man in constant motion. Among the 250 people Harris interviewed: Elaine May, Meryl Streep, Stephen Sondheim, Robert Redford, Glenn Close, Tom Hanks, Candice Bergen, Emma Thompson, Annette Bening, Natalie Portman, Julia Roberts, Lorne Michaels, and Gloria Steinem.

Mark Harris gives an intimate and evenhanded accounting of success and failure alike; the portrait is not always flattering, but its ultimate impact is to present the full story of one of the most richly interesting, complicated, and consequential figures the worlds of theater and motion pictures have ever seen. It is a triumph of the biographer''s art.', 25.26, 6, N'cat1', N'Literature3.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b4', N'Ready Player Two: A Novel', N'AN UNEXPECTED QUEST. TWO WORLDS AT STAKE. ARE YOU READY?

Days after winning OASIS founder James Halliday’s contest, Wade Watts makes a discovery that changes everything.

Hidden within Halliday’s vaults, waiting for his heir to find, lies a technological advancement that will once again change the world and make the OASIS a thousand times more wondrous—and addictive—than even Wade dreamed possible.
 
With it comes a new riddle, and a new quest—a last Easter egg from Halliday, hinting at a mysterious prize.
 
And an unexpected, impossibly powerful, and dangerous new rival awaits, one who’ll kill millions to get what he wants.
 
Wade’s life and the future of the OASIS are again at stake, but this time the fate of humanity also hangs in the balance.
 
Lovingly nostalgic and wildly original as only Ernest Cline could conceive it, Ready Player Two takes us on another imaginative, fun, action-packed adventure through his beloved virtual universe, and jolts us thrillingly into the future once again.', 13.18, 10, N'cat2', N'Mystery1.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b5', N'A Time for Mercy (Jake Brigance)', N'Clanton, Mississippi. 1990. Jake Brigance finds himself embroiled in a deeply divisive trial when the court appoints him attorney for Drew Gamble, a timid sixteen-year-old boy accused of murdering a local deputy. Many in Clanton want a swift trial and the death penalty, but Brigance digs in and discovers that there is more to the story than meets the eye. Jake’s fierce commitment to saving Drew from the gas chamber puts his career, his financial security, and the safety of his family on the line.
 
In what may be the most personal and accomplished legal thriller of John Grisham’s storied career, we deepen our acquaintance with the iconic Southern town of Clanton and the vivid cast of characters that so many readers know and cherish. The result is a richly rewarding novel that is both timely and timeless, full of wit, drama, and—most of all—heart.
 
Bursting with all the courthouse scheming, small-town intrigue, and stunning plot twists that have become the hallmarks of the master of the legal thriller, A Time for Mercy is John Grisham’s most powerful courtroom drama yet.
 
There is a time to kill and a time for justice. Now comes A Time for Mercy.', 11.91, 9, N'cat2', N'Mystery2.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b6', N'Verity', N'Lowen Ashleigh is a struggling writer on the brink of financial ruin. When Jeremy Crawford, husband of bestselling author Verity Crawford, asks Lowen to complete the remaining books in a contract his permanently injured wife is unable to fulfill, Lowen has no choice but to accept. Lowen arrives at the Crawford home with the intention of only staying one or two nights—long enough to sort through Verity’s chaotic home office to collect all the notes and outlines she’ll need to start writing the first novel. But the more time Lowen spends with Jeremy Crawford, the less of a hurry she is in to leave. While there, Lowen uncovers a hidden manuscript. An autobiography containing chilling admissions Verity planned to take to her grave, including the truth behind the events that turned their lives upside down. A truth that, if revealed to Jeremy, would further devastate the already grieving father. Lowen decides to keep the manuscript a secret, allowing Jeremy to continue to believe Verity is merely an innocent, unfortunate victim of circumstance. But as Lowen’s feelings for the devoted father and husband deepen, she wonders if keeping Jeremy in the dark is in her own best interest. After all, if Jeremy were to read his wife’s autobiography, the disturbing truth would make it impossible for him to continue to love her. A chilling romantic thriller from #1 New York Times bestselling author Colleen Hoover.', 13.49, 10, N'cat2', N'Mystery3.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b7', N'From Blood and Ash', N'A Maiden…

Chosen from birth to usher in a new era, Poppy’s life has never been her own. The life of the Maiden is solitary. Never to be touched. Never to be looked upon. Never to be spoken to. Never to experience pleasure. Waiting for the day of her Ascension, she would rather be with the guards, fighting back the evil that took her family, than preparing to be found worthy by the gods. But the choice has never been hers.

A Duty…

The entire kingdom’s future rests on Poppy’s shoulders, something she’s not even quite sure she wants for herself. Because a Maiden has a heart. And a soul. And longing. And when Hawke, a golden-eyed guard honor bound to ensure her Ascension, enters her life, destiny and duty become tangled with desire and need. He incites her anger, makes her question everything she believes in, and tempts her with the forbidden.

A Kingdom…

Forsaken by the gods and feared by mortals, a fallen kingdom is rising once more, determined to take back what they believe is theirs through violence and vengeance. And as the shadow of those cursed draws closer, the line between what is forbidden and what is right becomes blurred. Poppy is not only on the verge of losing her heart and being found unworthy by the gods, but also her life when every blood-soaked thread that holds her world together begins to unravel.', 13.86, 10, N'cat3', N'Romance1.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b8', N'All About Love: New Visions', N'“The word ‘love’ is most often defined as a noun, yet we would all love better if we used it as a verb,” writes bell hooks as she comes out fighting and on fire in All About Love. Here, at her most provocative and intensely personal, renowned scholar, cultural critic and feminist bell hooks offers a proactive new ethic for a society bereft with lovelessness--not the lack of romance, but the lack of care, compassion, and unity. People are divided, she declares, by society’s failure to provide a model for learning to love. 

As bell hooks uses her incisive mind to explore the question “What is love?” her answers strike at both the mind and heart. Razing the cultural paradigm that the ideal love is infused with sex and desire, she provides a new path to love that is sacred, redemptive, and healing for individuals and for a nation. The Utne Reader declared bell hooks one of the “100 Visionaries Who Can Change Your Life.” All About Love is a powerful, timely affirmation of just how profoundly her revelations can change hearts and minds for the better. ', 9.25, 10, N'cat3', N'Romance2.jpg')
INSERT [dbo].[Products] ([pid], [name], [description], [price], [quantity], [catid], [image]) VALUES (N'b9', N'It Ends with Us: A Novel', N'Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up—she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.

Ryle is assertive, stubborn, maybe even a little arrogant. He’s also sensitive, brilliant, and has a total soft spot for Lily. And the way he looks in scrubs certainly doesn’t hurt. Lily can’t get him out of her head. But Ryle’s complete aversion to relationships is disturbing. Even as Lily finds herself becoming the exception to his “no dating” rule, she can’t help but wonder what made him that way in the first place.

As questions about her new relationship overwhelm her, so do thoughts of Atlas Corrigan—her first love and a link to the past she left behind. He was her kindred spirit, her protector. When Atlas suddenly reappears, everything Lily has built with Ryle is threatened.', 10.59, 10, N'cat3', N'Romance3.jpg')
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Accounts] FOREIGN KEY([username])
REFERENCES [dbo].[Accounts] ([username])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK_Bills_Accounts]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Products] FOREIGN KEY([pid])
REFERENCES [dbo].[Products] ([pid])
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK_Bills_Products]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Accounts] FOREIGN KEY([username])
REFERENCES [dbo].[Accounts] ([username])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Accounts]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Products] FOREIGN KEY([pid])
REFERENCES [dbo].[Products] ([pid])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([catid])
REFERENCES [dbo].[Categories] ([catid])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
USE [master]
GO
ALTER DATABASE [PRJ_BookStore] SET  READ_WRITE 
GO
