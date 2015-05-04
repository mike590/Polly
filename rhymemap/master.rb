require "pry"
# french, branch, conch, punch, world
@test = {
  0 => {
    prim: ["ˈau", "ˌau"], sec: []
    },
  1 => {
    prim: ["ˈoint", 'ˌoint'], sec: [9]
    },
  2 => {
    prim: ["ˈoil"], sec: []
    },
  3 => {
    prim: ["ˈoi", "ˌoi"], sec: []
    },
  4 => {
    prim: ["ənt"], sec: [10]
    },
  5 => {
    prim: ["ənts"], sec: []
    },
  6 => {
    prim: ["ˈəb"], sec: [22, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21]
    },
  7 => {
    prim: ["ˈəf"], sec: [13, 68]
    },
  8 => {
    prim: ["ˈəl"], sec: [23, 24]
    },
  9 => {
    prim: ["ˈois"], sec: [1]
    },
  10 => {
    prim: ["ət"], sec: [4]
    },
  11 => {
    prim: ["ˈəd"], sec: [6, 23, 12, 14, 15, 16, 17, 18, 19, 20, 21]
    },
  12 => {
    prim: ["ˈəg", "əg"], sec: [6, 11, 23, 14, 15, 16, 17, 18, 19, 20, 21]
    },
  13 => {
    prim: ["əs"], sec: [7]
    },
  14 => {
    prim: ["ˈwən"], sec: [6, 11, 12, 23, 15, 16, 17, 18, 19, 20, 21]
    },
  15 => {
    prim: ["əŋ"], sec: [6, 11, 12, 14, 23, 16, 17, 18, 19, 20, 21]
    },
  16 => {
    prim: ["ˌək"], sec: [6, 11, 12, 14, 15, 23, 17, 18, 19, 20, 21]
    },
  17 => {
    prim: ["ˈək", "ək"], sec: [6, 11, 12, 14, 15, 16, 23, 18, 19, 20, 21]
    },
  18 => {
    prim: ["ˈəp"], sec: [6, 11, 12, 14, 15, 16, 17, 23, 19, 20, 21]
    },
  19 => {
    prim: ["əm", "ˈən"], sec: [6, 11, 12, 14, 15, 16, 17, 18, 23, 20, 21]
    },
  20 => {
    prim: ["ˈəv", "əv"], sec: [6, 11, 12, 14, 15, 16, 17, 18, 19, 23, 21, 68]
    },
  21 => {
    prim: ["ˈəz"], sec: [6, 11, 12, 14, 15, 16, 17, 18, 19, 20, 23]
    },
  22 => {
    prim: ["əl"], sec: [8, 24, 68]
    },
  23 => {
    prim: ["ˈə", "ə"], sec: [6, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 63]
    },
  24 => {
    prim: ["ᵊl"], sec: [8, 23]
    },
  25 => {
    prim: ["ᵊm"], sec: []
    },
  26 => {
    prim: ["ᵊn"], sec: [27]
    },
  27 => {
    prim: ["ᵊŋ"], sec: [26]
    },
  28 => {
    prim: ["ˈās", "ˌās"], sec: [41, 35]
    },
  29 => {
    prim: ["ˈād", "ˌād"], sec: [42, 35, 30, 31, 32, 33, 34]
    },
  30 => {
    prim: ["ˈāf", "ˌāf"], sec: [42, 29, 35, 31, 32, 33, 34]
    },
  31 => {
    prim: ["ˈāk"], sec: [42, 29, 30, 35, 32, 33, 34]
    },
  32 => {
    prim: ["ˈāp", "ˌāp"], sec: [42, 29, 30, 31, 35, 33, 34]
    },
  33 => {
    prim: ["ˈāt", "ˌāt"], sec: [42, 29, 30, 31, 32, 35, 34]
    },
  34 => {
    prim: ["ˈāv"], sec: [42, 29, 30, 31, 32, 33, 35]
    },
  35 => {
    prim: ["ˈāz"], sec: [42, 29, 30, 31, 32, 33, 34, 41, 28]
    },
  36 => {
    prim: ["ˈāl", "ˌāl"], sec: []
    },
  37 => {
    prim: ["ˈānd", "ˌānd"], sec: []
    },
  38 => {
    prim: ["ˈām", "ˌām", "ˈān"], sec: [39]
    },
  39 => {
    prim: ["ˌān"], sec: [38]
    },
  40 => {
    prim: ["ˈāsh"], sec: []
    },
  41 => {
    prim: ["ˈāst"], sec: [28, 35]
    },
  42 => {
    prim: ["ˈā", "ˌā"], sec: [35, 29, 30, 31, 32, 33, 34]
    },
  43 => {
    prim: ["ˈä~"], sec: []
    },
  44 => {
    prim: ["ˈäb", "ˈäd"], sec: [52, 45, 46, 47]
    },
  45 => {
    prim: ["ˈäm", "ˌäm", "ˈän", "ˌän", "ˈäŋ"], sec: [52, 44, 46, 47]
    },
  46 => {
    prim: ["ˈäp", "ˌäp"], sec: [52, 44, 45, 47]
    },
  47 => {
    prim: ["ˈäs"], sec: [52, 44, 45, 46, 48]
    },
  48 => {
    prim: ["ˈäk"], sec: [47]
    },
  49 => {
    prim: ["ˈälv"], sec: []
    },
  50 => {
    prim: ["ˈär", "ˌär", "är"], sec: []
    },
  51 => {
    prim: ["ˈät", "ˌät", "ät"], sec: []
    },
  52 => {
    prim: ["ä", "ˈä", "ˌä"], sec: [44, 45, 46, 47]
    },
  53 => {
    prim: ["ˈab"], sec: [54, 55, 56, 57, 58]
    },
  54 => {
    prim: ["ˈad"], sec: [53, 55, 56, 57, 58]
    },
  55 => {
    prim: ["ˈaf", "ˌaf"], sec: [54, 53, 56, 57, 58]
    },
  56 => {
    prim: ["ˈag", "ˈak", "ˌak", "ak"], sec: [54, 55, 53, 57, 58]
    },
  57 => {
    prim: ["ˈav", "ˌav", ], sec: [54, 55, 56, 53, 58, 59, 60]
    },
  58 => {
    prim: ["ˌaz", "az"], sec: [54, 55, 56, 57, 53, 59, 61]
    },
  59 => {
    prim: ["ˈash"], sec: [57, 58, 60, 61]
    },
  60 => {
    prim: ["ˈath"], sec: [57]
    },
  61 => {
    prim: ["ˈas", "ˌas"], sec: [58, 59]
    },
  62 => {
    prim: ["ˈat", "ˌat"], sec: [67]
    },
  63 => {
    prim: ["ˈal"], sec: [23]
    },
  64 => {
    prim: ["ˈants", "ˌants"], sec: []
    },
  65 => {
    prim: ["ˈam", "ˌam", "am", "ˈan", "ˌan"], sec: []
    },
  66 => {
    prim: ["ˈaŋ", "ˌaŋ"], sec: []
    },
  67 => {
    prim: ["ˈap"], sec: [62]
    },
  68 => {
    prim: ["ˈa", "ˌa", "a"], sec: [7, 20, 22]
    },
  69 => {
    prim: ["ēb", "ˈēd", "ˌēd", "ēd"], sec: [70, 72, 73, 75, 76, 77, 78, 81]
    },
  70 => {
    prim: ["ˈē~"], sec: [69, 72, 76, 77]
    },
  71 => {
    prim: ["ˈēk"], sec: []
    },
  72 => {
    prim: ["ˈēm", "ˈēn", "ˌēn"], sec: [70, 69, 78, 81]
    },
  73 => {
    prim: ["ˈēp"], sec: [69, 75, 76, 77, 78, 81]
    },
  74 => {
    prim: ["ˈēs", "ˌēs"], sec: [75, 76, 77, 78, 81]
    },
  75 => {
    prim: ["ˈēt"], sec: [73, 74, 69, 78, 81]
    },
  76 => {
    prim: ["ˈēv"], sec: [70, 72, 74, 69, 77, 78, 81]
    },
  77 => {
    prim: ["ˈēz"], sec: [70, 72, 74, 76, 69, 78, 81]
    },
  78 => {
    prim: ["ˈēf"], sec: [72, 73, 74, 75, 76, 77, 69, 81]
    },
  79 => {
    prim: ["ˈēl", "ˌēl"], sec: []
    },
  80 => {
    prim: ["ē"], sec: [79]
    },
  81 => {
    prim: ["ˈē", "ˌē"], sec: [72, 73, 74, 75, 76, 77, 78, 69, 80]
    },
  82 => {
    prim: ["ˈed", "ˌed"], sec: [82, 83, 84, 86, 88, 89, 90, 91, 92, 98]
    },
  83 => {
    prim: ["ˈeb"], sec: [82, 83, 84, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  84 => {
    prim: ["ˈeg", "ˌeg", "ˌeg", "ˌek", "ek"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 94, 98]
    },
  85 => {
    prim: ["ˈep", "ˌep"], sec: [84, 85, 86, 87, 88, 89, 92, 98]
    },
  86 => {
    prim: ["ˈem", "ˈen", "ˌen"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  87 => {
    prim: ["ˈesh"], sec: [82, 84, 85, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  88 => {
    prim: ["ˈes", "ˌes"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  89 => {
    prim: ["ˈet"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 94, 98]
    },
  90 => {
    prim: ["ˈev"], sec: [82, 83, 84, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  91 => {
    prim: ["ˈez"], sec: [82, 83, 84, 86, 87, 88, 89, 90, 91, 92, 98]
    },
  92 => {
    prim: ["ˈef"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 98]
    },
  93 => {
    prim: ["ˈeŋ"], sec: []
    },
  94 => {
    prim: ["ˈekst", "ˌekst"], sec: [84, 89]
    },
  95 => {
    prim: ["ˈel", "ˌel"], sec: []
    },
  96 => {
    prim: ["ˈer", "ˌer"], sec: []
    },
  97 => {
    prim: ["ek"], sec: []
    },
  98 => {
    prim: ["ˈe", "ˌe", "e"], sec: [82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92]
    },
  99 => {
    prim: ["ˈīb", "ˈīd", "ˌīd", "ˈīv", "ˌīv"], sec: [100, 101, 109]
    },
  100 => {
    prim: ["ˈīm", "ˈīn", "ˌīn"], sec: [99, 101]
    },
  101 => {
    prim: ["ˌīz", "ˌīz"], sec: [99, 100, 109]
    },
  102 => {
    prim: ["ˈīf"], sec: []
    },
  103 => {
    prim: ["ˈīk", "ˌīk"], sec: [106]
    },
  104 => {
    prim: ["ˈīp"], sec: [106]
    },
  105 => {
    prim: ["ˈīs"], sec: []
    },
  106 => {
    prim: ["ˈīt", "ˌīt"], sec: [103, 104]
    },
  107 => {
    prim: ["ˈīl"], sec: []
    },
  108 => {
    prim: ["ˈīr"], sec: []
    },
  109 => {
    prim: ["ˈī", "ˌī", "ī"], sec: [99, 101]
    },
  110 => {
    prim: ["ˈid", "ˌid"], sec: [111, 112]
    },
  111 => {
    prim: ["ˈig", "ig" ], sec: [110, 112]
    },
  112 => {
    prim: ["ˈik", "ik"], sec: [110, 111, 113, 126]
    },
  113 => {
    prim: ["ˈif", "ˌif"], sec: [112, 114]
    },
  114 => {
    prim: ["ˈip", "ˌip"], sec: [113, 126]
    },
  115 => {
    prim: ["ˈiks", "ˌiks", "iks"], sec: [116]
    },
  116 => {
    prim: ["ˈis", "ˌis", "is"], sec: [115]
    },
  117 => {
    prim: ["ˈild"], sec: [118, 119]
    },
  118 => {
    prim: ["ˈilm"], sec: [117, 119]
    },
  119 => {
    prim: ["ˈil", "ˌil"], sec: [117, 118]
    },
  120 => {
    prim: ["ˈim", "im", "ˈin", "ˌin", "in"], sec: []
    },
  121 => {
    prim: ["ˈiŋ", "ˌiŋ", "iŋ"], sec: []
    },
  122 => {
    prim: ["ˈir", "ˌir"], sec: []
    },
  123 => {
    prim: ["ˈith", "ˌith", "ˌiv", "iv"], sec: [124]
    },
  124 => {
      prim: ["ˌiz", "iz", "ˈiz"], sec: [123]
    },
  125 => {
    prim: ["ˈit", "ˌit", "it"], sec: []
    },
  126 => {
    prim: ["ˈi", "ˌi", "i"], sec: [112, 114]
    },
  127 => {
    prim: ["ˈōb", "ˈōd"], sec: [128, 134, 135]
    },
  128 => {
    prim: ["ˈō~"], sec: [127, 134, 135]
    },
  129 => {
    prim: ["ˈōl", "ˌōl"], sec: []
    },
  130 => {
    prim: ["ˈōm", "ˈōn", "ˌōn"], sec: []
    },
  131 => {
    prim: ["ˈōk"], sec: [132, 133]
    },
  132 => {
    prim: ["ˈōp"], sec: [131, 133]
    },
  133 => {
    prim: ["ˈōt", "ˌōt"], sec: [131, 132]
    },
  134 => {
    prim: ["ˈōv"], sec: [135, 127, 128]
    },
  135 => {
    prim: ["ˈōz"], sec: [134, 127, 128]
    },
  136 => {
    prim: ["ˈȯf", "ˌȯf"], sec: [135]
    },
  137 => {
    prim: ["ˈȯg", "ˌȯg"], sec: [136]
    },
  138 => {
    prim: ["ˈȯs", "ˌȯs", "ˈȯs"], sec: [139]
    },
  139 => {
    prim: ["ˈȯls", "ˈȯlts"], sec: [138]
    },
  140 => {
    prim: ["ˈȯk"], sec: []
    },
  141 => {
    prim: ["ˈȯl", "ˌȯl"], sec: []
    },
  142 => {
    prim: ["ˈȯt", "ˌȯt"], sec: []
    },
  143 => {
    prim: ["ˈȯn", "ˌȯn"], sec: []
    },
  144 => {
    prim: ["ˈȯŋ", "ˌȯŋ"], sec: []
    },
  145 => {
    prim: ["ˈȯr", "ˌȯr", "ȯr"], sec: []
    },
  146 => {
    prim: ["ˈȯ", "ˌȯ"], sec: [147]
    },
  147 => {
    prim: ["ˈȯd"], sec: [146]
    },
  148 => {
    prim: ["ˈül"], sec: []
    },
  149 => {
    prim: ["ˈüm", "ˈün"], sec: [156]
    },
  150 => {
    prim: ["ˈüd", "ˌüd"], sec: [153, 156]
    },
  151 => {
    prim: ["ˈüf", "ˈüth"], sec: [152, 153, 154, 156]
    },
  152 => {
    prim: ["ˈüp", "ˌüp"], sec: [151, 153, 154, 155]
    },
  153 => {
    prim: ["ˈüs", "ˌüs", "üs", "ˈüz", "üz"], sec: [150, 151, 152, 154, 156]
    },
  154 => {
    prim: ["ˈüv"], sec: [151, 152, 153, 156]
    },
  155 => {
    prim: ["ˈüt", "ˌüt"], sec: [152]
    },
  156 => {
    prim: ["ˈü", "ˌü", "ü"], sec: [150, 149, 151, 153, 154]
    },
  157 => {
    prim: ["ˈud"], sec: [158]
    },
  158 => {
    prim: ["ˈuk"], sec: [157]
    },
  159 => {
    prim: ["ˈul", "ˌul"], sec: []
    },
  160 => {
    prim: ["ˈur", "ˌur"], sec: []
    },
  161 => {
    prim: ["ˈu", "ˌu"], sec: []
    }
}
