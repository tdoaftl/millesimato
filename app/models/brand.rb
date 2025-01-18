class Brand < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
# ----------スポーツ系--------------------
    { id: 2, name: 'NIKE' },
    { id: 3, name: 'adidas' },
    { id: 4, name: 'Champion' },
    { id: 5, name: 'FILA' },
    { id: 6, name: 'CONVERSE' },
    { id: 7, name: 'Reebok' },
# ----------アメカジ系--------------------
    { id: 8, name: 'Levi’s' },
    { id: 9, name: 'Lee' },
    { id: 10, name: 'Wrangler' },
    { id: 11, name: 'POLO RALPH LAUREN' },
    { id: 12, name: 'Schott' },
    { id: 13, name: 'Red Wing' },
# ----------トラッド--------------------
    { id: 14, name: 'Burberry' },
    { id: 15, name: 'Lacoste' },
    { id: 16, name: 'Dr. Martens' },
# ----------ハイブランド--------------------
    { id: 17, name: 'Chanel' },
    { id: 18, name: 'Dior' },
    { id: 19, name: 'Gucci' },
    { id: 20, name: 'Louis Vuitton' },
    { id: 21, name: 'Hermès' },
    { id: 22, name: 'Yves Saint Laurent (YSL)' },
    { id: 23, name: 'Prada' },
# ----------ドメスティック-------------------
    { id: 24, name: 'Porter' },
    { id: 25, name: 'Undercover' },
    { id: 26, name: 'Comme des Garçons' },
    { id: 27, name: 'Yohji Yamamoto' },
# ----------ITを取り入れた架空のブランド-------------------
    { id: 28, name: 'Code & Couture' },
    { id: 29, name: 'Threadware' },
    { id: 30, name: 'Pixel Fabric' },
    { id: 31, name: 'Binary Mode' },
    { id: 32, name: 'Syntax Street' },
    { id: 33, name: 'Cloud Nine Wardrobe' },
    { id: 34, name: 'Digital Loom' },
    { id: 35, name: 'Neural Thread' },
    { id: 36, name: 'API Apparel' },
    { id: 37, name: 'Cache Couture' },
    { id: 38, name: 'Quantum Stitch' },
    { id: 39, name: 'Fiberoptic Wear' },
    { id: 40, name: 'HoloThread' },
    { id: 41, name: 'Datapath Denim' },
    { id: 42, name: 'Virtual Vogue' },
    { id: 43, name: 'Loop Label' },
    { id: 44, name: 'Compile Clothing' },
    { id: 45, name: 'Array Wardrobe' },
    { id: 46, name: 'Buffer Basics' },
    { id: 47, name: 'Logic Line' },
    { id: 48, name: 'Maison Hogefuga' }
  ]

  include ActiveHash::Associations
  has_many :clothings

 end
