class MagicGifBall
  # +/- indicate positive or negative so it's easy to make sure the yes/no ratio is sane
  OPTIONS = [
    "http://38.media.tumblr.com/49d3df121ca71946c2027366e79ab8e1/tumblr_n7qulhalqW1tdjuqvo1_400.gif", # perfect +
    "http://38.media.tumblr.com/6fc40d94b45dc08b2193902bdf3764cb/tumblr_n9sbbaHJIO1smcbm7o1_250.gif", # okay +
    "http://38.media.tumblr.com/6c278dac50e8e8a35a763ac79b6c7074/tumblr_ndn9r6FmdZ1rxhp7xo1_500.gif", # thumbs up +
    "http://25.media.tumblr.com/47839447fd99f1b6c19809fa19181dbb/tumblr_mus41srzPi1s0my1wo1_400.gif", # ill allow it +
    "http://i.imgur.com/C5z2O34.gif", # nope -
    "http://i.imgur.com/OLKsi0u.gif", # hell no -
    "http://38.media.tumblr.com/e3c78b30a45880641c8c9628322b348c/tumblr_nj2mn44VQN1u0i9lpo1_500.gif", # head shake no -
    "http://33.media.tumblr.com/f96c0a0f3e3dc98eae9981963e969c39/tumblr_n7gih3iCYq1smcbm7o1_500.gif", # crying mariah no -
    "http://24.media.tumblr.com/32eeead7f6204467427ab38b5bfca735/tumblr_n5kkb0Y1HQ1qlipi4o1_500.gif", # crying bieber no -
    "http://38.media.tumblr.com/tumblr_m6rtc6nzaX1ravhmgo1_500.gif", # jlaw thumbs up +
    "http://31.media.tumblr.com/0853bcc2f883a608baac7452f7e00645/tumblr_n3esliOenA1smcbm7o1_250.gif", # fred savage thumbs up +
    "http://media.tumblr.com/tumblr_lrsq0uE0jP1qafrh6.gif", # barney stinson thumbs up +
    "http://media.tumblr.com/tumblr_mf0tvtSYdP1rbe9qf.gif", # madea hell yeah +
    "http://24.media.tumblr.com/799e55b69ba9d306c0a8ca9a99fe5b51/tumblr_mvoluhDMDv1qdx7lto1_400.gif", # hell no -
    "http://25.media.tumblr.com/e905b605904dd8e5d46d6736151f08de/tumblr_mz1nc6Dxsa1r8s5bto1_500.gif", # gross -
    "http://33.media.tumblr.com/e720f54dc1364f29326e02c05f729769/tumblr_n71sq2vcXy1smcbm7o1_500.gif", # yeah baby +
    "http://38.media.tumblr.com/c49328274dab836eaf3f8583fff1b4c2/tumblr_nqkfi7E5B51ru5h8co1_540.gif", # fuck yeah +
    "http://i.imgur.com/ScvTI1d.gif", # leslie knope no -
    "http://31.media.tumblr.com/tumblr_mcsnp67iCM1qdntjwo1_250.gif", # keyboard nope -
    "http://media.tumblr.com/c8705f689636d5ef138e6cf49453025b/tumblr_inline_mrdkovXnvh1qz4rgp.gif", # head shake no -
  ]

  def self.shake
    OPTIONS.shuffle.shift
  end
end
